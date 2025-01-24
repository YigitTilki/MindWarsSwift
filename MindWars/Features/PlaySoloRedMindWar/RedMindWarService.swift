//
//  RedMindWarService.swift
//  MindWars
//
//  Created by Yiğit Tilki on 24.01.2025.
//

import Foundation
import FirebaseFirestore

struct RedMindWarService {
    let db = Firestore.firestore()
    
    func getMismatchedDuos() async -> [QueryDocumentSnapshot] {
        do {
            let snapshot = try await db.collection("questions")
                .document("1")
                .collection("mismatchedDuo")
                .document("parts")
                .collection("01")
                .getDocuments()
            
            let documents = snapshot.documents

            return documents
           
        } catch {
            print("🔥 Error getMismatchedDuos: \(error)")
            return []
        }
    }
    
    func getQuestionAnswers() async -> [QueryDocumentSnapshot] {
        do {
            let snapshot = try await db.collection("questions")
                .document("1")
                .collection("questionAnswer")
                .document("parts")
                .collection("01")
                .getDocuments()
            
            let documents = snapshot.documents
            
            return documents
            
        } catch {
            print("🔥 Error getQuestionAnswers: \(error)")
            return []
        }
    }
}
