//
//  Validator.swift
//  MindWars
//
//  Created by Yiğit Tilki on 22.12.2024.
//

import Foundation
import SwiftUICore

class Validator {
    static func validateEmail(_ email: String) -> String? {
        let emailRegEx = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}"
        let emailPredicate = NSPredicate(format: "SELF MATCHES %@", emailRegEx)
        return emailPredicate.evaluate(with: email) ? nil :  LocaleKeys.Errors.invalidEmail.localized
    }

    static func validatePassword(_ password: String) -> String? {
        if password.count < 6 {
            return  LocaleKeys.Errors.password6.localized
        }
        let upperCaseRegEx = ".*[A-Z]+.*"
        let digitRegEx = ".*[0-9]+.*"

        let upperCasePredicate = NSPredicate(format: "SELF MATCHES %@", upperCaseRegEx)
        let digitPredicate = NSPredicate(format: "SELF MATCHES %@", digitRegEx)

        if !upperCasePredicate.evaluate(with: password) {
            return  LocaleKeys.Errors.passwordUC.localized
        }
        if !digitPredicate.evaluate(with: password) {
            return  LocaleKeys.Errors.passwordN.localized
        }

        return nil
    }

    static func validateRePassword(_ password: String, _ rePassword: String) -> String? {
        if !password.isEmpty, password != rePassword {
            return  LocaleKeys.Errors.passwordDM.localized
        }

        return nil
    }

    static func validateUsername(_ username: String) -> String? {
        if username.count < 3 {
            return  LocaleKeys.Errors.invalidUsername.localized
        }
        return nil
    }

    static func validateBirthdate(_ birthdate: Date) -> String? {
        let calendar = Calendar.current
        let ageComponents = calendar.dateComponents([.year], from: birthdate, to: Date())
        guard let age = ageComponents.year else { return "invalid_birthdate" }

        if age < 18 {
            return LocaleKeys.Errors.mustbe18.localized
        }
        return nil
    }
}
