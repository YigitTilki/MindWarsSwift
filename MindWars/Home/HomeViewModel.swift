//
//  HomeViewModel.swift
//  MindWars
//
//  Created by Yiğit Tilki on 21.12.2024.
//

import FirebaseFirestore
import Combine

@MainActor
class HomeViewModel: BaseViewModel,ObservableObject {
    
    
    private let homeService = HomeService()
    
    @Published var message: MessageModel?
    @Published var questionSections: [QuestionSectionMainModel] = []
    
    
    
    func setData() {
        let data = AnswerQuestionModel(question: "q3", answers: ["a3", "b2"])
        homeService.createQuestionAnswer(model: data) { result in
            switch result {
            case .success:
                self.message = MessageModel(title: "Success", message: "Question created successfully")
    
            case .failure(let error):
                self.message = MessageModel(title: "Error", message: error.localizedDescription)
                
            }
        }
    }
    
    
    
    
}
