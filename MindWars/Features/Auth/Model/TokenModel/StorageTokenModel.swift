//
//  StorageTokenModel.swift
//  MindWars
//
//  Created by Yiğit Tilki on 12.07.2025.
//

import RealmSwift
import Foundation

final class TokenModel: Object {
    @Persisted(primaryKey: true) var id: String = "auth_token"
    @Persisted var idToken: String
    @Persisted var refreshToken: String
    @Persisted var expiresIn: String
}
