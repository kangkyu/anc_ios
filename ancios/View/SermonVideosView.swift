//
//  SermonVideosView.swift
//  ancios
//
//  Created by Kang-Kyu Lee on 7/11/24.
//

import SwiftUI

struct SermonVideosView: View {
    @State private var videos: [Video] = []
    @State private var isLoading = false
    @State private var error: Error?

    var body: some View {
        VStack {
            if isLoading {
                ProgressView("Loading...")
            } else if let error = error {
                Text("Error: \(error.localizedDescription)")
            } else if videos.isEmpty {
                Text("No videos available")
            } else {
                List(videos) { video in
                    VideoRow(video: video)
                }
            }
        }
        .navigationTitle("설교")
        .onAppear {
            fetchVideos()
        }
    }

    private func fetchVideos() {
        isLoading = true
        ChurchAPI.shared.getVideos { result in
            DispatchQueue.main.async {
                isLoading = false
                switch result {
                case .success(let fetchedVideos):
                    self.videos = fetchedVideos
                case .failure(let fetchError):
                    self.error = fetchError
                }
            }
        }
    }
}

struct VideoRow: View {
    let video: Video

    var body: some View {
        HStack(alignment: .top) {
            AsyncImage(url: URL(string: video.thumbnail_url)) { image in
                image.resizable()
                    .frame(minWidth: 0, maxWidth: .infinity, minHeight: 0, maxHeight: .infinity)
                    .aspectRatio(nil, contentMode: .fill)
                                .clipped()
                    .allowsHitTesting(false)
            } placeholder: {
                ProgressView()
            }
            .frame(width: 178, height: 89)
            VStack(alignment: .trailing) {
                Text(video.title)
                    .font(.headline)
            }
        }
        .onTapGesture {
            openYouTube(videoId: video.youtube_id)
        }
    }
}

func openYouTube(videoId: String) {
    let urlStringYouTube = "youtube://watch?v=\(videoId)"
    let urlStringSafari = "https://youtu.be/\(videoId)"

    if let urlYouTube = URL(string: urlStringYouTube), let urlSafari = URL(string: urlStringSafari) {
        if UIApplication.shared.canOpenURL(urlYouTube) {
            UIApplication.shared.open(urlYouTube, options: [:], completionHandler: nil)
        } else {
            UIApplication.shared.open(urlSafari, options: [:], completionHandler: nil)
        }
    }
}
