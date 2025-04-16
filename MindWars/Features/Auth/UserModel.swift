//
//  UserModel.swift
//  MindWars
//
//  Created by Yiğit Tilki on 8.03.2025.
//

import Foundation

import FirebaseFirestore


struct UserModel: Codable,Identifiable {
    @DocumentID var id: String?
    let email: String
    let fullName: String
    let birthDate: Date
    var createdAt = Date()
    
    
}
