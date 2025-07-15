//
//  LocaleKeys.swift
//  MindWars
//
//  Created by Yiğit Tilki on 13.07.2025.
//

import Foundation

protocol Localizable: RawRepresentable where RawValue == String {
    var localized: String { get }
    func localized(with arguments: CVarArg...) -> String
}

enum LocaleKeys: String, Localizable {
    case continueValue = "continue"
    case signUp = "sign_up"
    case email = "email"
    case password = "password"
    case birthDate = "birth_date"
    case rePassword = "re_password"
    case userName = "username"
    case signIn = "sign_in"
    

    enum Login: String, Localizable {
        case letsPlay = "lets_play"
        case emww = "enter_mind_wars_world"
        case dhacc = "dont_have_an_account"
        case invalideop = "invalid_email_or_password"
    }
    
    enum Register: String, Localizable {
        case letsSignUp = "lets_sign_up"
        case eyctsu = "enter_your_credentials_to_sign_up"
        case ahaacc = "already_have_an_account"
    }
    enum Errors: String, Localizable {
        case invalidEmail = "invalid_email_address"
        case password6 = "password_must_be_at_least_six_characters"
        case passwordUC = "password_must_contain_at_least_one_uppercase"
        case passwordN = "password_must_contain_at_least_one_number"
        case passwordDM = "passwords_doesnt_match"
        case invalidUsername = "invalid_username"
        case invalidBirthdate = "invalid_birthdate"
        case mustbe18 = "you_must_be_over_eightteen_years_old"
        case unExpectedError = "unexpected_error"
        case emailExists = "email_address_exist"
        case operationNotAllowed = "operation_not_allowed"
    }
    
    
   
}

extension Localizable {
    /// Localized your key
    var localized: String {
        NSLocalizedString(rawValue, comment: "")
    }

    /// Localized your key
    /// - Parameter arguments: <#arguments
    /// - Returns: Value with params
    func localized(with arguments: CVarArg...) -> String {
        String(format: localized, arguments)
    }
}
