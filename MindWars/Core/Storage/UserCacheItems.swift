//
//  UserCacheItems.swift
//  MindWars
//
//  Created by Yiğit Tilki on 12.07.2025.
//

import Foundation

enum UserCacheKeys: String {
    case idToken
}

extension UserCacheProtocol {
    func read(key: UserCacheKeys) -> String {
        guard let value = UserDefaults.standard.value(forKey: key.rawValue) as? String else { return "" }
        return value
    }

    func save(key: UserCacheKeys, value: String) {
        UserDefaults.standard.set(value, forKey: key.rawValue)
    }

    func remove(key: UserCacheKeys) {
        UserDefaults.standard.removeObject(forKey: key.rawValue)
    }
}
