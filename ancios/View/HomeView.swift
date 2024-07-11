//
//  HomeView.swift
//  ancios
//
//  Created by Kang-Kyu Lee on 7/11/24.
//

import SwiftUI

struct HomeView: View {
    var body: some View {
        VStack {
            Image(uiImage: .homepage)
            Image(uiImage: .homepageShortcut)
            Text("link to website / map")
        }
        .navigationTitle("설교")
    }
}

#Preview {
    NavigationStack {
        HomeView()
    }
}
