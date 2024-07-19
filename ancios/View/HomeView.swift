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
            Button(action: openSafari) {
                VStack {
                    Image(uiImage: .homepage)
                    Image(uiImage: .homepageShortcut)
                }
                .frame(width: 120, height: 120)
                .padding()
                .background(Color.white)
                .cornerRadius(10)
                .shadow(color: Color.gray.opacity(0.4), radius: 5, x: 0, y: 2)
            }
            .buttonStyle(PlainButtonStyle())

            Text("10000 Foothill Blvd.\nLake View Terrace, CA 91342")
                .padding()
                .multilineTextAlignment(.center)
                .font(.headline)
                .onTapGesture {
                    openUrlInExternalBrowser(url: "https://maps.app.goo.gl/dHNZP3vGJDtU7d3L6")
                }
        }
        .navigationTitle("안내")
    }
}

#Preview {
    NavigationStack {
        HomeView()
    }
}

func openSafari() {
    let urlString = "https://anconnuri.com"

    openUrlInExternalBrowser(url: urlString)
}

func openUrlInExternalBrowser(url: String) {
    if let urlSafari = URL(string: url) {
        if UIApplication.shared.canOpenURL(urlSafari) {
            UIApplication.shared.open(urlSafari, options: [:], completionHandler: nil)
        }
    }
}
