//
//  QuestionAnswerModel.swift
//  MindWars
//
//  Created by Yiğit Tilki on 9.01.2025.
//

import Foundation


struct QuestionAnswerModel: BaseQuestionModel, Codable {
    let translations: QuestionAnswerQuestionModel
    let difficulty: Int
    var correctAnswers: Int = 0
    var incorrectAnswers: Int = 0
    let language: Int
    let type: Int
    let time: Int
}
    

struct QuestionAnswerQuestionModel: Codable{
    let en: QuestionAnswerQuestionDetailModel
    let tr: QuestionAnswerQuestionDetailModel
}
   

struct QuestionAnswerQuestionDetailModel: BaseQuestionDetailModel, Codable {
    let question: String
    let answers: [String]
}

