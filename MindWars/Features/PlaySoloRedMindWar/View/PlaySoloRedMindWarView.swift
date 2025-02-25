import SwiftUI

struct PlaySoloRedMindWarView: View {
    
    @StateObject var vm = PlaySoloRedMindWarViewModel()
    
    var body: some View {
        CommonBackgroundView {
            VStack {
                explainContainer()
                questionView()
                Spacer()
                errorText()
                buttonRow()
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
    
    func buttonRow() -> some View {
        HStack {
            passButton()
                .frame(maxWidth: UIScreen.main.bounds.width * 0.3)
            nextQuestionButton()
                .frame(maxWidth: UIScreen.main.bounds.width * 0.7)
        }
    }
    
    func errorText() -> some View {
        
        Text(vm.isError ? "please_enter_answer" : "")
            .frame(maxWidth: .infinity, alignment: .trailing)
            .foregroundStyle(.red)
    }
    
    @ViewBuilder
    func questionView() -> some View {
        if vm.currentQuestionIndex < vm.questionList.count {
            let question = vm.questionList[vm.currentQuestionIndex]
            
            switch question {
            case let question as TrueFalseModel:
                TrueFalseView(question: question, answer: $vm.trueFalseAnswer)
            case let question as QuestionAnswerModel:
                QuestionAnswerView(question: question, answer: $vm.questionAnswerAnswer)
            case let question as MismatchedDuoModel:
                MismatchedDuoView(question: question, answers: $vm.mismatchedDuoAnswer)
            case let question as MultipleChoiceModel:
                MultipleChoiceView(question: question, answer: $vm.multipleChoiceAnswer)
            default:
                Text("unknown_question_type")
            }
            
        } else {
            Text("all_questions_completed")
        }
    }

    
    func passButton() -> some View {
        Button(action: {
            withAnimation {
                vm.passQuestion()
            }
        }) {
            Text("pass")
                .frame(maxWidth: .infinity)
                .padding()
                .background(.indigo)
                .foregroundColor(.white)
                .cornerRadius(8)
                .padding(.bottom, 50)
                .padding(.top, 20)
        }
    }
    
    func nextQuestionButton() -> some View {
        Button(action: {
            Task {
                await vm.submitQuestionAnswer()
            }
            
        }) {
            Text("next_question")
                .frame(maxWidth: .infinity)
                .padding()
                .background(Color.blue)
                .foregroundColor(.white)
                .cornerRadius(8)
                .padding(.bottom, 50)
                .padding(.top, 20)
        }
    }
    
    func explainContainer() -> some View {
        VStack {
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
    }
}


#Preview {
    PlaySoloRedMindWarView()
}
