//
//  MismatchedDuoView.swift
//  MindWars
//
//  Created by Yiğit Tilki on 22.01.2025.
//

import SwiftUI

struct MismatchedDuoView: View {
    let question: MismatchedDuoModel
    let answerPrefixes = ["A", "B", "C", "D", "E", "F", "G"]
    @Binding var answers: [Int]
    var body: some View {
        VStack {
            Text(question.translations.tr.question)
                .questionText()

            ForEach(Array(question.translations.tr.answers.enumerated()), id: \.element) { index, answer in
                QuestionSelectButton(
                    prefix: "\(answerPrefixes[index]) -",
                    title: answer,
                    isSelected: answers.contains(index),
                    action: {
                        handleSelection(for: index)
                    }
                )
            }
        }
    }

    private func handleSelection(for index: Int) {
        if answers.contains(index) {
            answers.removeAll { $0 == index }
        } else if answers.count < 2 {
            answers.append(index)
        } else {
            answers.removeFirst()
            answers.append(index)
        }
    }
}

#Preview {
    MismatchedDuoView(question: mockMismatchedDuoModel, answers: .constant([0, 2]))
}

let mockMismatchedDuoModel = MismatchedDuoModel(
    part: "01",
    authorId: "54321",
    createdAt: Date(),
    difficulty: 4,
    correctAnswers: 8,
    incorrectAnswers: 3,
    language: 1,
    type: 3,
    time: 90,
    translations: MismatchedDuoQuestionModel(
        en: MismatchedDuoQuestionDetailModel(
            question: "Match the items that do not belong together.",
            answers: ["Cat", "Dog", "Car", "Fish", "Bike", "Bird"],
            answerDescription: "Car and Bike are not animals.",
            correctAnswerIndexes: [2, 4]
        ),
        tr: MismatchedDuoQuestionDetailModel(
            question: "Birbirine ait olmayanları eşleştirin.",
            answers: ["Kedi", "Köpek", "Araba", "Balık", "Bisiklet", "Kuş"],
            answerDescription: "Araba ve Bisiklet hayvan değildir.",
            correctAnswerIndexes: [2, 4]
        )
    ),
    imageUrl: nil
)
