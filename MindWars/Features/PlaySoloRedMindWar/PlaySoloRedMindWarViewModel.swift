//
//  PlaySolorRedMindWarView.swift
//  MindWars
//
//  Created by Yiğit Tilki on 12.01.2025.
//

import Foundation
import SwiftUICore
import FirebaseFirestore


@MainActor
class PlaySoloRedMindWarViewModel: BaseViewModel, ObservableObject {
    let db = Firestore.firestore()
    @Published var questionList: [BaseQuestionModel] = []
    @Published var explains: RedQuestionSectionExplainModel?
    @Published var currentQuestionIndex: Int = 0
    @Published var score: Int = 0
    @Published var questionAnswerAnswer: String = ""
    @Published var showAlert: Bool = false
    
    
    
    func submitQuestionAnswer() async {
        guard currentQuestionIndex < questionList.count else { return }
        let question = questionList[currentQuestionIndex]
        
        if let question = question as? QuestionAnswerModel {
            if question.translations.tr.answers.contains(questionAnswerAnswer) {
                score += 1
                alertItem = AlertItem(
                    title: Text("Correct!"),
                    message: Text(question.translations.tr.answerDescription ?? ""),
                    dismissButton: .default(Text("Next")) {
                        self.currentQuestionIndex += 1
                    }
                )
                await increaseCorrectAnswerCount(questionId: question.id ?? "")
            } else {
                alertItem = AlertItem(
                    title: Text("Hata!"),
                    message: Text(question.translations.tr.answerDescription ?? ""),
                    dismissButton: .default(Text("Next")) {
                        self.currentQuestionIndex += 1
                    }
                )
                await increaseInCorrectAnswerCount(questionId: question.id ?? "")
            }
        } else {
            print("Invalid question type.")
        }

        questionAnswerAnswer = ""
    }

    func nextQuestion(questionm: BaseQuestionModel?) async {
        score += 1
        alertItem = AlertItem(
            title: Text("Correct!"),
            message: Text(questionm. ?? ""),
            dismissButton: .default(Text("Next")) {
                self.currentQuestionIndex += 1
            }
        )
    }
    
    
    func increaseCorrectAnswerCount(questionId: String) async {
        do {
            try await db.collection("questions")
                .document("1")
                .collection("questionAnswer")
                .document("parts")
                .collection("01")
                .document(questionId)
                .updateData([
                    "correctAnswers": FieldValue.increment(Int64(1))
                ])
                
            
        } catch {
            print(error)
        }
    }
    
    func increaseInCorrectAnswerCount(questionId: String) async {
        do {
            try await db.collection("questions")
                .document("1")
                .collection("questionAnswer")
                .document("parts")
                .collection("01")
                .document(questionId)
                .updateData([
                    "incorrectAnswers": FieldValue.increment(Int64(1))
                ])
                
            
        } catch {
            print(error)
        }
    }
    
    
    func getExplanationForCurrentQuestion() -> Translations? {
        guard currentQuestionIndex < questionList.count else { return nil }
        let question = questionList[currentQuestionIndex]
        
        switch question {
        case is AddTrueFalseModel:
            return explains?.trueFalse
        case is QuestionAnswerModel:
            return explains?.questionAnswer
        case is AddMismatchedDuoModel:
            return explains?.mismatchedDuo
        case is AddMultipleChoiceModel:
            return explains?.multipleChoice
        default:
            return nil
        }
    }

    
    func getQuestions() async {
        await performLoadingTask { [self] in
            await getQuestionAnswer()
            await getTrueFalse()
            await getMultipleChoice()
            await getMismatchedDuo()
        }
    }
    
    func getExplains() async {
        do {
            let snapshot = try await db.collection("sectionDescriptions")
                .document("1")
                .getDocument()
            
            if let explainsData = try? snapshot.data(as: RedQuestionSectionExplainModel.self) {
                explains = explainsData
            } else {
                print("🔥 Failed to decode document: \(snapshot.documentID)")
            }
        } catch {
            print("🔥 Error getting documents: \(error)")
        }
    }
    
    func getQuestionAnswer() async {
        let documents = await RedMindWarService().getQuestionAnswers()
        
        for document in documents {
            if let question = try? document.data(as: QuestionAnswerModel.self) {
                questionList.append(question)
            }
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
        let documents = await RedMindWarService().getMismatchedDuos()
        
        for document in documents {
            if let question = try? document.data(as: AddMismatchedDuoModel.self) {
                questionList.append(question)
            }
        }
    }
    
}
