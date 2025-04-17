//
//  TrueFalseView.swift
//  MindWars
//
//  Created by Yiğit Tilki on 22.01.2025.
//

import SwiftUI

struct TrueFalseView: View {
    let question: TrueFalseModel
    @Binding var answer: Bool?
    var body: some View {
        VStack {
            Text(question.translations.tr.question)
                .questionText()

            HStack(spacing: 20) {
                SelectableButton(
                    title: "true",
                    isSelected: answer ?? false,
                    selectedColor: .green.opacity(0.8),
                    action: { answer = true }
                )
                SelectableButton(
                    title: "false",
                    isSelected: !(answer ?? true),
                    selectedColor: .red.opacity(0.8),
                    action: { answer = false }
                )
            }
        }
    }
}

#Preview {
    TrueFalseView(question: mockAddTrueFalseModel, answer: .constant(false))
}

let mockAddTrueFalseModel = TrueFalseModel(
    part: "01",
    authorId: "12345",
    createdAt: Date(),
    difficulty: 2,
    correctAnswers: 15,
    incorrectAnswers: 5,
    language: 1,
    type: 1,
    time: 60,
    translations: AddTrueFalseQuestionModel(
        en: AddTrueFalseQuestionDetailModel(
            question: "Is the Earth round?",
            answer: true,
            answerDescription: "The Earth is approximately a sphere, though it is slightly flattened at the poles."
        ),
        tr: AddTrueFalseQuestionDetailModel(
            question: "Dünya yuvarlak mı?",
            answer: true,
            answerDescription: "Dünya yaklaşık olarak bir küredir, ancak kutuplarda biraz basıktır."
        )
    ),
    imageUrl: nil
)
