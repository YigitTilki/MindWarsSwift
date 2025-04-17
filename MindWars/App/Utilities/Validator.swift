//
//  Validation.swift
//  MindWars
//
//  Created by Yiğit Tilki on 22.12.2024.
//

import Foundation
import SwiftUICore

class Validator {
    
    static func validateEmail(_ email: String) -> LocalizedStringKey? {
        let emailRegEx = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}"
        let emailPredicate = NSPredicate(format: "SELF MATCHES %@", emailRegEx)
        return emailPredicate.evaluate(with: email) ? nil : "invalid_email_addreess"
    }
    
    static func validatePassword(_ password: String) -> LocalizedStringKey? {
        if password.count < 6 {
            return "password_must_be_at_least_six_characters"
        }
        let upperCaseRegEx = ".*[A-Z]+.*"
        let digitRegEx = ".*[0-9]+.*"
        
        let upperCasePredicate = NSPredicate(format: "SELF MATCHES %@", upperCaseRegEx)
        let digitPredicate = NSPredicate(format: "SELF MATCHES %@", digitRegEx)
        
        if !upperCasePredicate.evaluate(with: password) {
            return "password_must_contain_at_least_one_uppercase"
        }
        if !digitPredicate.evaluate(with: password) {
            return "password_must_contain_at_least_one_number"
        }
        
        return nil
    }
    static func validateRePassword(_ password: String,_ rePassword: String) -> LocalizedStringKey? {
        if !password.isEmpty && password != rePassword {
            return "passwords_doesnt_match"
        }
        
        return nil
    }
    
    static func validateUsername(_ username: String) -> LocalizedStringKey? {
        if username.isEmpty {
            return "invalid_username"
        }
        if username.count < 3 {
            return "invalid_username"
        }
        return nil
    }
    
    static func validateBirthdate(_ birthdate: Date) -> LocalizedStringKey? {
        let calendar = Calendar.current
        let ageComponents = calendar.dateComponents([.year], from: birthdate, to: Date())
        guard let age = ageComponents.year else { return "Doğum tarihi geçersiz" }
        
        if age < 18 {
            return "you_must_be_over_eightteen_years_old"
        }
        return nil
    }
}
