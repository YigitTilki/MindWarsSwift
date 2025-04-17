//
//  AddMultipleChoiceViewModel.swift
//  MindWars
//
//  Created by Yiğit Tilki on 11.01.2025.
//

import Foundation
import UIKit

@MainActor
class AddMultipleChoiceViewModel: AddRedQuestionsBaseViewModel, ObservableObject {
    @Published var answer1: String = ""
    @Published var answer2: String = ""
    @Published var answers1: [String] = []
    @Published var answers2: [String] = []
    @Published var correctAnswer1: String = ""
    @Published var correctAnswer2: String = ""
    var correctAnswerIndex1: Int?
    var correctAnswerIndex2: Int?

    func addQuestion() async {
        correctAnswerIndex1 = answers1.firstIndex(of: correctAnswer1)
        correctAnswerIndex2 = answers2.firstIndex(of: correctAnswer2)

        // TODO: Implement author id
        let tr = MultipleChoiceQuestionDetailModel(question: question1, answers: answers1, answerDescription: answerDescription1, correctAnswerIndex: correctAnswerIndex1)
        let en = MultipleChoiceQuestionDetailModel(question: question2, answers: answers2, answerDescription: answerDescription2, correctAnswerIndex: correctAnswerIndex2)
        let questionModel = MultipleChoiceQuestionModel(en: en, tr: tr)
        let questionAnswerModel = MultipleChoiceModel(part: selectedPart.rawValue, authorId: "SKwlaoAomALQ", createdAt: Date(), difficulty: difficulty.intValue, language: language.intValue, type: type.intValue, time: time.rawValue, translations: questionModel, imageUrl: "")

        await performLoadingTask { [self] in
            do {
                guard selectedPart != .none else {
                    alertItem = AlertContext.questionPartCantEmpty
                    return
                }

                let section = RedQuestionSectionEnum(rawValue: 2) ?? .none

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
        correctAnswerIndex1 = nil
        correctAnswer1 = ""
        correctAnswerIndex2 = nil
        correctAnswer2 = ""
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
            if question1.isEmpty || question2.isEmpty || answers1.isEmpty || answers2.isEmpty || correctAnswer1.isEmpty || correctAnswer2.isEmpty || answers1.count < 3 || answers2.count < 3 {
                return true
            }
        } else if language == .tr {
            if question1.isEmpty || answers1.isEmpty || correctAnswer1.isEmpty || answers1.count < 3 {
                return true
            }
        } else if language == .en {
            if question2.isEmpty || answers2.isEmpty || correctAnswer2.isEmpty || answers2.count < 3 {
                return true
            }
        }

        return false
    }

    func indexToLetter(_ index: Int) -> String {
        guard let scalar = UnicodeScalar(65 + index) else { return "?" }
        return String(Character(scalar))
    }
}
