//
//  AnswerQuestionModel.swift
//  MindWars
//
//  Created by Yiğit Tilki on 7.01.2025.
//

import FirebaseFirestore
import Foundation

struct AnswerQuestionModel: Identifiable, Codable {
    @DocumentID var id: String?
    var question: String?
    var answers: [String]?
}
