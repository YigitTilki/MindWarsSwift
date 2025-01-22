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
    @Published var questionAnswerQuestion = ""
    
    func getQuestions() async {
        await performLoadingTask { [self] in
            await getQuestionAnswer()
            await getTrueFalse()
            await getMultipleChoice()
            await getMismatchedDuo()
        }
    }
    
    func getQuestionAnswer() async {
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
    func getMultipleChoice() async {
        do {
            let snapshot = try await db.collection("questions")
                .document("1")
                .collection("multipleChoice")
                .document("parts")
                .collection("01")
                .getDocuments()
            
            let documents = snapshot.documents
            //let randomDocuments = documents.shuffled().prefix(3)
            
            for document in documents {
                if let question = try? document.data(as: AddMultipleChoiceModel.self) {
                    questionList.append(question)
                } else {
                    print("🔥 Failed to decode document: \(document.documentID)")
                }
                
            }
        } catch {
            print("🔥 Error getting documents: \(error)")
        }
    }
    func getTrueFalse() async {
        do {
            let snapshot = try await db.collection("questions")
                .document("1")
                .collection("trueFalse")
                .document("parts")
                .collection("01")
                .getDocuments()
            
            let documents = snapshot.documents
            //let randomDocuments = documents.shuffled().prefix(3)
            
            for document in documents {
                if let question = try? document.data(as: AddTrueFalseModel.self) {
                    questionList.append(question)
                } else {
                    print("🔥 Failed to decode document: \(document.documentID)")
                }
                
            }
        } catch {
            print("🔥 Error getting documents: \(error)")
        }

    }
    func getMismatchedDuo() async {
        do {
            let snapshot = try await db.collection("questions")
                .document("1")
                .collection("mismatchedDuo")
                .document("parts")
                .collection("01")
                .getDocuments()
            
            let documents = snapshot.documents
            //let randomDocuments = documents.shuffled().prefix(3)
            
            for document in documents {
                if let question = try? document.data(as: AddMismatchedDuoModel.self) {
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
