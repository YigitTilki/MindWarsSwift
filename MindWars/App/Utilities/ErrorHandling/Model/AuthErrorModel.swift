//
//  AuthErrorModel.swift
//  MindWars
//
//  Created by Yiğit Tilki on 15.07.2025.
//

import Foundation

struct FirebaseErrorResponse: Codable, Error {
    let error: FirebaseErrorDetail
}

struct FirebaseErrorDetail: Codable {
    let code: Int
    let message: String
    let errors: [FirebaseErrorItem]?
}

struct FirebaseErrorItem: Codable {
    let message: String
    let domain: String
    let reason: String
}

