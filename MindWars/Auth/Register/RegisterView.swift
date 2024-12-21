//
//  RegisterView.swift
//  MindWars
//
//  Created by Yiğit Tilki on 21.12.2024.
//

import SwiftUI

struct RegisterView: View {
    @EnvironmentObject var navigationState: NavigationState
    @StateObject private var viewModel = RegisterViewModel()
    var body: some View {
        CommonBackgroundView {
            VStack(alignment: .leading){
                Text("LET'S SIGN UP")
                    .font(.title)
                Text("ENTER YOUR CREDENTIALS TO SIGN UP")
                    .font(.callout)
                TextField("UserName", text: $viewModel.userName)
                    .appTextFieldStyle()
                TextField("Email", text: $viewModel.email)
                    .appTextFieldStyle()
                TextField("Birth Date", text: $viewModel.birthDate)
                    .appTextFieldStyle()
                TextField("Password", text: $viewModel.password)
                    .appTextFieldStyle()
                TextField("Re-Password", text: $viewModel.rePassword)
                    .appTextFieldStyle()
                HStack{
                    Spacer()
                    Button("Sign Up"){
                        viewModel.handleSignUpButton(navigationState: navigationState)                        }
                    .loginButtonStyle()
                }
                
            }
            .frame(maxWidth: .infinity, maxHeight: .infinity)
            .padding()
        }
        .appBarBackButton(text: "Do you already have an account?", action: {navigationState.state = "Email"})
    }
}

#Preview {
    RegisterView()
}
