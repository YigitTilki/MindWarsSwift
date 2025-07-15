//
//  StorageTokenModel.swift
//  MindWars
//
//  Created by Yiğit Tilki on 12.07.2025.
//

import RealmSwift
import Foundation

final class StorageTokenModel: Object {
    @Persisted(primaryKey: true) var keyId: String = "auth_token"
    @Persisted var idToken: String
    @Persisted var refreshToken: String
    @Persisted var expiresIn: String
}

extension StorageTokenModel {
    convenience init(from model: TokenStorageProtocol) {
        self.init()
        self.idToken = model.idToken
        self.refreshToken = model.refreshToken
        self.expiresIn = model.expiresIn
    }
}
