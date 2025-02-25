//
//  PlaySoloRedMindWarModel.swift
//  MindWars
//
//  Created by Yiğit Tilki on 12.01.2025.
//

import Foundation

struct SectionExplain: Codable {
    let title: String
    let description: String
}

struct Translations: Codable {
    let en: SectionExplain
    let tr: SectionExplain
}

struct RedQuestionSectionExplainModel: Codable {
    let questionAnswer: Translations
    let trueFalse: Translations
    let multipleChoice: Translations
    let mismatchedDuo: Translations
    
    init(questionAnswer: Translations, trueFalse: Translations, multipleChoice: Translations, mismatchedDuo: Translations) {
        self.questionAnswer = questionAnswer
        self.trueFalse = trueFalse
        self.multipleChoice = multipleChoice
        self.mismatchedDuo = mismatchedDuo
    }
}
