//
//  StorageUserModel.swift
//  MindWars
//
//  Created by Yiğit Tilki on 13.07.2025.
//

import RealmSwift
import Foundation

final class StorageUserModel: Object {
    @Persisted(primaryKey: true) var keyId: String = "user_details"
    @Persisted var username: String
    @Persisted var userId: String
    @Persisted var email: String
    @Persisted var birthDate: Date
}
