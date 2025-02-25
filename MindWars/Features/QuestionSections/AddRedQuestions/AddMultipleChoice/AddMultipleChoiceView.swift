//
//  AddMultipleChoiceView.swift
//  MindWars
//
//  Created by Yiğit Tilki on 9.01.2025.
//

import SwiftUI

struct AddMultipleChoiceView: View {
    
    @StateObject var vm = AddMultipleChoiceViewModel()
    
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
                    answerText1()
                    if !vm.answers1.isEmpty {
                        answersList1()
                        correctAnswer1()
                        answerDescription1()
                    }
                   
                }
                if vm.language == .en || vm.language == .both {
                    questionText2()
                    answerText2()
                    if !vm.answers2.isEmpty {
                        answersList2()
                        correctAnswer2()
                        answerDescription2()
                    }
                    
                }
                addButton()
            }
            .alert(item: $vm.alertItem) { alert in
                Alert(title: alert.title, message: alert.message, dismissButton: alert.dismissButton)
            }
            .navigationBarTitleDisplayMode(.large)
            .navigationTitle("add_mc")
            .sheet(isPresented: $vm.isImagePickerPresented) {
                ImagePicker(selectedImage: $vm.selectedImage)
                   }
            
            if vm.isLoading {
                LoadingView()
            }
        }
    }
    
    func correctAnswer1() -> some View {
        Picker("Doğru Cevap", selection: $vm.correctAnswer1) {
            Text("Cevap Seç")
            ForEach(vm.answers1, id: \.self) { part in
                Text(part)
            }
        }
        .pickerStyle(.menu)
    }
    
    func correctAnswer2() -> some View {
        Picker("Correct Answer", selection: $vm.correctAnswer2) {
            Text("Choose Answer")
            ForEach(vm.answers2, id: \.self) { part in
                Text(part)
            }
        }
        .pickerStyle(.menu)
    }
    
    func questionText1() -> some View {
        Section(header: Text("Çoktan Secmeli Sorusu")) {
            TextField("Soru", text: $vm.question1, axis: .vertical)
                .lineLimit(5...10)
            
            
        }
    }
    
    func answerText1() -> some View {
        Section(header: Text("Çoktan Seçmeli Cevapları")) {
                HStack() {
                    TextField("Answer", text: $vm.answer1)
                    Text("Ekle")
                        .foregroundColor(vm.answer1.isEmpty || vm.answers1.count > 4 ? .gray : .blue)
                        .onTapGesture {
                            if vm.answer1.isEmpty { return }
                            if vm.answers1.count > 4 { return }
                            vm.answers1.append(vm.answer1)
                            vm.answer1 = ""
                        }
                }
        }
    }
    
    func answersList1() -> some View {
        Section(header: Text("Cevaplar")) {
            List {
                ForEach(Array(vm.answers1.enumerated()), id: \.element) {index, answer in
                    HStack {
                        Text("\(vm.indexToLetter(index)) - \(answer)")
                        Spacer()
                        Image(systemName: "xmark")
                            .foregroundColor(Color(uiColor: .systemRed))
                        
                            .onTapGesture {
                                vm.answers1.remove(at: index)
                                vm.correctAnswer1 = ""
                            }
                    }
                }
            }
        }
    }
    

    
    func answerText2() -> some View {
        Section(header: Text("Multiple Choice Answer")) {
            HStack() {
                TextField("Answer", text: $vm.answer2)
                Text("Add")
                    .foregroundColor(vm.answer2.isEmpty || vm.answers2.count > 4 ? .gray : .blue)
                    .onTapGesture {
                        if vm.answer2.isEmpty { return }
                        if vm.answers2.count > 4 { return }
                        vm.answers2.append(vm.answer2)
                        vm.answer2 = ""
                    }
            }
            
        }
    }
    
    func answersList2() -> some View {
        Section(header: Text("Answers")) {
            List {
                ForEach(Array(vm.answers2.enumerated()), id: \.element) {index, answer in
                    HStack {
                        Text("\(vm.indexToLetter(index)) - \(answer)")
                        Spacer()
                        Image(systemName: "xmark")
                            .foregroundColor(Color(uiColor: .systemRed))
                        
                            .onTapGesture {
                                vm.answers2.remove(at: index)
                                vm.correctAnswer2 = ""
                            }
                    }
                }
            }
        }
    }
    
    func questionText2() -> some View {
        Section(header: Text("Multiple Choice Question")) {
            TextField("Question", text: $vm.question2, axis: .vertical)
                .lineLimit(5...10)
            
            
        }
    }
    
    func answerDescription1() -> some View {
        Section(header: Text("Cevap Açıklaması")){
            TextField("Cevap Açıklaması", text: $vm.answerDescription1)
        }
            
    }
    func answerDescription2() -> some View {
        Section(header: Text("Answer Description")){
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
                        await vm.getPartLength(sectionId: 2)
                    }
                }
            }
        }
    }
    
    func imagePicker() -> some View {
        HStack{
            if vm.isImageQuestion {
                Button("select_image") {
                    //vm.isPickerPresented = true
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
                Text( part.localized)
                
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
                Text("add_mc_question")
            }
        )
        .disabled(isFieldsEmpty)
    }
}

#Preview {
    AddMultipleChoiceView()
}
