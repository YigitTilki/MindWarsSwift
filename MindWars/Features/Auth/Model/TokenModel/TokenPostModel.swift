//
//  GetTokenPostModel.swift
//  MindWars
//
//  Created by Yiğit Tilki on 12.07.2025.
//

import Foundation

struct TokenPostModel: Encodable {
    let grant_type: String = "refresh_token"
    let refresh_token: String
}
