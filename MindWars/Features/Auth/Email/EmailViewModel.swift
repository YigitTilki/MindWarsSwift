//
//  EmailViewModel.swift
//  MindWars
//
//  Created by Yiğit Tilki on 21.12.2024.
//

import Foundation
import SwiftUICore
import UIKit

@MainActor
class EmailViewModel: ObservableObject {
    
    func handleContinueButton(navigationState: Navigation, authState: AuthState) async {
        
        if !isEmailValid(authState: authState) { return }
        UIKitFunctions().dismissKeyboard()
        
        authState.isLoading = true
        
        try? await Task.sleep(for: .seconds(1))
        
        if mockUserLoginData.first(where: {
            $0.email == authState.email.lowercased()
        }) != nil {
            navigationState.state = "Password"
        } else {
            navigationState.state = "Register"
        }
        
        authState.isLoading = false
    }
    
    func isEmailValid(authState: AuthState) -> Bool {
        authState.error.removeAll()
        
        if authState.email.isEmpty {
            authState.error.append("Invalid E-mail Address")
            return false
        }
        
         if !authState.email.isEmpty, !Validation().isValidEmail(authState.email) {
            authState.error.append("Invalid E-mail Address")
            return false
        }
        else {
            return true
        }
        
        
    }
    
    
    
    
}



