//
//  HomeView.swift
//  JRNLSwiftUI
//
//  Created by Kang-Kyu Lee on 7/11/24.
//

import SwiftUI

struct HomeView: View {
    var body: some View {
        VStack {
            Image(uiImage: .logo)
                .foregroundStyle(.tint)
            Text("link to website / map")
        }
        .padding()
        .navigationTitle("안내")
    }
}

#Preview {
    NavigationStack {
        HomeView()
    }
}
