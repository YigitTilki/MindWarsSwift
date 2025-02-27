//
//  RegisterView.swift
//  MindWars
//
//  Created by Yiğit Tilki on 21.12.2024.
//

import SwiftUI

struct RegisterView: View {
    @EnvironmentObject var navigationState: Navigation
    @EnvironmentObject var authState: AuthState
    
    @StateObject private var viewModel = RegisterViewModel()
    
    var body: some View {
        CommonBackgroundView {
            VStack(alignment: .leading){
                
                descriptionTitle()
                textFields()
                signUpButton()
            
            }
            .padding()
            .animation(.easeInOut, value: !authState.error.isEmpty)
            .appBarBackButton(text: "Do you already have an account?", action: {navigationState.state = "Email"})
            
            if authState.isLoading {
                LoadingView()
            }
        }
    }
    
    func textFields() -> some View {
        VStack {
            TextField("UserName", text: $viewModel.userName)
                .appTextField()
            TextField("Email", text: $authState.email)
                .appTextField()
            TextField("Birth Date", text: $viewModel.birthDate)
                .appTextField()
            TextField("Password", text: $viewModel.password)
                .appTextField()
            TextField("Re-Password", text: $viewModel.rePassword)
                .appTextField()
                .disabled(viewModel.password.isEmpty)
            
            if authState.error != "" {
                Text("\(authState.error)").foregroundStyle(.red).font(.caption)
            }
        }
    }
    
    func signUpButton() -> some View {
        HStack{
            Spacer()
            Button("Sign Up"){
                Task{
                    await  viewModel.handleSignUpButton(navigationState: navigationState,authState: authState)                        }
                
            }
            .loginButtonStyle(isEmpty: viewModel.isFieldsEmpty(email: authState.email))
            
        }
        .disabled(viewModel.isFieldsEmpty(email: authState.email))
    }
    
    func descriptionTitle() -> some View {
        VStack(alignment: .leading){
            Text("LET'S SIGN UP")
                .font(.title)
            Text("ENTER YOUR CREDENTIALS TO SIGN UP")
                .font(.callout)
        }
    }
}

#Preview {
    RegisterView()
        .environmentObject(AuthState())
}
