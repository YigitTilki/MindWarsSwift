//
//  CollectionEnums.swift
//  MindWars
//
//  Created by Yiğit Tilki on 17.04.2025.
//

import FirebaseFirestore
import Foundation

enum CollectionEnums: String {
    case users

    var reference: CollectionReference {
        return FirebaseService.db.collection(rawValue)
    }
}
