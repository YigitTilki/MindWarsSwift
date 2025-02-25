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
    
    let partList = ["01", "02", "03", "04"]
    
    
    //MARK: - Submit Answer
    func submitQuestionAnswer() async {
        controlAnswer()
        
        if isError == false {
            if currentQuestionIndex < questionList.count {
                let question = questionList[currentQuestionIndex]
                
                if let question = question as? QuestionAnswerModel {
                    let answerValue = question.translations.tr.answers.contains(questionAnswerAnswer)
                    await nextQuestion(
                        description: question.translations.tr.answerDescription,
                        id: question.id,
                        answerValue: answerValue,
                        questionType: RedQuestionSectionEnum.questionAnswer.collectionName,
                        questionPart: question.part
                    )
                    questionAnswerAnswer = ""
                }
                
                if let question = question as? TrueFalseModel {
                    let answerValue = question.translations.tr.answer == trueFalseAnswer
            
                    await nextQuestion(
                        description: question.translations.tr.answerDescription,
                        id: question.id,
                        answerValue: answerValue,
                        questionType: RedQuestionSectionEnum.trueFalse.collectionName,
                        questionPart: question.part
                    )
                    trueFalseAnswer = nil
                }
                
                if let question = question as? MultipleChoiceModel {
                    let answerValue = question.translations.tr.correctAnswerIndex == multipleChoiceAnswer
                    
                    await nextQuestion(
                        description: question.translations.tr.answerDescription,
                        id: question.id,
                        answerValue: answerValue,
                        questionType: RedQuestionSectionEnum.multipleChoice.collectionName,
                        questionPart: question.part
                    )
                    multipleChoiceAnswer = nil
                }
                
                if let question = question as? MismatchedDuoModel {
                    let answerValue = question.translations.tr.correctAnswerIndexes == mismatchedDuoAnswer
                    
                    await nextQuestion(
                        description: question.translations.tr.answerDescription,
                        id: question.id,
                        answerValue: answerValue,
                        questionType: RedQuestionSectionEnum.mismatchedDuo.collectionName,
                        questionPart: question.part
                    )
                    mismatchedDuoAnswer = []
                }
                
            }
        }
    }
    
    //MARK: - Validation for Answer
    func controlAnswer() {
        guard currentQuestionIndex < questionList.count else { return }
        
        let question = questionList[currentQuestionIndex]

        switch question {
        case is QuestionAnswerModel:
            isError = questionAnswerAnswer.isEmpty
        case is TrueFalseModel:
            isError = (trueFalseAnswer == nil)
        case is MultipleChoiceModel:
            isError = (multipleChoiceAnswer == nil)
        case is MismatchedDuoModel:
            isError = mismatchedDuoAnswer.isEmpty
        default:
            isError = false
        }
    }


    
    //MARK: - After submit answer alert process
    func nextQuestion(description: String?, id: String?, answerValue: Bool, questionType: String, questionPart: String) async {
        if answerValue {
            score += 1
            alertItem = AlertItem(
                title: Text("Correct!"),
                message: Text(description ?? ""),
                dismissButton: .default(Text("Next")) {
                    self.currentQuestionIndex += 1
                }
            )
            await increaseCorrectAnswerCount(questionId: id ?? "",questionType: questionType, questionPart: questionPart )
        } else {
            alertItem = AlertItem(
                title: Text("Hata!"),
                message: Text(description ?? ""),
                dismissButton: .default(Text("Next")) {
                    self.currentQuestionIndex += 1
                }
            )
            await increaseInCorrectAnswerCount(questionId: id ?? "",questionType: questionType, questionPart: questionPart)
        }
        
    }
    
    //MARK: - Pass question
    func passQuestion() {
        if currentQuestionIndex < questionList.count {
            error = nil
            let question = questionList[currentQuestionIndex]
            questionList.append(question)
            self.currentQuestionIndex += 1
        }
    }
    
    
    //MARK: - Top screen Explanations 
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
            
            questionList = Array(questionList.shuffled().prefix(3))
        }
    }
    
    func getExplains() async {
        let explainsData = await RedMindWarService().getExplains()
        explains = explainsData
    }
    
    func getQuestionAnswer() async {
        let part = partList.randomElement() ?? "01"
        let questions = await service.getQuestions(
            part: part,
            questionType: RedQuestionSectionEnum.questionAnswer.collectionName,
            responseType: QuestionAnswerModel.self
        )
        
        questionList.append(contentsOf: questions)
    }
    
    func getMultipleChoice() async {
        let part = partList.randomElement() ?? "01"
        let questions = await service.getQuestions(
            part: part,
            questionType: RedQuestionSectionEnum.multipleChoice.collectionName,
            responseType: MultipleChoiceModel.self
        )
        
        questionList.append(contentsOf: questions)
    }
    
    func getTrueFalse() async {
        let part = partList.randomElement() ?? "01"
        let questions = await service.getQuestions(
            part: part,
            questionType: RedQuestionSectionEnum.trueFalse.collectionName,
            responseType: TrueFalseModel.self
        )
        
        questionList.append(contentsOf: questions)
    }
    
    func getMismatchedDuo() async {
        let part = partList.randomElement() ?? "01"
        let questions = await service.getQuestions(
            part: part,
            questionType: RedQuestionSectionEnum.mismatchedDuo.collectionName,
            responseType: MismatchedDuoModel.self
        )
        
        questionList.append(contentsOf: questions)
    }
    
    func increaseCorrectAnswerCount(questionId: String, questionType: String, questionPart: String) async {
        await service.increaseAnswerCount(
            questionId: questionId,
            part: questionPart,
            questionType: questionType,
            field: "correctAnswers"
        )
    }
    
    func increaseInCorrectAnswerCount(questionId: String, questionType: String, questionPart: String) async {
        await service.increaseAnswerCount(
            questionId: questionId,
            part: questionPart,
            questionType: questionType,
            field: "incorrectAnswers"
        )
    }
}
