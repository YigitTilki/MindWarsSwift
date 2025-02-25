//
//  AddMultipleChoiceModel.swift
//  MindWars
//
//  Created by Yiğit Tilki on 11.01.2025.
//

import Foundation
import FirebaseFirestore

struct MultipleChoiceModel: BaseQuestionModel, Codable {
    @DocumentID var id: String?
    let part: String
    var authorId: String
    var createdAt: Date
    var difficulty: Int
    var correctAnswers: Int = 0
    var incorrectAnswers: Int = 0
    var language: Int
    var type: Int
    var time: Int
    let translations: MultipleChoiceQuestionModel
    let imageUrl: String?
    
}

struct MultipleChoiceQuestionModel: Codable {
    let en: MultipleChoiceQuestionDetailModel
    let tr: MultipleChoiceQuestionDetailModel
}

struct MultipleChoiceQuestionDetailModel: Codable {
    let question: String
    let answers: [String]
    let answerDescription: String?
    let correctAnswerIndex: Int?
}
