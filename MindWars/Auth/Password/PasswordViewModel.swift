//
//  PasswordViewModel.swift
//  MindWars
//
//  Created by Yiğit Tilki on 21.12.2024.
//

import Foundation
import SwiftUICore

@MainActor
class PasswordViewModel: ObservableObject {
    @Published var alertItem: AlertItem?
    
    func handleContinueButton(navigationState: Navigation, authState: AuthState) async {
    
        if !isPasswordValid(authState: authState) { return }
        
        UIKitFunctions().dismissKeyboard()
        
        authState.isLoading = true
        
        try? await Task.sleep(for: .seconds(1))
        
        if let user = mockUserLoginData.first(where: {
            $0.email == authState.email.lowercased() &&
            $0.password == authState.password
        }) {
            
            authState.isLoggedIn = true
            navigationState.state = "Home"
            
        } else {
            
            authState.isLoggedIn = false
            alertItem = AlertContext.wrongPassword
            
        }
        
        authState.isLoading = false
    }
    
    func handleForgetPasswordButton(navigationState: Navigation) {
    }
    
    func isPasswordValid(authState: AuthState) -> Bool {
        authState.error.removeAll()
        
        if authState.password.isEmpty {
            authState.error.append("Invalid Password")
            return false
        }
        
        if !authState.password.isEmpty, !Validation().isValidPassword(authState.password) {
            authState.error.append("Invalid Password")
            return false
        }
        else {
            return true
        }
        
        
    }
}
