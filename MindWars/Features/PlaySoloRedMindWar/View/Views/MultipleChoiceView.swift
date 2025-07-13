//
//  MultipleChoiceView.swift
//  MindWars
//
//  Created by Yiğit Tilki on 22.01.2025.
//

import SwiftUI

struct MultipleChoiceView: View {
    let question: MultipleChoiceModel
    let answerPrefixes = ["A", "B", "C", "D", "E", "F"]
    @Binding var answer: Int?
    var body: some View {
        VStack {
            Text(question.translations.tr.question)
                .questionText()

            ForEach(Array(question.translations.tr.answers.enumerated()), id: \.element) { index, answer in
                QuestionSelectButton(
                    prefix: "\(answerPrefixes[index]) -",
                    title: answer,
                    isSelected: self.answer == index,
                    action: { self.answer = index }
                )
            }
        }
    }
}

#Preview {
    MultipleChoiceView(question: mockMultipleChoiceModel, answer: .constant(0))
}

let mockMultipleChoiceModel = MultipleChoiceModel(
    part: "01",
    authorId: "12345",
    createdAt: Date(),
    difficulty: 3,
    correctAnswers: 10,
    incorrectAnswers: 2,
    language: 1,
    type: 2,
    time: 60,
    translations: MultipleChoiceQuestionModel(
        en: MultipleChoiceQuestionDetailModel(
            question: "What is the capital of France?",
            answers: ["Paris", "Berlin", "Madrid", "Rome"],
            answerDescription: "The capital of France is Paris.",
            correctAnswerIndex: 0
        ),
        tr: MultipleChoiceQuestionDetailModel(
            question: "Fransa'nın başkenti neresidir?",
            answers: ["Paris", "Berlin", "Madrid", "Roma"],
            answerDescription: "Fransa'nın başkenti Paris'tir.",
            correctAnswerIndex: 0
        )
    ),
    imageUrl: nil
)
