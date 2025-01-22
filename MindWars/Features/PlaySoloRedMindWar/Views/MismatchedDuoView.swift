//
//  MismatchedDuoView.swift
//  MindWars
//
//  Created by Yiğit Tilki on 22.01.2025.
//

import SwiftUI

struct MismatchedDuoView: View {
    let question: AddMismatchedDuoModel
    let answerPrefixes = ["A", "B", "C", "D", "E", "F", "G"]
    var body: some View {
        VStack {
            Text(question.translations.tr.question)
                .padding(.bottom, 20)
                .font(.title3)
            ForEach(Array(question.translations.tr.answers.enumerated()), id: \.element) { index, answer in
                Button(action: {
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
                    .background(.gray.opacity(0.8))
                    .foregroundStyle(.white)
                    .cornerRadius(10)
                }
                .frame(maxWidth: .infinity, maxHeight: 55)
            }
           
        }
    }
}

#Preview {
    MismatchedDuoView(question: mockMismatchedDuoModel)
}

let mockMismatchedDuoModel = AddMismatchedDuoModel(
    authorId: "54321",
    createdAt: Date(),
    difficulty: 4,
    correctAnswers: 8,
    incorrectAnswers: 3,
    language: 1,
    type: 3,
    time: 90,
    translations: AddMismatchedDuoQuestionModel(
        en: AddMismatchedDuoQuestionDetailModel(
            question: "Match the items that do not belong together.",
            answers: ["Cat", "Dog", "Car", "Fish", "Bike", "Bird"],
            answerDescription: "Car and Bike are not animals.",
            correctAnswerIndexes: [2, 4]
        ),
        tr: AddMismatchedDuoQuestionDetailModel(
            question: "Birbirine ait olmayanları eşleştirin.",
            answers: ["Kedi", "Köpek", "Araba", "Balık", "Bisiklet", "Kuş"],
            answerDescription: "Araba ve Bisiklet hayvan değildir.",
            correctAnswerIndexes: [2, 4]
        )
    ),
    imageUrl: nil
)
