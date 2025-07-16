//
//  LoginState.swift
//  MindWars
//
//  Created by Yiğit Tilki on 16.07.2025.
//

import Foundation

struct LoginState {
    var email: String = ""
    var password: String = ""
    var isValid: Bool { !email.isEmpty && !password.isEmpty }
}
