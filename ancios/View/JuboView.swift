import SwiftUI

struct JuboView: View {
    @State private var urls: [String] = []
    @State private var isLoading = false
    @State private var error: Error?

    var body: some View {
        VStack {
            if isLoading {
                ProgressView("Loading...")
            } else if let error = error {
                Text("Error: \(error.localizedDescription)")
            } else if urls.isEmpty {
                Text("No jubo images available")
            } else {
                ZoomableImageView(imageURL: urls[0], imageURL2: urls[1])
            }
        }
        .navigationTitle("주보")
        .onAppear {
            fetchUrls()
        }
    }

    private func fetchUrls() {
        isLoading = true
        ChurchAPI.shared.getJubo() { result in
            DispatchQueue.main.async {
                isLoading = false
                switch result {
                case .success(let fetchedUrls):
                    self.urls = fetchedUrls
                case .failure(let fetchError):
                    self.error = fetchError
                }
            }
        }
    }
}

struct ZoomableImageView: View {
    let imageURL: String
    let imageURL2: String
    
    @State private var scale: CGFloat = 1.0
    @State private var offset: CGSize = .zero
    @State private var lastOffset: CGSize = .zero
    @State private var image1Size: CGSize = .zero
    @State private var image2Size: CGSize = .zero

    private let minScale: CGFloat = 1.0
    private let maxScale: CGFloat = 3.0

    var body: some View {
        GeometryReader { geometry in
            ScrollView([.horizontal, .vertical], showsIndicators: false) {
                VStack(spacing: 0) {
                    zoomableImage(url: imageURL, size: $image1Size)
                    zoomableImage(url: imageURL2, size: $image2Size)
                }
                .background(GeometryReader { contentGeometry in
                    Color.clear.onAppear {
                        // Adjust the offset to ensure the content is scrollable
                        validateOffset(contentGeometry: contentGeometry, parentGeometry: geometry)
                    }
                })
                .frame(
                    width: geometry.size.width * scale,
                    height: totalImageHeight * scale
                )
                .scaleEffect(scale)
                .offset(x: offset.width, y: offset.height)
                .gesture(
                    SimultaneousGesture(
                        MagnificationGesture()
                            .onChanged { value in
                                scale = min(max(scale * value, minScale), maxScale)
                            }
                            .onEnded { _ in
                                validateOffset(contentGeometry: geometry, parentGeometry: geometry)
                            },
                        DragGesture()
                            .onChanged { value in
                                offset = CGSize(
                                    width: value.translation.width + lastOffset.width,
                                    height: value.translation.height + lastOffset.height
                                )
                            }
                            .onEnded { _ in
                                lastOffset = offset
                                validateOffset(contentGeometry: geometry, parentGeometry: geometry)
                            }
                    )
                )
            }
            .gesture(
                TapGesture(count: 2)
                    .onEnded {
                        withAnimation {
                            if scale > minScale {
                                scale = minScale
                                offset = .zero
                            } else {
                                scale = min(maxScale, scale * 2)
                            }
                            lastOffset = offset
                        }
                    }
            )
        }
    }
    
    private var totalImageHeight: CGFloat {
        let aspectRatio1 = image1Size.width / max(image1Size.height, 1)
        let aspectRatio2 = image2Size.width / max(image2Size.height, 1)
        let height1 = UIScreen.main.bounds.width / aspectRatio1
        let height2 = UIScreen.main.bounds.width / aspectRatio2
        return height1 + height2
    }
    
    private func zoomableImage(url: String, size: Binding<CGSize>) -> some View {
        AsyncImage(url: URL(string: url)) { phase in
            switch phase {
            case .empty:
                ProgressView()
            case .success(let image):
                image
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .background(GeometryReader { geometry in
                        Color.clear.onAppear {
                            size.wrappedValue = geometry.size
                        }
                    })
            case .failure:
                Text("Failed to load image")
            @unknown default:
                EmptyView()
            }
        }
    }

    private func validateOffset(contentGeometry: GeometryProxy, parentGeometry: GeometryProxy) {
        let scaledWidth = parentGeometry.size.width * scale
        let scaledHeight = totalImageHeight * scale

        let maxOffsetX = max(0, (scaledWidth - parentGeometry.size.width) / 2)
        let maxOffsetY = max(0, scaledHeight - parentGeometry.size.height)

        var newOffset = offset
        newOffset.width = min(max(newOffset.width, -maxOffsetX), maxOffsetX)
        newOffset.height = min(max(newOffset.height, -maxOffsetY), 0)

        withAnimation(.interactiveSpring()) {
            offset = newOffset
            lastOffset = newOffset
        }
    }
}
