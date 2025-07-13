//
//  HomeView.swift
//  MindWars
//
//  Created by Yiğit Tilki on 21.12.2024.
//

import SwiftUI

struct HomeView: View {
//    @Environment(Language.self) var languageManager
    @State private var isPresented = false

    @StateObject private var viewModel = HomeViewModel()
    @State var showAlert = false

    var body: some View {
        NavigationStack {
            CommonBackgroundView {
                VStack {
                    Button(action: {
                        showAlert = true
                    }, label: {
                        Text("Play")
                            .frame(maxWidth: .infinity, maxHeight: 200)
                            .font(.title)
                            .foregroundColor(.white)
                            .padding()
                            .background(Color.green)
                            .cornerRadius(10)
                            .padding()
                            .opacity(0.8)
                    })
                }
            }
//            .languageSelectionDialog(isPresented: $isPresented, languageManager: languageManager)
            .navigationDestination(isPresented: $showAlert, destination: { PlaySoloRedMindWarView() })
        }
    }
}

#Preview {
    HomeView()
       // .environment(Language())
}
