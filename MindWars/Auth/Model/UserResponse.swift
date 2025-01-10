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

let mockUserResponseData: [UserResponseModel] = [
    UserResponseModel(id: "0001", username: "NemesisCran", email: "yiğit@gmail.com", birthDate: "2002-12-22"),
    UserResponseModel(id: "0002", username: "Sezen", email: "sezen@gmail.com", birthDate: "1980-12-04"),
    UserResponseModel(id: "0003", username: "Birol", email: "birol@gmail.com", birthDate: "1972-12-12"),
    UserResponseModel(id: "0004", username: "Yagiz", email: "yagiz@gmail.com", birthDate: "2016-12-19"),
]


