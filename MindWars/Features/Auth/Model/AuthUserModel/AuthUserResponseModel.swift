//
//  SignUpResponseModel.swift
//  MindWars
//
//  Created by Yiğit Tilki on 12.07.2025.
//

import Foundation

struct AuthUserResponseModel: Codable {
    let idToken, localId, expiresIn, refreshToken, email, kind: String
}
