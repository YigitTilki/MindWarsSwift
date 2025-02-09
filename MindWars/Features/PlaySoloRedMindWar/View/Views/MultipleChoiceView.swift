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
                .padding(.bottom, 20)
                .font(.title3)
            ForEach(Array(question.translations.tr.answers.enumerated()), id: \.element) { index, answer in
                Button(action: {
                    self.answer = index
                }) {
                    HStack(spacing: 0) {
                        Text("\(answerPrefixes[index]) -")
                            .font(.callout)
                            .fontWeight(.bold)
                            .padding(.trailing, 5)
                        Text(answer)
                            .font(.callout)
                            .fontWeight(.medium)
                    }
                    .frame(maxWidth: .infinity, minHeight: 50, alignment: .leading)
                    .padding(.horizontal, 15)
                    .background(self.answer == index ? .blue.opacity(0.8) : .gray.opacity(0.8))
                    .foregroundStyle(.white)
                    .cornerRadius(10)
                }
                .frame(maxWidth: .infinity, maxHeight: 55)
            }
           
        }
    }
}

#Preview {
    MultipleChoiceView(question: mockMultipleChoiceModel,answer: .constant(0))
}

let mockMultipleChoiceModel = MultipleChoiceModel(
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
