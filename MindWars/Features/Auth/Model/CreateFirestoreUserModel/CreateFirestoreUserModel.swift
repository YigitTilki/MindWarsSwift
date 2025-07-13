//
//  CreateFirestoreUserResponseModel.swift
//  MindWars
//
//  Created by Yiğit Tilki on 12.07.2025.
//

import Foundation

struct CreateFirestoreUserModel: Codable {
    @FirestoreField var id: String
    @FirestoreField var email: String
    @FirestoreField var userName: String
    @FirestoreField var birthDate: Date
}
