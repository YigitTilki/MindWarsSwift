//
//  SignUpPostModel.swift
//  MindWars
//
//  Created by Yiğit Tilki on 12.07.2025.
//

import Foundation
import SwiftUICore

struct AuthUserPostModel: Encodable {
    let email, password: String
    let returnSecureToken: Bool = true
    
    init(email: String, password: String) {
           self.email = email.trimmingCharacters(in: .whitespacesAndNewlines)
           self.password = password
       }
}
