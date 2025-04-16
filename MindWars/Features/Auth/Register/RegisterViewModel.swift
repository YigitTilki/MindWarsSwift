//
//  RegisterViewModel.swift
//  MindWars
//
//  Created by Yiğit Tilki on 21.12.2024.
//

import Foundation
import FirebaseAuth

@MainActor
class RegisterViewModel: BaseViewModel, ObservableObject {
    @Published var userName: String = ""
    @Published var birthDate: String = ""
    @Published var password: String = ""
    @Published var rePassword: String = ""
    
    @Published var user: User?
    
    private let authService = AuthService()
    
    func signUp(email: String) async {
//            isLoading = true
//        isError = false
//            do {
//                user = try await authService.signUp(email: email, password: password)
//            } catch {
//                isError = true
//            }
//            isLoading = false
        }
    
    

    
    func handleSignUpButton() async {
        //if !isValid(authState: authState) { return }
        UIKitFunctions().dismissKeyboard()
        
        isLoading = true
        
        try? await Task.sleep(for: .seconds(1))
        
       
        
        isLoading = false
        
    }
    
    func isFieldsEmpty(email: String) -> Bool {
        if email.isEmpty || userName.isEmpty || birthDate.isEmpty || password.isEmpty || rePassword.isEmpty {
            return true
        } else {
            return false
        }
    }
    
//    func isValid() -> Bool {
//        authState.error.removeAll()
//        if !Validation().isValidEmail(authState.email) {
//            authState.error = "Invalid E-mail Address"
//            return false
//        }
//        else if !Validation().isValidPassword(password) {
//            authState.error = "Invalid Password"
//            return false
//        } else if password != rePassword {
//            authState.error = "Passwords Doesn't Match"
//            return false
//        } else {
//            return true
//        }
//        
//    }
}
