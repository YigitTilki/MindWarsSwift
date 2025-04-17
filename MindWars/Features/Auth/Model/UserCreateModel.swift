//
//  UserCreateModel.swift
//  MindWars
//
//  Created by Yiğit Tilki on 22.12.2024.
//

import Foundation

struct UserCreateModel: ToJsonConvertible, Identifiable {
    let id, username, email: String?
    let birthDate: Date?
}


struct CreateFirestoreUserPostModel: Codable {
    let id, username, email: String?
    let birthDate: Date?
}
