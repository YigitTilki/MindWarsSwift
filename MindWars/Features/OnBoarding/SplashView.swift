//
//  SplashView.swift
//  MindWars
//
//  Created by Yiğit Tilki on 20.12.2024.
//

import SwiftUI

struct SplashView: View {
    @State private var isActive = false

    var body: some View {
        NavigationStack {
            ZStack {
                AppBackground()
                loadingIndicator()
            }
            .onAppear {
                navigate()
            }
            .navigationDestination(isPresented: $isActive) {
                OnBoardingView()
            }
        }
    }

    func loadingIndicator() -> some View {
        LottieView(animationFileName: "LoadingLottie", loopMode: .loop)
            .frame(width: 200, height: 200).padding(30)
    }

    func navigate() {
        DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
            isActive = true
        }
    }
}

#Preview {
    SplashView()
}
