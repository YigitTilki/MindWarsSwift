//
//  HomeService.swift
//  MindWars
//
//  Created by Yiğit Tilki on 7.01.2025.
//

import Foundation
import FirebaseFirestore

class HomeService: BaseViewModel {
    
    func createQuestionAnswer(model: AnswerQuestionModel, completion: @escaping (Result<Void, Error>) -> Void) {
        do {
            try db.collection("questions")
                .document("1")
                .collection("questionAnswer")
                .document("parts")
                .collection("01")
                .addDocument(from: model.self) { error in
                    if let error = error {
                        completion(.failure(error))
                    } else {
                        completion(.success(()))
                    }
                }
        } catch {
            completion(.failure(error))
        }
    }
//    func getSubSections(sectionId: String) async  {
//        do{
//            print("getSubSections called")
//            var subSections: [Subsection] = []
//            
//            let snapshot =  try await db.collection("questionSections").document(sectionId).collection("sections").getDocuments()
//            
//            for document in snapshot.documents {
//                let data = document.data()
//                
//                let section = Subsection(id: document.documentID, name: data["name"] as! String)
//                subSections.append(section)
//                print("👻\(document.documentID) => \(document.data())")
//            }
//        } catch {
//            print("🔥Error getting documents: \(error)")
//        }
//        
//    }
//    
//    func getQuestionSections() async {
//        
//    }
    
   
    

    
}



struct Subsection: Identifiable {
    let id: String
    let name: String
}



