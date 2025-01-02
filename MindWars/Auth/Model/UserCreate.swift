//
//  UserCreate.swift
//  MindWars
//
//  Created by Yiğit Tilki on 22.12.2024.
//

import Foundation

class UserCreateModel: Codable {
    let username, email, birthDate, password: String?

    init(username: String?, email: String?, birthDate: String?, password: String?) {
        self.username = username
        self.email = email
        self.birthDate = birthDate
        self.password = password
    }
}

typealias UserCreate = [UserCreateModel]
