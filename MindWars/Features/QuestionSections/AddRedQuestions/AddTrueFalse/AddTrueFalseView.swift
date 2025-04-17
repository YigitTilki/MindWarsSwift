//
//  AddTrueFalseView.swift
//  MindWars
//
//  Created by Yiğit Tilki on 9.01.2025.
//

import SwiftUI

struct AddTrueFalseView: View {
    @StateObject var vm = AddTrueFalseViewModel()

    var body: some View {
        ZStack {
            Form {
                languagePicker()
                typePicker()
                difficultyPicker()
                timePicker()
                imagePicker()
                questionParts()
                if vm.language == .tr || vm.language == .both {
                    questionText1()
                    answer1()
                    answerDescription1()
                }
                if vm.language == .en || vm.language == .both {
                    questionText2()
                    answer2()
                    answerDescription2()
                }
                addButton()
            }
            .alert(item: $vm.alertItem) { alert in
                Alert(title: alert.title, message: alert.message, dismissButton: alert.dismissButton)
            }
            .navigationBarTitleDisplayMode(.large)
            .navigationTitle("add_tf")
            .sheet(isPresented: $vm.isImagePickerPresented) {
                ImagePicker(selectedImage: $vm.selectedImage)
            }

            if vm.isLoading {
                LoadingView()
            }
        }
    }

    func answer1() -> some View {
        Section(header: Text("Cevap")) {
            Toggle(isOn: $vm.answer1) {
                Text(verbatim: vm.answer1 ? "Doğru" : "Yanlış")
                    .foregroundStyle(vm.answer1 ? Color.green : Color.red)
                    .fontWeight(.medium)
            }
        }
    }

    func questionText1() -> some View {
        Section(header: Text("Doğru-Yanlış Sorusu")) {
            TextField("Soru", text: $vm.question1, axis: .vertical)
                .lineLimit(5 ... 10)
        }
    }

    func answer2() -> some View {
        Section(header: Text("Answer")) {
            Toggle(isOn: $vm.answer2) {
                Text(verbatim: vm.answer2 ? "True" : "False")
                    .foregroundStyle(vm.answer2 ? Color.green : Color.red)
                    .fontWeight(.medium)
            }
        }
    }

    func questionText2() -> some View {
        Section(header: Text("True-False Question")) {
            TextField("Question", text: $vm.question2, axis: .vertical)
                .lineLimit(5 ... 10)
        }
    }

    func answerDescription1() -> some View {
        Section(header: Text("Cevap Açıklaması")) {
            TextField("Cevap Açıklaması", text: $vm.answerDescription1)
        }
    }

    func answerDescription2() -> some View {
        Section(header: Text("Answer Description")) {
            TextField("Answer Description", text: $vm.answerDescription2)
        }
    }

    func questionParts() -> some View {
        Section(header: Text("question_parts")) {
            HStack {
                Text("part_length")
                Picker(vm.lengthOfPart, selection: $vm.selectedPart) {
                    ForEach(QuestionPart.allCases, id: \.self) { part in
                        Text(part.localized)
                    }
                }
                .pickerStyle(.menu)
                .onChange(of: vm.selectedPart) {
                    Task {
                        await vm.getPartLength(sectionId: 3)
                    }
                }
            }
        }
    }

    func imagePicker() -> some View {
        HStack {
            if vm.isImageQuestion {
                Button("select_image") {
                    // vm.isPickerPresented = true
                    vm.alertItem = AlertContext.unavailableService
                }
            }

            Toggle(isOn: $vm.isImageQuestion) {
                Text(!vm.isImageQuestion ? "question_with_image" : "")
            }
        }
    }

    func timePicker() -> some View {
        Picker("time", selection: $vm.time) {
            ForEach(QuestionTime.allCases, id: \.self) { part in
                Text(part.rawValue.description)
            }
        }
        .pickerStyle(.menu)
    }

    func languagePicker() -> some View {
        Picker("language", selection: $vm.language) {
            ForEach(Languages.allCases, id: \.self) { part in
                Text(part.localized)
            }
        }
        .pickerStyle(.menu)
    }

    func difficultyPicker() -> some View {
        Picker("difficulty", selection: $vm.difficulty) {
            ForEach(QuestionDifficulty.allCases, id: \.self) { part in
                Text(part.localized)
            }
        }
        .pickerStyle(.menu)
    }

    func typePicker() -> some View {
        Picker("type", selection: $vm.type) {
            ForEach(QuestionType.allCases, id: \.self) { part in
                Text(part.localized)
            }
        }
        .pickerStyle(.menu)
    }

    func addButton() -> some View {
        let isFieldsEmpty = vm.isFieldsEmpty()
        return Button(
            action: {
                Task {
                    await vm.addQuestion()
                }
            },
            label: {
                Text("add_tf_question")
            }
        )
        .disabled(isFieldsEmpty)
    }
}

#Preview {
    AddTrueFalseView()
}
