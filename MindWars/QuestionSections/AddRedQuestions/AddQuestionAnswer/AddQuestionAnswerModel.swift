//
//  QuestionAnswerModel.swift
//  MindWars
//
//  Created by Yiğit Tilki on 9.01.2025.
//

import Foundation

struct AddQuestionAnswerModel: BaseQuestionModel, Encodable {
    let translations: AddQuestionAnswerQuestionModel
    let difficulty: Int
    var correctAnswers: Int = 0
    var incorrectAnswers: Int = 0
    let language: Int
    let type: Int
    let time: Int
    let createdAt: Date
    let authorId: String
    let imageUrl: String?
}
    

struct AddQuestionAnswerQuestionModel: Encodable {
    let en: AddQuestionAnswerQuestionDetailModel
    let tr: AddQuestionAnswerQuestionDetailModel
}
   

struct AddQuestionAnswerQuestionDetailModel: BaseQuestionDetailModel, Encodable {
    let question: String
    let answers: [String]
    let answerDescription: String?
}

