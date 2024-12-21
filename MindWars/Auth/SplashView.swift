//
//  SplashView.swift
//  MindWars
//
//  Created by Yiğit Tilki on 20.12.2024.
//

import SwiftUI

struct SplashView: View {
    @EnvironmentObject var navigationState: NavigationState
    
    var body: some View {
        ZStack{
            AppBackground()
            LottieView(animationFileName: "LoadingLottie", loopMode: .loop)
                .frame(width: 200, height: 200).padding(30)
        }
        .onAppear{DispatchQueue.main.asyncAfter(deadline: .now() + 1){
            navigationState.state = "Email"
        } }
        
    }
}

#Preview {
    SplashView()
}
