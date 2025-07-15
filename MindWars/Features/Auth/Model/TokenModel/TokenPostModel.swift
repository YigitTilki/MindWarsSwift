//
//  GetTokenPostModel.swift
//  MindWars
//
//  Created by Yiğit Tilki on 12.07.2025.
//

import Foundation

struct TokenPostModel: Encodable {
    let grantType: String = "refresh_token"
    let refreshToken: String
    
    enum CodingKeys: String, CodingKey {
        case grantType = "grant_type"
        case refreshToken = "refresh_token"
    }
}
