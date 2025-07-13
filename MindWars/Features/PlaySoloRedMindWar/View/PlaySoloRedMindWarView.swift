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
        WidthButton(
            title: "pass",
            backgroundColor: .purple,
            action: {
                withAnimation {
                    vm.passQuestion()
                }
            }
        )
        .padding(.bottom, 50)
        .padding(.top, 20)
    }

    func nextQuestionButton() -> some View {
        WidthButton(
            title: "next_question",
            action: {
                Task {
                    await vm.submitQuestionAnswer()
                }
            }
        )
        .padding(.bottom, 50)
        .padding(.top, 20)
    }

    func explainContainer() -> some View {
        let title = vm.locale == "en_TR" ? vm.getExplanationForCurrentQuestion()?.en.title : vm.getExplanationForCurrentQuestion()?.tr.title
        let description = vm.locale == "en_TR" ? vm.getExplanationForCurrentQuestion()?.en.description : vm.getExplanationForCurrentQuestion()?.tr.description

        return ExplainContainer(title: title, description: description, backgroundColor: .red)
    }
}

#Preview {
    PlaySoloRedMindWarView()
}
