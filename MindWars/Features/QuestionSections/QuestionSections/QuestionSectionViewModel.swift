//
//  QuestionSectionViewModel.swift
//  MindWars
//
//  Created by Yiğit Tilki on 9.01.2025.
//

import Foundation

@MainActor
class QuestionSectionViewModel: AddRedQuestionsBaseViewModel, ObservableObject {
    
    @Published var questionSections: [QuestionSectionModel] = []
    
    func getQuestionSections(sectionId: String) async {
        
      
        await performLoadingTask  { [self] in
                questionSections.removeAll()
                
                let snapshot = try await db.collection("questionSections").document(sectionId).collection("sections").getDocuments()
                
                for document in snapshot.documents {
                    let data = document.data()
                    let section = QuestionSectionModel(id: document.documentID, name: data["name"] as! String)
                    
                    questionSections.append(section)
                    print("👻\(document.documentID) => \(document.data())")
                    
                }
            }
        
    }

}


struct QuestionSectionModel: Identifiable {
    let id: String
    let name: String
}
