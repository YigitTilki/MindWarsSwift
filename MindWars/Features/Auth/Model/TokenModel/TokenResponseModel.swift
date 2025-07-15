//
//  GetTokenResponseModel.swift
//  MindWars
//
//  Created by Yiğit Tilki on 12.07.2025.
//

import Foundation

struct TokenResponseModel: Codable {
    let idToken, expiresIn, tokenType, refreshToken, userId, accessToken,
        projectId: String

    enum CodingKeys: String, CodingKey {
        case idToken = "id_token"
        case expiresIn = "expires_in"
        case tokenType = "token_type"
        case refreshToken = "refresh_token"
        case userId = "user_id"
        case projectId = "project_id"
        case accessToken = "access_token"
    }
}

extension TokenResponseModel: TokenStorageProtocol {}
