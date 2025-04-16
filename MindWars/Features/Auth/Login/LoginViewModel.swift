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
class LoginViewModel: BaseViewModel, ObservableObject {
    
    @Published var email: String = ""
    @Published var emailError: LocalizedStringKey?
    
    @Published var password: String = ""
    @Published var passwordError: LocalizedStringKey?
    
    @Published var navigate: Bool = false
    
    //MARK: - Login Button Process
    func handleContinueButton() async {
        let validate = validate()
        if !validate {
            return
        }
    
        UIKitFunctions().dismissKeyboard()
        
        await performLoadingTask  { [self] in
            let result = await AuthService.signIn(email: email, password: password)
            
            switch result {
            case .success(_):
                self.navigate = true
                clearForm()
                
            case .failure(let error):
                print("Error: \(error.localizedDescription)")
                self.error = error.localizedDescription
            }
        }
    }
    
    //MARK: - Clear Fields
    func clearForm() {
        self.error = nil
        self.email = ""
        self.password = ""
    }
    
    //MARK: - Validation
    func validate() -> Bool {
        emailError = Validator.validateEmail(email)
        passwordError = Validator.validatePassword(password)
        
        return [emailError, passwordError].allSatisfy { $0 == nil }
    }
    
    
}



