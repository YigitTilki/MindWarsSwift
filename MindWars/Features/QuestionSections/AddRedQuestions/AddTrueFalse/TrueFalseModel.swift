//
//  AddTrueFalseModel.swift
//  MindWars
//
//  Created by Yiğit Tilki on 11.01.2025.
//

import Foundation

struct TrueFalseModel: BaseQuestionModel, Codable {
    var authorId: String
    var createdAt: Date
    var difficulty: Int
    var correctAnswers: Int = 0
    var incorrectAnswers: Int = 0
    var language: Int
    var type: Int
    var time: Int
    let translations: AddTrueFalseQuestionModel
    let imageUrl: String?
}

struct AddTrueFalseQuestionModel: Codable {
    let en: AddTrueFalseQuestionDetailModel
    let tr: AddTrueFalseQuestionDetailModel
}

struct AddTrueFalseQuestionDetailModel: Codable {
    let question: String
    let answer: Bool
    let answerDescription: String?
}
