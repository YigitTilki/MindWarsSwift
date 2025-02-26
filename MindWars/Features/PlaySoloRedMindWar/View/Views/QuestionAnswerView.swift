//
//  QuestionAnswerView.swift
//  MindWars
//
//  Created by Yiğit Tilki on 20.01.2025.
//

import SwiftUI

struct QuestionAnswerView: View {
    let question: QuestionAnswerModel
    @Binding var answer: String
    
    var body: some View {
        VStack{
            Text(question.translations.tr.question)
                .questionText()
            
            TextField("answer", text: $answer)
                .appTextField()
                
            InfoText(title: "pay_attention")
        }
    }
}

#Preview {
    QuestionAnswerView(question: mockQuestionAnswerData, answer: .constant(""))
}


let mockQuestionAnswerData = QuestionAnswerModel(
    part: "01",
    translations: QuestionAnswerQuestionModel(
        en: QuestionAnswerQuestionDetailModel(
            question: "What is the capital of France?",
            answers: ["Berlin", "Madrid", "Paris", "Rome"],
            answerDescription: "Paris is the capital and most populous city of France."
        ),
        tr: QuestionAnswerQuestionDetailModel(
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
