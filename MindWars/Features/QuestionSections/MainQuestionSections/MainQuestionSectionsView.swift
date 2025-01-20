//
//  AccountView.swift
//  MindWars
//
//  Created by Yiğit Tilki on 7.01.2025.
//



import SwiftUI

struct MainQuestionSectionsView: View {
    @StateObject private var vm = MainQuestionSectionsViewModel()
    
    var body: some View {
        
        NavigationView {
            
            
            ZStack {
                
                List {
                    ForEach(vm.mainQuestionSections) { section in
                        NavigationLink(section.name, destination: QuestionSectionView(sectionId: section.id))
                    }
                }
                .navigationTitle("Sections")
                
                if vm.isLoading {
                    LoadingView()
                }
            }
            
            
            
        }
  
        
        
        .task {
            await vm.getMainQuestionSections()
        }
        
        
        
        
    }
}

#Preview {
    MainQuestionSectionsView()
}
