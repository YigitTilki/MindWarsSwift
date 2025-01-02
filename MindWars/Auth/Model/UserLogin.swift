//
//  UserLogin.swift
//  MindWars
//
//  Created by Yiğit Tilki on 22.12.2024.
//

import Foundation

class UserLoginModel: Codable {
    let email, password: String?

    init(email: String?, password: String?) {
        self.email = email
        self.password = password
    }
}

typealias UserLogin = [UserLoginModel]

let mockUserLoginData: [UserLoginModel] = [
    UserLoginModel(email: "yigittilkiw@gmail.com", password: "123456"),
    UserLoginModel(email: "sezen@gmail.com", password: "aA1234"),
]
