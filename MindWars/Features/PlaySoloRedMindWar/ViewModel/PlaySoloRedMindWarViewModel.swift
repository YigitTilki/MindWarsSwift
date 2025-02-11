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
    
    let service = RedMindWarService()
    
    @Published var questionList: [BaseQuestionModel] = []
    @Published var explains: RedQuestionSectionExplainModel?
    
    @Published var currentQuestionIndex: Int = 0
    @Published var score: Int = 0
    
    @Published var questionAnswerAnswer: String = ""
    @Published var trueFalseAnswer: Bool?
    @Published var multipleChoiceAnswer: Int?
    @Published var mismatchedDuoAnswer: [Int] = []
    
    
    //MARK: - Submit Answer
    func submitQuestionAnswer() async {
        controlAnswer()
        
        if error == nil {
            if currentQuestionIndex < questionList.count {
                let question = questionList[currentQuestionIndex]
                
                if let question = question as? QuestionAnswerModel {
                    let answerValue = question.translations.tr.answers.contains(questionAnswerAnswer)
                    await nextQuestion(
                        description: question.translations.tr.answerDescription,
                        id: question.id,
                        answerValue: answerValue,
                        questionType: RedQuestionSectionEnum.questionAnswer.collectionName
                    )
                    questionAnswerAnswer = ""
                }
                
                if let question = question as? TrueFalseModel {
                    let answerValue = question.translations.tr.answer == trueFalseAnswer
            
                    await nextQuestion(
                        description: question.translations.tr.answerDescription,
                        id: question.id,
                        answerValue: answerValue,
                        questionType: RedQuestionSectionEnum.trueFalse.collectionName
                    )
                    trueFalseAnswer = nil
                }
                
                if let question = question as? MultipleChoiceModel {
                    let answerValue = question.translations.tr.correctAnswerIndex == multipleChoiceAnswer
                    
                    await nextQuestion(
                        description: question.translations.tr.answerDescription,
                        id: question.id,
                        answerValue: answerValue,
                        questionType: RedQuestionSectionEnum.multipleChoice.collectionName
                    )
                    multipleChoiceAnswer = nil
                }
                
                if let question = question as? MismatchedDuoModel {
                    let answerValue = question.translations.tr.correctAnswerIndexes == mismatchedDuoAnswer
                    
                    await nextQuestion(
                        description: question.translations.tr.answerDescription,
                        id: question.id,
                        answerValue: answerValue,
                        questionType: RedQuestionSectionEnum.mismatchedDuo.collectionName
                    )
                    mismatchedDuoAnswer = []
                }
                
            }
        }
    }
    
    func controlAnswer() {
        guard currentQuestionIndex < questionList.count else { return }
        
        let question = questionList[currentQuestionIndex]
        
        if let _ = question as? QuestionAnswerModel {
            error = questionAnswerAnswer.isEmpty ? "Lütfen cevap seçiniz." : nil
        } else if let _ = question as? TrueFalseModel {
            error = (trueFalseAnswer == nil) ? "Lütfen cevap seçiniz." : nil
        } else if let _ = question as? MultipleChoiceModel {
            error = (multipleChoiceAnswer == nil) ? "Lütfen cevap seçiniz." : nil
        } else if let _ = question as? MismatchedDuoModel {
            error = (mismatchedDuoAnswer.isEmpty) ? "Lütfen cevap seçiniz." : nil
        } else {
            error = "Bilinmeyen soru tipi."
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
            await increaseCorrectAnswerCount(questionId: id ?? "",questionType: questionType)
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
    
    func passQuestion() {
        if currentQuestionIndex < questionList.count {
            error = nil
            let question = questionList[currentQuestionIndex]
            questionList.append(question)
            self.currentQuestionIndex += 1
        }
    }
    
    
    
    func getExplanationForCurrentQuestion() -> Translations? {
        guard currentQuestionIndex < questionList.count else { return nil }
        let question = questionList[currentQuestionIndex]
        
        switch question {
        case is TrueFalseModel:
            return explains?.trueFalse
        case is QuestionAnswerModel:
            return explains?.questionAnswer
        case is MismatchedDuoModel:
            return explains?.mismatchedDuo
        case is MultipleChoiceModel:
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
        let questions = await service.getQuestions(
            part: "01",
            questionType: RedQuestionSectionEnum.questionAnswer.collectionName,
            responseType: QuestionAnswerModel.self
        )
        
        questionList.append(contentsOf: questions)
    }
    
    func getMultipleChoice() async {
        let questions = await service.getQuestions(
            part: "01",
            questionType: RedQuestionSectionEnum.multipleChoice.collectionName,
            responseType: MultipleChoiceModel.self
        )
        
        questionList.append(contentsOf: questions)
    }
    
    func getTrueFalse() async {
        let questions = await service.getQuestions(
            part: "01",
            questionType: RedQuestionSectionEnum.trueFalse.collectionName,
            responseType: TrueFalseModel.self
        )
        
        questionList.append(contentsOf: questions)
    }
    
    func getMismatchedDuo() async {
        let questions = await service.getQuestions(
            part: "01",
            questionType: RedQuestionSectionEnum.mismatchedDuo.collectionName,
            responseType: MismatchedDuoModel.self
        )
        
        questionList.append(contentsOf: questions)
    }
    
    func increaseCorrectAnswerCount(questionId: String, questionType: String) async {
        await service.increaseAnswerCount(
            questionId: questionId,
            part: "01",
            questionType: questionType,
            field: "correctAnswers"
        )
    }
    
    func increaseInCorrectAnswerCount(questionId: String, questionType: String) async {
        await service.increaseAnswerCount(
            questionId: questionId,
            part: "01",
            questionType: questionType,
            field: "incorrectAnswers"
        )
    }
}
