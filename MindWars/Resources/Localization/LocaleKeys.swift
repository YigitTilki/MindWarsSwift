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
    

    enum Login: String, Localizable {
        case letsPlay = "lets_play"
        case emww = "enter_mind_wars_world"
        case dhacc = "dont_have_an_account"
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
