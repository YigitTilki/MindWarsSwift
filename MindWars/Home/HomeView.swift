//
//  HomeView.swift
//  MindWars
//
//  Created by Yiğit Tilki on 21.12.2024.
//

import SwiftUI

struct HomeView: View {
    @EnvironmentObject var navigationState: Navigation
    @Environment(Language.self) var languageManager
    @State private var isPresented = false
    
    @StateObject private var viewModel = HomeViewModel()
    @State var showAlert = false
    
    
    var body: some View {
        CommonBackgroundView {
            VStack {
                Button(action: {
                    viewModel.setData()
                }, label: {
                    Text("press")
                })
            }
        }
        .alert(isPresented: $showAlert) {
                    Alert(
                        title: Text(viewModel.message?.title ?? ""),
                        message: Text(viewModel.message?.message ?? ""),
                        dismissButton: .default(Text("OK"))
                    )
                }
        .onChange(of: viewModel.message?.message) {
                        showAlert = true
                }
        .languageSelectionDialog(isPresented: $isPresented, languageManager: languageManager)
        
    }
}

//#Preview {
//    HomeView()
//
//}
