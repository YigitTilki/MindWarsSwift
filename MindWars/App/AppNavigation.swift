//
//  AppNavigation.swift
//  MindWars
//
//  Created by Yiğit Tilki on 20.12.2024.
//

import SwiftUI

class Navigation: ObservableObject {
    @Published var state: String = "OnBoarding"
}

struct AppNavigation: View {
    @StateObject private var navigation = Navigation()
    @StateObject private var authState = AuthState()
    
    var body: some View {
        NavigationStack {
            Group {
                if navigation.state == "OnBoarding" {
                    OnBoardingView()
                        .environmentObject(navigation)
                } else if navigation.state == "Splash" {
                    SplashView()
                        .environmentObject(navigation)
                } else if navigation.state == "Email" {
                    EmailView()
                        .environmentObject(navigation)
                        .environmentObject(authState)
                } else if navigation.state == "Password" {
                    PasswordView()
                        .environmentObject(navigation)
                        .environmentObject(authState)
                } else if navigation.state == "Register" {
                    RegisterView()
                        .environmentObject(navigation)
                } else if navigation.state == "Home" {
                    HomeView()
                        .environmentObject(navigation)
                }
            }
            
        }
    }
}
