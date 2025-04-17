//
//  AddQuestionAnswerViewModel.swift
//  MindWars
//
//  Created by Yiğit Tilki on 9.01.2025.
//

import Foundation
import UIKit

@MainActor
class AddQuestionAnswerViewModel: AddRedQuestionsBaseViewModel, ObservableObject {
    @Published var answer1: String = ""
    @Published var answers1: [String] = []
    @Published var answer2: String = ""
    @Published var answers2: [String] = []

    func addQuestion() async {
        // TODO: Implement author id
        let tr = QuestionAnswerQuestionDetailModel(question: question1, answers: answers1, answerDescription: answerDescription1)
        let en = QuestionAnswerQuestionDetailModel(question: question2, answers: answers2, answerDescription: answerDescription2)
        let questionModel = QuestionAnswerQuestionModel(en: en, tr: tr)
        let questionAnswerModel = QuestionAnswerModel(
            part: selectedPart.rawValue,
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
        answerDescription1 = ""
        answers2.removeAll()
        question2 = ""
        answerDescription2 = ""
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
            if answers1.isEmpty || question1.isEmpty || answers2.isEmpty || question2.isEmpty {
                return true
            }
        } else if language == .tr {
            if answers1.isEmpty || question1.isEmpty {
                return true
            }
        } else if language == .en {
            if answers2.isEmpty || question2.isEmpty {
                return true
            }
        }

        return false
    }
}
