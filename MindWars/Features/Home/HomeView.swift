//
//  HomeView.swift
//  MindWars
//
//  Created by Yiğit Tilki on 21.12.2024.
//

import SwiftUI

struct HomeView: View {

    @StateObject private var vm = HomeViewModel()


    var body: some View {
            NavigationStack {
                CommonBackgroundView {
                   
                }
                .toolbar {
                    settingsIcon()
                    title(title: vm.getUser()?.username)
                }
            }
    }
    
    
    @ToolbarContentBuilder
        private func settingsIcon() -> some ToolbarContent {
            ToolbarItem(placement: .navigationBarTrailing) {
                Button {
                    
                } label: {
                    Image(systemName: "gearshape")
                        .padding(5)
                        .foregroundColor(.clickBlue)
                        .background(.white)
                        .clipShape(.circle)
                        .padding(.top, 10)
                }
            }
        }
    
    @ToolbarContentBuilder
    private func title(title: String?) -> some ToolbarContent {
            
            ToolbarItem(placement: .topBarLeading) {
                Text(title ?? "")
                    .font(AppFont.title)
                    .padding(.top, 10)
            }
        }
    
    
}

#Preview {
    HomeView()
       
}



//struct HomeView: View {
////    @Environment(Language.self) var languageManager
//    @State private var isPresented = false
//
//    @StateObject private var viewModel = HomeViewModel()
//    @State var showAlert = false
//
//    var body: some View {
//        NavigationStack {
//            CommonBackgroundView {
//                
//            }
////            .languageSelectionDialog(isPresented: $isPresented, languageManager: languageManager)
//            
//        }
//    }
//}
//
//#Preview {
//    HomeView()
//       // .environment(Language())
//}
