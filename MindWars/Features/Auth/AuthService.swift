//
//  AuthService.swift
//  MindWars
//
//  Created by Yiğit Tilki on 8.03.2025.
//

import Foundation
import FirebaseAuth

// MARK: - Auth Service
struct AuthService {
    
    static func signIn(email: String, password: String) async -> Result<User, Error> {
        await FirebaseService.execute(
            request: "Sign in user",
            operation: {
                let result = try await Auth.auth().signIn(withEmail: email, password: password)
                return result.user
            }
        )
    }

    
    func signUp(email: String, password: String) async {
        _ = await FirebaseService.execute(
            request: "Sign up user",
            operation: {
                let result = try await Auth.auth().createUser(withEmail: email, password: password)
                return result.user
            }
        )
    }
    
    func signOut() async throws {
        _ = await FirebaseService.execute(
            request: "Sign out user",
            operation: {
                try Auth.auth().signOut()
                return "User signed out successfully"
            }
        )
    }
    
    func getCurrentUser() -> User? {
        Auth.auth().currentUser
    }
}
