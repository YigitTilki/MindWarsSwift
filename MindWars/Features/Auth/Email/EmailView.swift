//
//  LoginView.swift
//  MindWars
//
//  Created by Yiğit Tilki on 20.12.2024.
//

import SwiftUI

struct EmailView: View {
    @EnvironmentObject var navigationState: Navigation
    @EnvironmentObject var authState: AuthState
    
    @StateObject private var viewModel = EmailViewModel()
    
    var body: some View {
        CommonBackgroundView {
            
            VStack(alignment: .leading) {
                descriptionTitle()
                emailTextField()
                continueButton()
            }
            .padding()
            .toolbar(content: {
                ToolbarItem(placement: .navigationBarLeading) {
                           Button("") {
                           }
                       }
            })
            .animation(.easeInOut, value: !authState.error.isEmpty)
            
            
            if authState.isLoading {
                LoadingView()
            }
        }
    }
    
    func descriptionTitle() -> some View {
        VStack(alignment: .leading){
            Text("LET'S PLAY")
                .font(.title)
                .fontWeight(.medium)
            Text("ENTER MIND WARS WORLD")
                .font(.title3)
        }
    }
    func emailTextField() ->  some View {
        VStack(alignment: .leading){
            TextField("Email", text: $authState.email)
                .appTextField()
                .keyboardType(.emailAddress)
                
            
            if authState.error != "" {
                Text("\(authState.error)").foregroundStyle(.red).font(.caption)
            }
        }
        
    }
    func continueButton() -> some View {
        HStack{
            Spacer()
            Button(action: {
                Task {
                    await viewModel.handleContinueButton(
                        navigationState: navigationState, authState: authState
                    )
                }
            }, label: {
                Text("Continue")
                    .loginButtonStyle(isEmpty: authState.email.isEmpty)
            })
        }
    }
}

#Preview {
    EmailView()
        .environmentObject(AuthState())
}
