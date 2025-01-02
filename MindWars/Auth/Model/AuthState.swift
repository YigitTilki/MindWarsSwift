//
//  AuthState.swift
//  MindWars
//
//  Created by Yiğit Tilki on 22.12.2024.
//

import Foundation

class AuthState: ObservableObject {
    @Published var email: String = ""
    @Published var password: String = ""
    @Published var isLoggedIn: Bool = false
    @Published var error: String = ""
    @Published var isLoading: Bool = false
    @Published var showAlert: Bool = false
}
