//
//  AddMismatchedDuoModel.swift
//  MindWars
//
//  Created by Yiğit Tilki on 12.01.2025.
//

import Foundation

struct AddMismatchedDuoModel: BaseQuestionModel, Encodable {
    var authorId: String
    var createdAt: Date
    var difficulty: Int
    var correctAnswers: Int = 0
    var incorrectAnswers: Int = 0
    var language: Int
    var type: Int
    var time: Int
    let translations: AddMismatchedDuoQuestionModel
    let imageUrl: String?
    
}

struct AddMismatchedDuoQuestionModel: Encodable {
    let en: AddMismatchedDuoQuestionDetailModel
    let tr: AddMismatchedDuoQuestionDetailModel
}

struct AddMismatchedDuoQuestionDetailModel: BaseQuestionDetailModel, Encodable {
    let question: String
    let answers: [String]
    let answerDescription: String?
    let correctAnswerIndexes: [Int]?
}
