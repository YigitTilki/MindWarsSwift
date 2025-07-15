//
//  RegisterState.swift
//  MindWars
//
//  Created by Yiğit Tilki on 15.07.2025.
//

import Foundation

struct RegisterState {
    var userName: String = ""
    var userNameError: String? = nil

    var email: String = ""
    var emailError: String? = nil

    var birthDate: Date = Date()
    var birthDateError: String? = nil

    var password: String = ""
    var passwordError: String? = nil

    var rePassword: String = ""
    var rePasswordError: String? = nil

    var isFieldsEmpty: Bool {
        userName.isEmpty || email.isEmpty || password.isEmpty
            || rePassword.isEmpty
    }

    var isValid: Bool {
        [
            emailError,
            passwordError,
            rePasswordError,
            userNameError,
            birthDateError,
        ].allSatisfy { $0 == nil }
    }
}
