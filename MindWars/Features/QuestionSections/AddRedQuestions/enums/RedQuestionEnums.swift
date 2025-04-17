//
//  RedQuestionEnums.swift
//  MindWars
//
//  Created by Yiğit Tilki on 9.01.2025.
//

import Foundation

enum QuestionPart: String, CaseIterable {
    case none
    case part01 = "01"
    case part02 = "02"
    case part03 = "03"
    case part04 = "04"

    var localized: String {
        return NSLocalizedString(rawValue, comment: "")
    }
}

enum Languages: String, CaseIterable {
    case tr = "turkish"
    case en = "english"
    case both

    var intValue: Int {
        switch self {
        case .both: return 0
        case .tr: return 1
        case .en: return 2
        }
    }

    var localized: String {
        return NSLocalizedString(rawValue, comment: "")
    }
}

enum QuestionDifficulty: String, CaseIterable {
    case veryEasy = "very_easy"
    case easy
    case medium
    case hard
    case veryHard = "very_hard"
    case proffesor = "professor"

    var intValue: Int {
        switch self {
        case .veryEasy: return 0
        case .easy: return 1
        case .medium: return 2
        case .hard: return 3
        case .veryHard: return 4
        case .proffesor: return 5
        }
    }

    var localized: String {
        return NSLocalizedString(rawValue, comment: "")
    }
}

enum QuestionType: String, CaseIterable {
    case general
    case math
    case science

    var intValue: Int {
        switch self {
        case .general: return 0
        case .math: return 1
        case .science: return 2
        }
    }

    var localized: String {
        return NSLocalizedString(rawValue, comment: "")
    }
}

enum RedQuestionSectionEnum: Int {
    case questionAnswer = 1
    case multipleChoice = 2
    case trueFalse = 3
    case mismatchedDuo = 4

    var collectionName: String {
        switch self {
        case .questionAnswer:
            return "questionAnswer"
        case .multipleChoice:
            return "multipleChoice"
        case .trueFalse:
            return "trueFalse"
        case .mismatchedDuo:
            return "mismatchedDuo"
        }
    }
}

enum QuestionTime: Int, CaseIterable {
    case tenSec = 10
    case fifteenSec = 15
    case twentySec = 20
    case thirtySec = 30
    case fourtyFiveSec = 45
    case oneMin = 60
}
