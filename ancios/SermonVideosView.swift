//
//  SermonVideosView.swift
//  ancios
//
//  Created by Kang-Kyu Lee on 7/11/24.
//

import SwiftUI

struct SermonVideosView: View {
    var body: some View {
        VStack {
            Text("sermon videos")
        }
        .navigationTitle("설교")
    }
}

#Preview {
    NavigationStack {
        SermonVideosView()
    }
}
