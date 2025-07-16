//
//  ErrorMessageProvider.swift
//  MindWars
//
//  Created by Yiğit Tilki on 15.07.2025.
//

import Foundation

struct ErrorMessageProvider {
    static func firebaseErrorMessage(error: Error) -> String {
        if let firebaseError = error as? FirebaseErrorResponse {
            return FirebaseError.data(
                message: firebaseError.error.message,
                domain: .firebase
            )
        }

        return error.localizedDescription.isEmpty
        ?   LocaleKeys.Errors.unExpectedError.localized(with: "")
            : error.localizedDescription
    }
}
