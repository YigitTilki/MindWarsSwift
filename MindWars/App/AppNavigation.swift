//
//  AppNavigation.swift
//  MindWars
//
//  Created by Yiğit Tilki on 20.12.2024.
//

import SwiftUI

class NavigationState: ObservableObject {
    @Published var state: String = "OnBoarding"
}

struct AppNavigation: View {
    @StateObject private var navigationState = NavigationState()
    
    var body: some View {
        NavigationStack {
            Group {
                if navigationState.state == "OnBoarding" {
                    OnBoardingView()
                        .environmentObject(navigationState)
                } else if navigationState.state == "Splash" {
                    SplashView()
                        .environmentObject(navigationState)
                } else if navigationState.state == "Email" {
                    EmailView()
                        .environmentObject(navigationState)
                } else if navigationState.state == "Password" {
                    PasswordView()
                        .environmentObject(navigationState)
                } else if navigationState.state == "Register" {
                    RegisterView()
                        .environmentObject(navigationState)
                } else if navigationState.state == "Home" {
                    HomeView()
                        .environmentObject(navigationState)
                }
            }
            
        }
    }
}
