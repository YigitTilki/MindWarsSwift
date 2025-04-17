//
//  MainView.swift
//  MindWars
//
//  Created by Yiğit Tilki on 7.01.2025.
//

import SwiftUI

struct MainView: View {
    var body: some View {
        TabView {
            HomeView()
                .tabItem {
                    Image(systemName: "house")
                    Text("Home")
                }
            MainQuestionSectionsView()
                .tabItem {
                    Image(systemName: "person")
                    Text("Account")
                }
        }
    }
}

#Preview {
    MainView()
}
