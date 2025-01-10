//
//  BaseQuestionModel.swift
//  MindWars
//
//  Created by Yiğit Tilki on 10.01.2025.
//

import Foundation

protocol BaseQuestionModel {
    var difficulty: Int { get }
    var correctAnswers: Int { get }
    var incorrectAnswers: Int { get }
    var language: Int { get }
    var type: Int { get }
    var time: Int { get }
}
