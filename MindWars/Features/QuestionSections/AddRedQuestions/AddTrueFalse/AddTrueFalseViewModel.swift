//
//  AddTrueFalseViewModel.swift
//  MindWars
//
//  Created by Yiğit Tilki on 11.01.2025.
//

import Foundation
import UIKit

@MainActor
class AddTrueFalseViewModel: BaseViewModel, ObservableObject {
    
    @Published var answer1: Bool = false
    @Published var answer2: Bool = false
    
    func addQuestion() async {
        //TODO: Implement author id
        let tr = AddTrueFalseQuestionDetailModel(question: question1, answer: answer1, answerDescription: answerDescription1)
        let en = AddTrueFalseQuestionDetailModel(question: question2, answer: answer2, answerDescription: answerDescription2)
        let questionModel = AddTrueFalseQuestionModel(en: en, tr: tr)
        let questionAnswerModel = AddTrueFalseModel(authorId: "SKwlaoAomALQ", createdAt: Date(), difficulty: difficulty.intValue, language: language.intValue, type: type.intValue, time: time.rawValue, translations: questionModel, imageUrl: ""
            
        )
        
        
        await performLoadingTask { [self] in
            do {
                guard selectedPart != .none else {
                    alertItem = AlertContext.questionPartCantEmpty
                    return
                }
                
                let section = RedQuestionSectionEnum(rawValue: 3) ?? .none
                
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
        question1 = ""
        answerDescription1 = ""
        answer1 = false
        question2 = ""
        answerDescription2 = ""
        answer2 = false
        selectedPart = .none
        language = .tr
        difficulty = .medium
        type = .general
        isImageQuestion = false
        time = .thirtySec
        lengthOfPart = ""
        selectedImage = nil
    }
    
    func isFieldsEmpty() -> Bool {
        if language == .both {
            if  question1.isEmpty || question2.isEmpty {
                return true
            }
        }
        else if language == .tr {
            if question1.isEmpty {
                return true
            }
        }
        else if language == .en {
            if question2.isEmpty {
                return true
            }
        }
        
        return false
        
    }
    
  
    
}
