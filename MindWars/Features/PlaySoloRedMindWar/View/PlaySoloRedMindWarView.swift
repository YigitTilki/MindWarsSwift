//
//  PlaySoloRedMindWarView.swift
//  MindWars
//
//  Created by Yiğit Tilki on 12.01.2025.
//

import SwiftUI

struct PlaySoloRedMindWarView: View {
    
    @StateObject var vm = PlaySoloRedMindWarViewModel()
    
    var body: some View {
        CommonBackgroundView {
            VStack {
                VStack{
                    Text(vm.getExplanationForCurrentQuestion()?.tr.title ?? "")
                        .padding(.vertical, 5)
                        .font(.title2)
                        .fontWeight(.semibold)
                    Text(vm.getExplanationForCurrentQuestion()?.tr.description ?? "")
                        .padding(.all, 5)
                        .multilineTextAlignment(.center)
                        .fontWeight(.medium)
                        
                }
                .frame(maxWidth: .infinity, minHeight: 150)
                
                .padding()
                .background(
                    LinearGradient(gradient: Gradient(colors: [.red, .red.opacity(0.5)]),
                                   startPoint: .center,
                                   endPoint: .bottom)
                )
                .foregroundColor(.white)
                .border(.red.opacity(0.3), width: 3)
                .cornerRadius(15)
                .padding(.top, 50)
                .padding(.bottom, 30)
                
                
                
                
                if vm.currentQuestionIndex < vm.questionList.count {
                    let question = vm.questionList[vm.currentQuestionIndex]
                    switch question {
                    case let question as TrueFalseModel:
                        TrueFalseView(question: question,answer: $vm.trueFalseAnswer)
                    case let question as QuestionAnswerModel:
                        QuestionAnswerView(question: question,answer: $vm.questionAnswerAnswer)
                    case let question as MismatchedDuoModel:
                        MismatchedDuoView(question: question,answers: $vm.mismatchedDuoAnswer)
                        
                    case let question as MultipleChoiceModel:
                        MultipleChoiceView(question: question, answer: $vm.multipleChoiceAnswer)
                    default:
                        Text("Unknown question type")
                    }
                } else {
                    Text("All questions completed!")
                }
                
                Spacer()
                
                Button(action: {
                    if vm.currentQuestionIndex < vm.questionList.count - 1 {
                        
                        let question = vm.questionList[vm.currentQuestionIndex]
                        switch question {
                        case _ as TrueFalseModel:
                            Task {
                                await vm.submitQuestionAnswer()
                            }
                        case _ as QuestionAnswerModel:
                           Task {
                               await vm.submitQuestionAnswer()
                           }
                        case _ as MismatchedDuoModel:
                            Task {
                                await vm.submitQuestionAnswer()
                                print($vm.mismatchedDuoAnswer)
                            }
                        case _ as MultipleChoiceModel:
                            Task {
                                await vm.submitQuestionAnswer()
                            }
                        default:
                            print("")
                        }
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
                        .padding(.bottom, 50)
                        .padding(.top, 20)
                }
            }
            .padding()
            .onAppear {
                Task {
                    await vm.getExplains()
                    await vm.getQuestions()
                }
            }
            .alert(item: $vm.alertItem) { alert in
                Alert(title: alert.title, message: alert.message, dismissButton: alert.dismissButton)
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
