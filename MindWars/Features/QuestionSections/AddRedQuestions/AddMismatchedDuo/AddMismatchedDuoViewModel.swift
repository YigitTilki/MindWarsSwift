//
//  AddMismatchedDuoViewModel.swift
//  MindWars
//
//  Created by Yiğit Tilki on 12.01.2025.
//

import Foundation
import UIKit

@MainActor
class AddMismatchedDuoViewModel: AddRedQuestionsBaseViewModel, ObservableObject {
    
    @Published var answer1: String = ""
    @Published var answer2: String = ""
    @Published var answers1: [String] = []
    @Published var answers2: [String] = []
    @Published var correctAnswer1: String = ""
    @Published var correctAnswer2: String = ""
    @Published var correctAnswer3: String = ""
    @Published var correctAnswer4: String = ""
    var correctAnswerIndexes1: [Int]?
    var correctAnswerIndexes2: [Int]?
    
    func addQuestion() async {
        
        let correctAnswerIndex1 = answers1.firstIndex(of: correctAnswer1) ?? -1
        let correctAnswerIndex2 = answers1.firstIndex(of: correctAnswer2) ?? -1
        correctAnswerIndexes1 = [correctAnswerIndex1,correctAnswerIndex2]
        
        let correctAnswerIndex3 = answers2.firstIndex(of: correctAnswer3) ?? -1
        let correctAnswerIndex4 = answers2.firstIndex(of: correctAnswer4) ?? -1
        correctAnswerIndexes2 = [correctAnswerIndex3,correctAnswerIndex4]
        
        
        //TODO: Implement author id
        let tr = MismatchedDuoQuestionDetailModel(question: question1, answers: answers1, answerDescription: answerDescription1, correctAnswerIndexes: correctAnswerIndexes1)
        let en = MismatchedDuoQuestionDetailModel(question: question2, answers: answers2, answerDescription: answerDescription2, correctAnswerIndexes: correctAnswerIndexes2)
        let questionModel = MismatchedDuoQuestionModel(en: en, tr: tr)
        let questionAnswerModel = MismatchedDuoModel(authorId: "SKwlaoAomALQ", createdAt: Date(), difficulty: difficulty.intValue, language: language.intValue, type: type.intValue, time: time.rawValue, translations: questionModel, imageUrl: "")
        
        await performLoadingTask { [self] in
            do {
                guard selectedPart != .none else {
                    alertItem = AlertContext.questionPartCantEmpty
                    return
                }
                
                let section = RedQuestionSectionEnum(rawValue: 4) ?? .none
                
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
        answers1 = []
        question2 = ""
        answerDescription2 = ""
        answers2 = []
        correctAnswerIndexes1 = nil
        correctAnswer1 = ""
        correctAnswer2 = ""
        correctAnswerIndexes2 = nil
        correctAnswer3 = ""
        correctAnswer4 = ""
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
            if  question1.isEmpty || question2.isEmpty || answers1.isEmpty || answers2.isEmpty || correctAnswer1.isEmpty || correctAnswer2.isEmpty || correctAnswer3.isEmpty || correctAnswer4.isEmpty || answers1.count < 5 || answers2.count < 5 {
                return true
            }
        }
        else if language == .tr {
            if question1.isEmpty || answers1.isEmpty || correctAnswer1.isEmpty || correctAnswer2.isEmpty || answers1.count < 5 {
                return true
            }
        }
        else if language == .en {
            if question2.isEmpty || answers2.isEmpty || correctAnswer3.isEmpty || correctAnswer4.isEmpty || answers2.count < 5 {
                return true
            }
        }
        
        return false
        
    }
    
    func indexToLetter(_ index: Int) -> String {
        guard let scalar = UnicodeScalar(65 + index) else { return "?" }
        return String(Character(scalar))
    }
    
    var filteredAnswersForAnswers1: [String] {
            answers1.filter { $0 != correctAnswer1 }
        }
    
    var filteredAnswersForAnswers2: [String] {
            answers2.filter { $0 != correctAnswer3 }
        }
    
}
