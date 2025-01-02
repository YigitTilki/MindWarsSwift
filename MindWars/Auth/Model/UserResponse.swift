//
//  User.swift
//  MindWars
//
//  Created by Yiğit Tilki on 22.12.2024.
//

import Foundation

// MARK: - UserElement
class UserResponseModel: Codable {
    let id, username, email, birthDate: String?

    init(id: String?, username: String?, email: String?, birthDate: String?) {
        self.id = id
        self.username = username
        self.email = email
        self.birthDate = birthDate
    }
}

typealias UserResponse = [UserResponseModel]


