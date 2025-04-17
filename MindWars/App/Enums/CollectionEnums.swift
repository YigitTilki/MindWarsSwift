//
//  CollectionEnums.swift
//  MindWars
//
//  Created by Yiğit Tilki on 17.04.2025.
//

import Foundation
import FirebaseFirestore

enum CollectionEnums: String {
    case users
    
    var reference: CollectionReference {
           return FirebaseService.db.collection(self.rawValue)
       }
}
