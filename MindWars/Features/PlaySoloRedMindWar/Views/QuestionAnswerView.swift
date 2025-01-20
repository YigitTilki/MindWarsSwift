//
//  QuestionAnswerView.swift
//  MindWars
//
//  Created by Yiğit Tilki on 20.01.2025.
//

import SwiftUI

struct QuestionAnswerView: View {
    let question: AddQuestionAnswerModel
    var body: some View {
        VStack{
            Text(question.translations.tr.question)
                .padding(.bottom, 20)
                .font(.title3)
            TextField("Cevap", text: .constant(""))
                .appTextFieldStyle()
            HStack() {
                Image(systemName: "info.circle")
                Text("Cevabınızı yazarken Türkçe karakterlere ve oluşabilecek yazım hatalarına dikkat ediniz!")
                    .font(.footnote)
            }
            .foregroundStyle(.gray)
            .padding(.vertical, 5)
        }
       
    }
}

#Preview {
    QuestionAnswerView(question: mockQuestionAnswerData)
}


let mockQuestionAnswerData = AddQuestionAnswerModel(
    translations: AddQuestionAnswerQuestionModel(
        en: AddQuestionAnswerQuestionDetailModel(
            question: "What is the capital of France?",
            answers: ["Berlin", "Madrid", "Paris", "Rome"],
            answerDescription: "Paris is the capital and most populous city of France."
        ),
        tr: AddQuestionAnswerQuestionDetailModel(
            question: "Fransa'nın başkenti nedir?",
            answers: ["Berlin", "Madrid", "Paris", "Roma"],
            answerDescription: "Paris, Fransa'nın başkenti ve en kalabalık şehridir."
        )
    ),
    difficulty: 2,
    correctAnswers: 0,
    incorrectAnswers: 0,
    language: 1,
    type: 0,
    time: 30,
    createdAt: Date(),
    authorId: "123456789",
    imageUrl: nil
)
