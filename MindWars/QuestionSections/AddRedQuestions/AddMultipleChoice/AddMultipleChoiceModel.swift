//
//  AddMultipleChoiceModel.swift
//  MindWars
//
//  Created by Yiğit Tilki on 11.01.2025.
//

import Foundation

struct AddMultipleChoiceModel: BaseQuestionModel, Encodable {
    var authorId: String
    var createdAt: Date
    var difficulty: Int
    var correctAnswers: Int = 0
    var incorrectAnswers: Int = 0
    var language: Int
    var type: Int
    var time: Int
    let translations: AddMultipleChoiceQuestionModel
    let imageUrl: String?
    
}

struct AddMultipleChoiceQuestionModel: Encodable {
    let en: AddMultipleChoiceQuestionDetailModel
    let tr: AddMultipleChoiceQuestionDetailModel
}

struct AddMultipleChoiceQuestionDetailModel: BaseQuestionDetailModel, Encodable {
    let question: String
    let answers: [String]
    let answerDescription: String?
    let correctAnswerIndex: Int?
}
