//
//  StorageProtocols.swift
//  MindWars
//
//  Created by Yiğit Tilki on 15.07.2025.
//

import Foundation

protocol FirestoreUserStorageProtocol {
    var id: String { get }
    var email: String { get }
    var userName: String { get }
    var birthDate: Date { get }
}

protocol TokenStorageProtocol {
    var idToken: String { get }
    var refreshToken: String { get }
    var expiresIn: String { get }
}
