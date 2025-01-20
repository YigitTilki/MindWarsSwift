//
//  PlaySolorRedMindWarView.swift
//  MindWars
//
//  Created by Yiğit Tilki on 12.01.2025.
//

import Foundation

@MainActor
class PlaySoloRedMindWarViewModel: BaseViewModel, ObservableObject {
    
    @Published var questionList: [BaseQuestionModel] = []
    
    func getQuestionAnswer() async {
        await performLoadingTask { [self] in
            do {
                let snapshot = try await db.collection("questions")
                    .document("1")
                    .collection("questionAnswer")
                    .document("parts")
                    .collection("01")
                    .getDocuments()
                
                let documents = snapshot.documents
                //let randomDocuments = documents.shuffled().prefix(3)
                
                for document in documents {
                    if let question = try? document.data(as: AddQuestionAnswerModel.self) {
                        questionList.append(question)
                    } else {
                        print("🔥 Failed to decode document: \(document.documentID)")
                    }
                    
                }
            } catch {
                print("🔥 Error getting documents: \(error)")
            }
        }
    }
    func getMultipleChoice() async {
         
    }
    func getTrueFalse() async {
         
    }
    func getMismatchedDuo() async {
         
    }
    
}
