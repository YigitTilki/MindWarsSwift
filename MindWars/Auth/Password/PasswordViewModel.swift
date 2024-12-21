//
//  PasswordViewModel.swift
//  MindWars
//
//  Created by Yiğit Tilki on 21.12.2024.
//

import Foundation

class PasswordViewModel: ObservableObject {
    @Published var password: String = ""
    
    func handleContinueButton(navigationState: NavigationState) {
    }
    
    func handleForgetPasswordButton(navigationState: NavigationState) {
    }
}
