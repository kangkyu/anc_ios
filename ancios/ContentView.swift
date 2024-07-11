//
//  ContentView.swift
//  ancios
//
//  Created by Kang-Kyu Lee on 7/11/24.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        VStack {
            Image(uiImage: .logo)
                .imageScale(.large)
                .foregroundStyle(.tint)
        }
        .padding()
    }
}

#Preview {
    ContentView()
}
