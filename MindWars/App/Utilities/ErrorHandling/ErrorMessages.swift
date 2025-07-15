//
//  ErrorMessages.swift
//  MindWars
//
//  Created by Yiğit Tilki on 15.07.2025.
//

import Foundation

enum FirebaseAuthErrorMapper {

    static func map(_ message: String) -> String {
        switch message {
        case "EMAIL_EXISTS":
            return LocaleKeys.Errors.emailExists.localized
        case "INVALID_EMAIL":
            return LocaleKeys.Errors.invalidEmail.localized
        case "OPERATION_NOT_ALLOWED":
            return LocaleKeys.Errors.operationNotAllowed.localized
        default:
            return LocaleKeys.Errors.unExpectedError.localized(with: message)
        }
    }
}
