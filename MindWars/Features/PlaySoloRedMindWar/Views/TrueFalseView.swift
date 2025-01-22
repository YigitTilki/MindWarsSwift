//
//  TrueFalseView.swift
//  MindWars
//
//  Created by Yiğit Tilki on 22.01.2025.
//

import SwiftUI

struct TrueFalseView: View {
    let question: AddTrueFalseModel
    var body: some View {
        VStack {
            Text(question.translations.tr.question)
                .padding(.bottom, 20)
                .font(.title3)
            HStack(spacing: 20) {
                Button(action: {
                  
                }) {
                    Text("true")
                        .font(.title3)
                        .fontWeight(.medium)
                        .frame(maxWidth: .infinity, maxHeight: .infinity)
                        .background(.gray.opacity(0.8))
                        .foregroundStyle(.white)
                        .cornerRadius(10)
                }
                .frame(maxWidth: 200, maxHeight: 75)
                Button(action: {
                  
                }) {
                    Text("false")
                        .font(.title3)
                        .fontWeight(.medium)
                        .frame(maxWidth: .infinity, maxHeight: .infinity)
                        .background(.gray.opacity(0.8))
                        .foregroundStyle(.white)
                        .cornerRadius(10)
                }
                .frame(maxWidth: 200, maxHeight: 75)
                
            }
        }
    }
}

#Preview {
    TrueFalseView(question: mockAddTrueFalseModel)
}

let mockAddTrueFalseModel = AddTrueFalseModel(
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
