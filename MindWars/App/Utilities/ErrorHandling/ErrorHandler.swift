//
//  ErrorHandler.swift
//  MindWars
//
//  Created by Yiğit Tilki on 15.07.2025.
//

import Foundation

enum FirebaseErrorDomain {
    case auth
    case firestore
}

struct FirebaseError {
    static func data(message: String, domain: FirebaseErrorDomain) -> String {
        switch domain {
        case .auth:
            return FirebaseAuthErrorMapper.map(message)
        case .firestore:
            return FirebaseAuthErrorMapper.map(message)
        }
    }
}
