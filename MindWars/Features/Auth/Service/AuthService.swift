//
//  AuthService.swift
//  MindWars
//
//  Created by Yiğit Tilki on 8.03.2025.
//

import Foundation
import FirebaseAuth
import FirebaseFirestore

// MARK: - Auth Service
struct AuthService {
    
    private static let auth = Auth.auth()
    private static let usersCollection = CollectionEnums.users.reference
    
    //MARK: - Auth Sign In
    static func signIn(email: String, password: String) async -> Result<User, Error> {
        await FirebaseService.execute(
            request: "Sign in user",
            operation: {
                let result = try await auth.signIn(withEmail: email, password: password)
                return result.user
            }
        )
    }
    //MARK: - Auth Sign Up
    static func signUp(email: String, password: String) async -> Result<User, Error> {
        await FirebaseService.execute(
            request: "Sign up user",
            operation: {
                let result = try await auth.createUser(withEmail: email, password: password)
                return result.user
            }
        )
    }
    //MARK: - Save User to Firestore
    static func saveUserToFirestore(data: UserCreateModel) async -> Result<Void, Error> {
        await FirebaseService.execute(
            request: "Save User To Firestore",
            operation: {
                let path: () throws -> DocumentReference = {
                    usersCollection.document(data.id ?? "")
                    }
                try await FirebaseService.set(path: path, data: data.toJson())
            }
        )
    }

    
//    func signOut() async throws {
//        _ = await FirebaseService.execute(
//            request: "Sign out user",
//            operation: {
//                try auth.signOut()
//                return "User signed out successfully"
//            }
//        )
//    }
    
   static func getCurrentUser() -> User? {
        auth.currentUser
    }
}
