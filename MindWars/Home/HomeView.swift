//
//  HomeView.swift
//  MindWars
//
//  Created by Yiğit Tilki on 21.12.2024.
//

import SwiftUI

struct HomeView: View {
    @EnvironmentObject var navigationState: NavigationState
    @Environment(LanguageManager.self) var languageManager
    @State private var isPresented = false
    
    var body: some View {
        CommonBackgroundView {
            VStack {

            }
        }
        .languageSelectionDialog(isPresented: $isPresented, languageManager: languageManager)
        .toolbar {
            ToolbarItem(placement: .navigationBarTrailing) {
                Button(action: {
                    isPresented = true
                }) {
                    Image(systemName: "globe")
                }
            }
        }
        
        
    }
}

#Preview {
    HomeView()
}
