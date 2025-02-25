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
                .padding(.bottom, 20)
                .font(.title3)
            HStack(spacing: 20) {
                Button(action: {
                    answer = true
                }) {
                    Text("true")
                        .font(.title3)
                        .fontWeight(.medium)
                        .frame(maxWidth: .infinity, maxHeight: .infinity)
                        .background(answer ?? false ? .green.opacity(0.8) : .gray.opacity(0.8))
                        .foregroundStyle(.white)
                        .cornerRadius(10)
                }
                .frame(maxWidth: 200, maxHeight: 75)
                Button(action: {
                  answer = false
                }) {
                    Text("false")
                        .font(.title3)
                        .fontWeight(.medium)
                        .frame(maxWidth: .infinity, maxHeight: .infinity)
                        .background(!(answer ?? true) ? .red.opacity(0.8) : .gray.opacity(0.8))
                        .foregroundStyle(.white)
                        .cornerRadius(10)
                }
                .frame(maxWidth: 200, maxHeight: 75)
                
            }
        }
    }
}

#Preview {
    TrueFalseView(question: mockAddTrueFalseModel,answer: .constant(false))
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
