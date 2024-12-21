//
//  ContentView.swift
//  MindWars
//
//  Created by Yiğit Tilki on 18.12.2024.
//

import SwiftUI

struct OnBoardingView: View {
    @EnvironmentObject var navigationState: NavigationState
    
    var body: some View {
        ZStack {
            AppBackground()
            VStack {
                mindWarsText()
                Image(.appLogo).resizable().frame(width: 200, height: 200)
                startButton()
            }
            
        }
       
    }
    func startButton() -> some View {
        Button("LET'S START") {
            navigationState.state = "Splash"
        }
        .frame(maxWidth: .infinity,maxHeight: 65).background(
            LinearGradient(
                gradient: Gradient(colors: [.red, .purple]),
                startPoint: .leading,
                endPoint: .trailing
            )
        )
        .clipShape(RoundedRectangle(cornerRadius: 15))
        .overlay(
            RoundedRectangle(cornerRadius: 15)
                .stroke(Color.white.opacity(0.2), lineWidth: 2)
        )
        .shadow(color: Color.black.opacity(0.5), radius: 8, x: 4, y: 4)
        .overlay(
            RoundedRectangle(cornerRadius: 15)
                .stroke(Color.black.opacity(0.5), lineWidth: 5)
                .blur(radius: 4)
                .offset(x: -2, y: -2)
                .mask(
                    RoundedRectangle(cornerRadius: 15)
                        .fill(LinearGradient(
                            gradient: Gradient(colors: [Color.black.opacity(0.5), Color.clear]),
                            startPoint: .topLeading,
                            endPoint: .bottomTrailing
                        ))
                )
        )
        .foregroundColor(.white)
            .font(.system(size: 24))
            .fontWeight(.semibold)
            .containerShape(.buttonBorder)
            .padding(.horizontal, 45)
            .padding(.vertical, 20)
    }
    func mindWarsText() -> some View {
        Text("\(Text("M").foregroundStyle(.red))\(Text("I\(Text("N\(Text("D").foregroundStyle(.blue))").foregroundStyle(.green))").foregroundStyle(.yellow)) WARS").foregroundStyle(.secondary).font(.system(size: 48).weight(.semibold))
    }
}

#Preview {
    OnBoardingView()
}
