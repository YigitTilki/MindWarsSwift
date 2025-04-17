//
//  LoadingView.swift
//  MindWars
//
//  Created by Yiğit Tilki on 22.12.2024.
//

import SwiftUI

struct LoadingView: View {
    var body: some View {
        ZStack {
            Color.black.opacity(0.5)
                .ignoresSafeArea()
                .transition(.opacity)

            LottieView(animationFileName: "LoadingLottie", loopMode: .loop)
                .frame(width: 200, height: 200)
                .padding(30)
        }
        .transition(.opacity)
        .zIndex(1)
    }
}

#Preview {
    LoadingView()
}
