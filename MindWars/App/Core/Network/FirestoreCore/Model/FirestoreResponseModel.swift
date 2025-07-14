//
//  FirestoreResponseModel.swift
//  MindWars
//
//  Created by Yiğit Tilki on 13.07.2025.
//

import Foundation

struct FirestoreResponseModel<T: Codable>: Codable {
    let name: String
    let fields: T
    let createTime: String?
    let updateTime: String?
}
