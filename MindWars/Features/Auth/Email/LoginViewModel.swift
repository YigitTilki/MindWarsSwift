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
    @Published var password: String = ""
    @Published var navigate: Bool = false
    
    var isValidForm: Bool {
        Validation.isValidEmail(email)
        //&& Validation.isValidPassword(password)
    }
    
    //MARK: - Login Button Process
    func handleContinueButton() async {
        if !isValidForm {
            isError = true
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
    
    
}



