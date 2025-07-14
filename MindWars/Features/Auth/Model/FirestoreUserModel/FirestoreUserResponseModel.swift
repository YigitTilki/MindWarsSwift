//
//  FirestoreUserResponseModel.swift
//  MindWars
//
//  Created by Yiğit Tilki on 13.07.2025.
//

import Foundation

struct FirestoreUserResponseModel: Codable {
    @FirestoreField var id: String
    @FirestoreField var email: String
    @FirestoreField var userName: String
    @FirestoreField var birthDate: Date
}
