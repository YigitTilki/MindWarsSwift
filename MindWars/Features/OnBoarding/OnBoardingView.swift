//
//  OnBoardingView.swift
//  MindWars
//
//  Created by Yiğit Tilki on 18.12.2024.
//

import SwiftUI

struct OnBoardingView: View {
    @State private var isActive = false

    var body: some View {
        ZStack {
            AppBackground()
            VStack {
                mindWarsText()
                appImage()
                startButton()
            }
        }
        .navigationDestination(isPresented: $isActive) {
            LoginView()
        }
        .navigationBarBackButtonHidden(true)
    }

    func startButton() -> some View {
        Button(action: {
            isActive = true
        }, label: {
            Text("LET'S START")
                .frame(maxWidth: 300, maxHeight: 65)
                .foregroundStyle(.white)
                .fontWeight(.semibold)
                .font(.title3)
                .background(
                    LinearGradient(
                        gradient: Gradient(colors: [.red, .purple]),
                        startPoint: .leading,
                        endPoint: .trailing
                    )
                )
                .cornerRadius(10)
                .shadow(radius: 10)
                .padding(.top, 20)

        })
    }

    func mindWarsText() -> some View {
        Text("\(Text("M").foregroundStyle(.red))\(Text("I\(Text("N\(Text("D").foregroundStyle(.blue))").foregroundStyle(.green))").foregroundStyle(.yellow)) WARS").foregroundStyle(.secondary).font(.system(size: 48).weight(.semibold))
    }

    func appImage() -> some View {
        Image(.appLogo).resizable().frame(width: 200, height: 200)
    }
}

#Preview {
    OnBoardingView()
}
