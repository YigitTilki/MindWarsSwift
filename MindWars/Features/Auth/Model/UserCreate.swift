//
//  UserCreate.swift
//  MindWars
//
//  Created by Yiğit Tilki on 22.12.2024.
//

import Foundation

class UserCreateModel: Codable, Identifiable {
    let id, username, email: String?
    let birthDate: Date?

    init(id: String?,username: String?, email: String?, birthDate: Date?) {
        self.id = id
        self.username = username
        self.email = email
        self.birthDate = birthDate
    }
}

typealias UserCreate = [UserCreateModel]

extension UserCreateModel {
    func toDictionary() -> [String: Any] {
        guard let data = try? JSONEncoder().encode(self),
              let dictionary = try? JSONSerialization.jsonObject(with: data) as? [String: Any] else {
            return [:]
        }
        return dictionary
    }
}
