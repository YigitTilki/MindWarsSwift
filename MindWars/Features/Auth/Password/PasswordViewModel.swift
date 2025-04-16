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
    
    func handleContinueButton( authState: AuthState) async {
    
        if !isPasswordValid(authState: authState) { return }
        
        UIKitFunctions().dismissKeyboard()
        
        authState.isLoading = true
        
        try? await Task.sleep(for: .seconds(1))
        
        if  (mockUserLoginData.first(where: {
            $0.email == authState.email.lowercased() &&
            $0.password == authState.password
        }) != nil) {
            
            authState.isLoggedIn = true
       
            
        } else {
            
            authState.isLoggedIn = false
            alertItem = AlertContext.wrongPassword
            
        }
        
        authState.isLoading = false
    }
    
    func handleForgetPasswordButton() {
    }
    
    func isPasswordValid(authState: AuthState) -> Bool {
        authState.error.removeAll()
        
        if authState.password.isEmpty {
            authState.error.append("Invalid Password")
            return false
        }
        
        if !authState.password.isEmpty {
            authState.error.append("Invalid Password")
            return false
        }
        else {
            return true
        }
        
        
    }
}
