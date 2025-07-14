//
//  FirestorePostModel.swift
//  MindWars
//
//  Created by Yiğit Tilki on 13.07.2025.
//

import Foundation

struct FirestorePostModel<T: Codable>: Codable {
    let fields: T
}
