//
//  RegisterViewModel.swift
//  MindWars
//
//  Created by Yiğit Tilki on 21.12.2024.
//

import Foundation

class RegisterViewModel: ObservableObject {
    @Published var email: String = ""
    @Published var userName: String = ""
    @Published var birthDate: String = ""
    @Published var password: String = ""
    @Published var rePassword: String = ""

    
    func handleSignUpButton(navigationState: NavigationState) {
        navigationState.state = "Home"
    }
    
   
}
