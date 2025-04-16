//
//  RegisterViewModel.swift
//  MindWars
//
//  Created by Yiğit Tilki on 21.12.2024.
//

import Foundation
import FirebaseAuth
import SwiftUICore

@MainActor
class RegisterViewModel: BaseViewModel, ObservableObject {
    @Published var userName: String = ""
    @Published var userNameError: LocalizedStringKey?
    
    @Published var email: String = ""
    @Published var emailError: LocalizedStringKey?
    
    @Published var birthDate: Date = Date()
    @Published var birthDateError: LocalizedStringKey?
    
    @Published var password: String = ""
    @Published var passwordError: LocalizedStringKey?
    
    @Published var rePassword: String = ""
    @Published var rePasswordError: LocalizedStringKey?
    
    @Published var navigateToHome: Bool = false
    
    
    @Published var user: User?
    
    var isFieldsEmpty: Bool {
        userName.isEmpty || email.isEmpty || password.isEmpty || rePassword.isEmpty
    }
    
    private let authService = AuthService()
    
    
    func handleSignUpButton() async {
        let validate = validate()
        if !validate {
            return
        }
        
        UIKitFunctions().dismissKeyboard()
        
        await performLoadingTask { [self] in
            let result = await AuthService.signUp(email: email, password: password)
            
            switch result {
            case .success(let user):
                let result =  await AuthService.signUpFirestore(data: UserCreateModel(id: user.uid, username: userName, email: user.email, birthDate: birthDate))
                
                switch result {
                    case .success(_):
                        navigateToHome = true
                    
                    case .failure(let error):
                        print("Error: \(error.localizedDescription)")
                    }
                
            case .failure(let error):
                print("Error: \(error.localizedDescription)")
                self.error = error.localizedDescription
                
            }
        }
    }
    
    func clearForm() {
        email = ""
        userName = ""
        birthDate = Date()
        password = ""
        rePassword = ""
    }
    
    func validate() -> Bool {
            emailError = Validator.validateEmail(email)
            passwordError = Validator.validatePassword(password)
            rePasswordError = Validator.validateRePassword(password,rePassword)
            userNameError = Validator.validateUsername(userName)
            birthDateError = Validator.validateBirthdate(birthDate)

            return [emailError, passwordError, userNameError, birthDateError].allSatisfy { $0 == nil }
        }
    
    
}
