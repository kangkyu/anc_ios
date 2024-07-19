//
//  JuboView.swift
//  ancios
//
//  Created by Kang-Kyu Lee on 7/11/24.
//

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
                Text(urls[0])
                Text(urls[1])
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

#Preview {
    NavigationStack {
        SermonVideosView()
    }
}
