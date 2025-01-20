//
//  QuestionSectionView.swift
//  MindWars
//
//  Created by Yiğit Tilki on 9.01.2025.
//

import SwiftUI

struct QuestionSectionView: View {
    @StateObject var vm = QuestionSectionViewModel()
    let sectionId: String
    
    var body: some View {
            VStack{
                List {
                    ForEach(vm.questionSections) { section in
                        NavigationLink(section.name, destination: {
                            AddRedQuestionsView(sectionId: section.id)
                        })
                            
                            
                    }
                }
                .navigationBarTitleDisplayMode(.large)
                .navigationTitle("Sections")
            }
        
        .task {
            await vm.getQuestionSections(sectionId: sectionId)
        }
        
    }
}

#Preview {
    QuestionSectionView(sectionId: "1")
}
