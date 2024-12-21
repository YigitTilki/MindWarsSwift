//
//  LoginView.swift
//  MindWars
//
//  Created by Yiğit Tilki on 20.12.2024.
//

import SwiftUI

struct EmailView: View {
    @EnvironmentObject var navigationState: NavigationState
    @StateObject private var viewModel = EmailViewModel()
    
    var body: some View {
        CommonBackgroundView {
            VStack(alignment: .leading) {
                Text("LET'S PLAY")
                    .font(.title)
                Text("ENTER MIND WARS WORLD")
                    .font(.title3)
                TextField("Username/E-Mail", text: $viewModel.username)
                    .appTextFieldStyle()
                
                HStack{
                    Spacer()
                        Button("Continue"){
                            viewModel.handleContinueButton(navigationState: navigationState)
                        }
                        .loginButtonStyle()
                    }
                    
            
            }
            .frame(maxWidth: .infinity, maxHeight: .infinity)
            .padding()
            
        }
        .toolbar(content: {
            ToolbarItem(placement: .navigationBarLeading ,content: {
                Button(""){
                    
                }
            })
        })
        
    }
}

#Preview {
    EmailView()
}
