//
//  ErrorHandler.swift
//  MindWars
//
//  Created by Yiğit Tilki on 15.07.2025.
//

import Foundation

enum FirebaseErrorDomain {
    case firebase
}

struct FirebaseError {
    static func data(message: String, domain: FirebaseErrorDomain) -> String {
        switch domain {
        case .firebase:
            return FirebaseAuthErrorMapper.map(message)
        }
    }
}
