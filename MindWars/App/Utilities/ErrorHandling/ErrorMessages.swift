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
        case "OPERATION_NOT_ALLOWED":
            return LocaleKeys.Errors.operationNotAllowed.localized
        case "TOO_MANY_ATTEMPTS_TRY_LATER":
            return "TOO_MANY_ATTEMPTS_TRY_LATER"
        case "EMAIL_NOT_FOUND":
            return "EMAIL_NOT_FOUND"
        case "INVALID_PASSWORD":
            return "INVALID_PASSWORD"
        case "USER_DISABLED":
            return "USER_DISABLED"
        case "INVALID_EMAIL":
            return LocaleKeys.Errors.invalidEmail.localized
        case "MISSING_PASSWORD":
            return "MISSING_PASSWORD"
        case "WEAK_PASSWORD":
            return "WEAK_PASSWORD"
        case "EXPIRED_OOB_CODE":
            return "EXPIRED_OOB_CODE"
        case "INVALID_OOB_CODE":
            return "INVALID_OOB_CODE"
        case "CREDENTIAL_TOO_OLD_LOGIN_AGAIN":
            return "CREDENTIAL_TOO_OLD_LOGIN_AGAIN"
        case "INVALID_ID_TOKEN":
            return "INVALID_ID_TOKEN"
        case "USER_NOT_FOUND":
            return "USER_NOT_FOUND"
        case "INVALID_REFRESH_TOKEN":
            return "INVALID_REFRESH_TOKEN"
        case "TOKEN_EXPIRED":
            return "TOKEN_EXPIRED"
        case "INVALID_CUSTOM_TOKEN":
            return "INVALID_CUSTOM_TOKEN"
        case "CUSTOM_TOKEN_MISMATCH":
            return "CUSTOM_TOKEN_MISMATCH"
        default:
            return LocaleKeys.Errors.unExpectedError.localized(with: message)
        }
    }
}
