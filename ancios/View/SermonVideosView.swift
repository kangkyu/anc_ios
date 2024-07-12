//
//  SermonVideosView.swift
//  ancios
//
//  Created by Kang-Kyu Lee on 7/11/24.
//

import SwiftUI


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
        getVideos { result in
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
        VStack(alignment: .leading) {
            AsyncImage(url: URL(string: video.thumbnail_url)).frame(width: 128, height: 128)
            Text(video.title)
                .font(.headline)
            Text(video.id)
                .font(.subheadline)
                .foregroundColor(.secondary)
        }
    }
}
