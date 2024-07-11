//
//  JuboView.swift
//  ancios
//
//  Created by Kang-Kyu Lee on 7/11/24.
//

import SwiftUI

struct JuboView: View {
    var body: some View {
        VStack {
            Text("jubo this week")
        }
        .navigationTitle("주보")
    }
}

#Preview {
    NavigationStack {
        SermonVideosView()
    }
}
