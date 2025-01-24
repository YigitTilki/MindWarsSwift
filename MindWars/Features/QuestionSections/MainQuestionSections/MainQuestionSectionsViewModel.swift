//
//  QuestionSectionsViewModel.swift
//  MindWars
//
//  Created by Yiğit Tilki on 9.01.2025.
//

import Foundation

@MainActor
class MainQuestionSectionsViewModel: AddRedQuestionsBaseViewModel,ObservableObject {
    
    @Published var mainQuestionSections: [QuestionSectionMainModel] = []
  
    
    func getMainQuestionSections() async {
        await performLoadingTask { [self] in
            guard mainQuestionSections.isEmpty else { return }
            
            mainQuestionSections.removeAll()
            let snapshot = try await db.collection("questionSections").getDocuments()
            
            for document in snapshot.documents {
                let data = document.data()
                let section = QuestionSectionMainModel(id: document.documentID, name: data["name"] as! String)
                
                mainQuestionSections.append(section)
                print("👻\(document.documentID) => \(document.data())")
            }
        }
    }

}

struct QuestionSectionMainModel: Identifiable {
    let id: String
    let name: String
}


