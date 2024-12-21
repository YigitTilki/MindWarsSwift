//
//  EmailViewModel.swift
//  MindWars
//
//  Created by Yiğit Tilki on 21.12.2024.
//

import Foundation

class EmailViewModel: ObservableObject {
    @Published var username: String = ""
    
    func handleContinueButton(navigationState: NavigationState) {
        if username == "abc" {
            navigationState.state = "Password"
        } else {
            navigationState.state = "Register"
        }
    }
}
