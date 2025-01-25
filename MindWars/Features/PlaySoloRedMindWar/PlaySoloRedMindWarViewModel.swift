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
            let answerValue = question.translations.tr.answers.contains(questionAnswerAnswer)
            await nextQuestion(description: question.translations.tr.answerDescription, id: question.id, answerValue: answerValue, questionType: RedQuestionSectionEnum.questionAnswer.collectionName)
            questionAnswerAnswer = ""
        }
        if let question = question as? TrueFalseModel {
            
        }
        
    }
    
    func nextQuestion(description: String?, id: String?, answerValue: Bool, questionType: String) async {
        if answerValue {
            score += 1
            alertItem = AlertItem(
                title: Text("Correct!"),
                message: Text(description ?? ""),
                dismissButton: .default(Text("Next")) {
                    self.currentQuestionIndex += 1
                }
            )
            await increaseInCorrectAnswerCount(questionId: id ?? "",questionType: questionType)
        } else {
            alertItem = AlertItem(
                title: Text("Hata!"),
                message: Text(description ?? ""),
                dismissButton: .default(Text("Next")) {
                    self.currentQuestionIndex += 1
                }
            )
            await increaseInCorrectAnswerCount(questionId: id ?? "",questionType: questionType)
        }
        
    }
    
    
    func increaseCorrectAnswerCount(questionId: String, questionType: String) async {
        await RedMindWarService().increaseCorrectAnswerCount(questionId: questionId, part: "01", questionType: questionType)
    }
    
    func increaseInCorrectAnswerCount(questionId: String, questionType: String) async {
        await RedMindWarService().increaseInCorrectAnswerCount(questionId: questionId, part: "01", questionType: questionType)
    }
    
    
    func getExplanationForCurrentQuestion() -> Translations? {
        guard currentQuestionIndex < questionList.count else { return nil }
        let question = questionList[currentQuestionIndex]
        
        switch question {
        case is TrueFalseModel:
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
        let explainsData = await RedMindWarService().getExplains()
        explains = explainsData
    }
    
    func getQuestionAnswer() async {
        let questions = await RedMindWarService().getQuestionAnswerQuestions(part: "01")
        questionList.append(contentsOf: questions)
    }
    
    func getMultipleChoice() async {
        let questions = await RedMindWarService().getMultipleChoiceQuestions(part: "01")
        questionList.append(contentsOf: questions)
    }
    
    func getTrueFalse() async {
        let questions = await RedMindWarService().getTrueFalseQuestions(part: "01")
        questionList.append(contentsOf: questions)
    }
    
    func getMismatchedDuo() async {
        let questions = await RedMindWarService().getMismatchedDuoQuestions(part: "01")
        questionList.append(contentsOf: questions)
    }
}
