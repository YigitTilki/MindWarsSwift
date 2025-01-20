//
//  RedQuestionsView.swift
//  MindWars
//
//  Created by Yiğit Tilki on 9.01.2025.
//

import SwiftUI

struct AddRedQuestionsView: View {
    
    let sectionId: String
    
    var body: some View {
        
            VStack {
                switch sectionId {
                case "1":
                    AddQuestionAnswerView()
                case "2":
                    AddMultipleChoiceView()
                case "3":
                    AddTrueFalseView()
                case "4":
                    AddMismatchedDuoView()
                default:
                    Text("Red Questions")
                }
            }
        }
}

#Preview {
    AddRedQuestionsView(sectionId: "1")
}

