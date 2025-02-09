//
//  AddMismatchedDuoModel.swift
//  MindWars
//
//  Created by Yiğit Tilki on 12.01.2025.
//

import Foundation
import FirebaseFirestore

struct MismatchedDuoModel: BaseQuestionModel, Codable {
    @DocumentID var id: String?
    var authorId: String
    var createdAt: Date
    var difficulty: Int
    var correctAnswers: Int = 0
    var incorrectAnswers: Int = 0
    var language: Int
    var type: Int
    var time: Int
    let translations: MismatchedDuoQuestionModel
    let imageUrl: String?
    
}

struct MismatchedDuoQuestionModel: Codable {
    let en: MismatchedDuoQuestionDetailModel
    let tr: MismatchedDuoQuestionDetailModel
}

struct MismatchedDuoQuestionDetailModel: Codable {
    let question: String
    let answers: [String]
    let answerDescription: String?
    let correctAnswerIndexes: [Int]?
}
