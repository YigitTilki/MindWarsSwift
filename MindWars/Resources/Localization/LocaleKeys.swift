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
