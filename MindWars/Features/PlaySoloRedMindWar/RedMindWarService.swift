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
    
    func increaseCorrectAnswerCount(questionId: String, part: String, questionType: String) async {
        do {
            try await db.collection("questions")
                .document("1")
                .collection(questionType)
                .document("parts")
                .collection(part)
                .document(questionId)
                .updateData([
                    "correctAnswers": FieldValue.increment(Int64(1))
                ])
            
            
        } catch {
            print(error)
        }
    }
    
    func increaseInCorrectAnswerCount(questionId: String, part: String, questionType: String) async {
        do {
            try await db.collection("questions")
                .document("1")
                .collection(questionType)
                .document("parts")
                .collection(part)
                .document(questionId)
                .updateData([
                    "incorrectAnswers": FieldValue.increment(Int64(1))
                ])
            
            
        } catch {
            print(error)
        }
    }
    
    func getExplains() async -> RedQuestionSectionExplainModel? {
        do {
            let snapshot = try await db.collection("sectionDescriptions")
                .document("1")
                .getDocument()
            
            if let explainsData = try? snapshot.data(as: RedQuestionSectionExplainModel.self) {
                return explainsData
            } else {
                return nil
            }
        } catch {
            print("🔥 Error getting documents: \(error)")
            return nil
        }
    }
    
    func getMismatchedDuoQuestions(part: String) async -> [AddMismatchedDuoModel] {
        do {
            let snapshot = try await db.collection("questions")
                .document("1")
                .collection(RedQuestionSectionEnum.mismatchedDuo.collectionName)
                .document("parts")
                .collection(part)
                .getDocuments()
            
            let documents = snapshot.documents
            
            let questions = documents.compactMap { document in
                try? document.data(as: AddMismatchedDuoModel.self)
            }
            
            return questions
            
        } catch {
            print("🔥 Error getMismatchedDuos: \(error)")
            return []
        }
    }
    
    func getQuestionAnswerQuestions(part: String) async -> [QuestionAnswerModel] {
        do {
            let snapshot = try await db.collection("questions")
                .document("1")
                .collection(RedQuestionSectionEnum.questionAnswer.collectionName)
                .document("parts")
                .collection(part)
                .getDocuments()
            
            let documents = snapshot.documents
            
            let questions = documents.compactMap { document in
                try? document.data(as: QuestionAnswerModel.self)
            }
            
            return questions
            
        } catch {
            print("🔥 Error getQuestionAnswers: \(error)")
            return []
        }
    }
    
    func getMultipleChoiceQuestions(part: String) async -> [AddMultipleChoiceModel] {
        do {
            let snapshot = try await db.collection("questions")
                .document("1")
                .collection(RedQuestionSectionEnum.multipleChoice.collectionName)
                .document("parts")
                .collection(part)
                .getDocuments()
            
            let documents = snapshot.documents
            
            let questions = documents.compactMap { document in
                try? document.data(as: AddMultipleChoiceModel.self)
            }
            
            return questions
            
        } catch {
            print("🔥 Error getMultipleChoices: \(error)")
            return []
        }
    }
    
    func getTrueFalseQuestions(part: String) async -> [TrueFalseModel] {
        do {
            let snapshot = try await db.collection("questions")
                .document("1")
                .collection(RedQuestionSectionEnum.trueFalse.collectionName)
                .document("parts")
                .collection(part)
                .getDocuments()
            
            let documents = snapshot.documents
            
            let questions = documents.compactMap { document in
                try? document.data(as: TrueFalseModel.self)
            }
            
            return questions
            
        } catch {
            print("🔥 Error getting documents: \(error)")
            return []
        }
    }
}
