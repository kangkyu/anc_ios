//
//  ContentView.swift
//  ancios
//
//  Created by Kang-Kyu Lee on 7/11/24.
//

import SwiftUI

struct ContentView: View {
    @State private var selectedTab = 0
        
    var body: some View {
        TabView(selection: $selectedTab) {
            NavigationStack {
                SermonVideosView()
            }
            .tabItem {
                Label("설교", image: "sermons")
            }
            .tag(0)
            
            NavigationStack {
                JuboView()
            }
            .tabItem {
                Label("주보", image: "jubo")
            }
            .tag(1)
            
            NavigationStack {
                HomeView()
            }
            .tabItem {
                Label("안내", image: "jubo")
            }
            .tag(2)
        }
    }
}

#Preview {
    ContentView()
}
