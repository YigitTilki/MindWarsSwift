//
//  FirestoreService.swift
//  MindWars
//
//  Created by Yiğit Tilki on 9.02.2025.
//

import Foundation
import FirebaseFirestore

// MARK: - Generic Firestore Service
struct FirebaseService {
     static let db = Firestore.firestore()
    
    //MARK: - Generic Log
    static func log(request: String, result: Result<Any, Error>) {
        switch result {
        case .success(let data):
            print("🔥 [SUCCESS] \(request)")
            //print("✅ Response: \(data)")
        case .failure(let error):
            print("🔥 [FAILURE] \(request)")
            print("🚨 Error: \(error.localizedDescription)")
        }
    }
    
    // MARK: - Generic Fetch
    static func fetch<T: Decodable>(
        path: () throws -> DocumentReference,
        responseType: T.Type
    ) async throws -> T {
        let documentRef = try path()
        let snapshot = try await documentRef.getDocument()
        
        let data = try snapshot.data(as: T.self)
        return data
    }
    
    //MARK: - Generic Fetch Collection
    static func fetchCollection<T: Decodable>(
        path: () throws -> Query,
        responseType: [T].Type
    ) async throws -> [T] {
        let query = try path()
        let snapshot = try await query.getDocuments()
        
        return snapshot.documents.compactMap { try? $0.data(as: T.self) }
    }
    
    // MARK: - Generic Update
    static func update(
        path: () throws -> DocumentReference,
        data: [String: Any]
    ) async throws {
        let documentRef = try path()
        try await documentRef.updateData(data)
    }
    
    // MARK: - Generic Set
        static func set(
            path: () throws -> DocumentReference,
            data: [String: Any],
            merge: Bool = true
        ) async throws {
            let documentRef = try path()
            try await documentRef.setData(data, merge: merge)
        }
    
    
    // MARK: - Generic Execute
    static func execute<T>(
        request: String,
        operation: () async throws -> T
    ) async -> Result<T, Error> {
        do {
            let result = try await operation()
            FirebaseService.log(request: request, result: .success(result))
            return .success(result)
        } catch {
            FirebaseService.log(request: request, result: .failure(error))
            return .failure(error)
        }
    }

}
