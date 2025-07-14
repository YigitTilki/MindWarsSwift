//
//  OnBoardingView.swift
//  MindWars
//
//  Created by Yiğit Tilki on 18.12.2024.
//

import SwiftUI

struct OnBoardingView: View {
    @StateObject private var vm = OnBoardingViewModel()

    var body: some View {
            ZStack {
                AppBackground()
                pageBody()
                if vm.isLoading { LoadingView() }
            }
            .navigationDestination(isPresented: $vm.navigateLogin) {
                LoginView()
                    .navigationBarBackButtonHidden(true)
            }
            .navigationDestination(isPresented: $vm.navigateHome) {
                HomeView()
                    .navigationBarBackButtonHidden(true)
            }
    }
    
    func pageBody() -> some View {
        VStack {
            mindWarsText()
            appImage()
            startButton()
        }
    }
    
    

    func startButton() -> some View {
        Button(
            action: {
                Task { await vm.onTapLetsStart() }
            },
            label: {
                Text("LET'S START")
                    .frame(maxWidth: .infinity, minHeight: 64)
                    .foregroundStyle(.white)
                    .font(AppFont.button2)
                    .background(
                        LinearGradient(
                            gradient: Gradient(colors: [.appRed, .appBlue]),
                            startPoint: .leading,
                            endPoint: .trailing
                        )
                    )
                    .cornerRadius(10)
                    .shadow(radius: 10)
                    .padding(.top, 40)
                    .padding(.horizontal, 30)
            }
        )
    }

    func mindWarsText() -> some View {
        Text(
            "\(Text("M").foregroundStyle(.appRed))\(Text("I\(Text("N\(Text("D").foregroundStyle(.appBlue))").foregroundStyle(.appGreen))").foregroundStyle(.appYellow)) WARS"
        )
        .foregroundStyle(.darkGrey)
        .font(AppFont.bigTitle)
    }

    func appImage() -> some View {
        Image(.appLogo)
            .resizable()
            .frame(width: 250, height: 250)
            .padding(.top, 10)
    }
}

#Preview {
    NavigationStack {
        OnBoardingView()
    }
}
