//
//  PlaySoloRedMindWarView.swift
//  MindWars
//
//  Created by Yiğit Tilki on 12.01.2025.
//

import SwiftUI

struct PlaySoloRedMindWarView: View {
    
    @StateObject var vm = PlaySoloRedMindWarViewModel()
    @State private var currentQuestionIndex: Int = 0
    
    var body: some View {
        CommonBackgroundView {
            VStack {
                Text("Red Mind War")
                    .frame(maxWidth: .infinity, minHeight: 200)
                    .padding()
                    .background(.linearGradient(Gradient(colors: [.red,.red.opacity(0.1)]), startPoint: .center, endPoint: .bottom))
                    .foregroundColor(.white)
                    .cornerRadius(30)
                    .padding(.vertical, 60)
                    
                    
                if currentQuestionIndex < vm.questionList.count {
                    let question = vm.questionList[currentQuestionIndex]
                    switch question {
                    case let question as AddTrueFalseModel:
                        Text(question.translations.en.question)
                    case let question as AddQuestionAnswerModel:
                        QuestionAnswerView(question: question)
                    case let question as AddMismatchedDuoModel:
                        Text(question.translations.tr.question)
                    case let question as AddMultipleChoiceModel:
                        Text(question.translations.tr.question)
                    default:
                        Text("Unknown question type")
                    }
                } else {
                    Text("All questions completed!")
                }
                Spacer()
                
                Button(action: {
                    if currentQuestionIndex < vm.questionList.count - 1 {
                        currentQuestionIndex += 1
                    } else {
                        print("Sorular tamamlandı!")
                    }
                }) {
                    Text("Next Question")
                        .frame(maxWidth: .infinity)
                        .padding()
                        .background(Color.blue)
                        .foregroundColor(.white)
                        .cornerRadius(8)
                        .padding(.bottom, 60)
                        
                    
                }
            }
            .padding()
            .onAppear {
                Task {
                    await vm.getQuestionAnswer()
                }
            }
            
            
            if vm.isLoading {
                LoadingView()
            }
        }
    }
}

#Preview {
    PlaySoloRedMindWarView()
}
