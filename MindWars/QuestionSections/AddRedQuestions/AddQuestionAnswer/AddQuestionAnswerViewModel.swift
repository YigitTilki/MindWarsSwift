//
//  RedQuestionsViewModel.swift
//  MindWars
//
//  Created by Yiğit Tilki on 9.01.2025.
//

import Foundation
import UIKit

@MainActor
class AddQuestionAnswerViewModel: BaseViewModel, ObservableObject {
    
    @Published var question1: String = ""
    @Published var question2: String = ""
    @Published var answer1: String = ""
    @Published var answers1: [String] = []
    @Published var answer2: String = ""
    @Published var answers2: [String] = []
    
    @Published var selectedPart: QuestionPart = .none
    @Published var difficulty: QuestionDifficulty = .medium
    @Published var language: Languages = .tr
    @Published var type: QuestionType = .general
    @Published var time: QuestionTime = .thirtySec
    
    @Published var lengthOfPart: String = ""
    @Published var alertItem: AlertItem?
    @Published var isImageQuestion: Bool = false
    @Published var isPickerPresented = false
    @Published var selectedImage: UIImage?
    
    func addQuestion() async {
        //TODO: Implement author id
        let tr = QuestionAnswerQuestionDetailModel(question: question1, answers: answers1)
        let en = QuestionAnswerQuestionDetailModel(question: question2, answers: answers2)
        let questionModel = QuestionAnswerQuestionModel(en: en, tr: tr)
        let questionAnswerModel = QuestionAnswerModel(
            translations: questionModel,
            difficulty: difficulty.intValue,
            language: language.intValue,
            type: type.intValue,
            time: time.rawValue,
            createdAt: Date(),
            authorId: "SKwlaoAomALQ",
            imageUrl: ""
        )
        
        
        await performLoadingTask { [self] in
            do {
                guard selectedPart != .none else {
                    alertItem = AlertContext.questionPartCantEmpty
                    return
                }
                
                let section = RedQuestionSectionEnum(rawValue: 1) ?? .none
                
                try db.collection("questions")
                    .document("1")
                    .collection(section?.collectionName ?? "")
                    .document("parts")
                    .collection(selectedPart.rawValue)
                    .addDocument(from: questionAnswerModel)
                
                clearFields()
                alertItem = AlertContext.questionCreatedSuccesfully
                
            } catch {
                print("Error addQuestion: \(error)")
                alertItem = AlertContext.unexpectedError
            }
            
        }
    }
    
    func clearFields() {
        answers1.removeAll()
        question1 = ""
        answers2.removeAll()
        question2 = ""
        selectedPart = .none
        language = .tr
        difficulty = .medium
        type = .general
        isImageQuestion = false
    }
    
    
    func getPartLength(sectionId: Int) async {
        await performLoadingTask { [self] in
            do {
                let section = RedQuestionSectionEnum(rawValue: sectionId) ?? .none
                
                let partLength = try await db.collection("questions")
                    .document("1")
                    .collection(section?.collectionName ?? "")
                    .document("parts")
                    .collection(selectedPart.rawValue)
                    .getDocuments()
                    .count
                
                lengthOfPart = String(partLength)
                
                
            } catch {
                print("Error getPartLength: \(error)")
                alertItem = AlertContext.unexpectedError
            }
        }
    }
    
    func isFieldsEmpty1() -> Bool {
        if language == .both {
            if answers1.isEmpty || question1.isEmpty || answers2.isEmpty || question2.isEmpty {
                return true
            }
        }
        else if language == .tr {
            if answers1.isEmpty || question1.isEmpty {
                return true
            }
        }
        else if language == .en {
            if answers2.isEmpty || question2.isEmpty {
                return true
            }
        }
        
        return false
        
    }
    
    
    
}



