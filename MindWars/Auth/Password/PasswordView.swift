//
//  PasswordView.swift
//  MindWars
//
//  Created by Yiğit Tilki on 21.12.2024.
//

import SwiftUI

struct PasswordView: View {
    @EnvironmentObject var navigationState: Navigation
    @StateObject private var viewModel = PasswordViewModel()
    @EnvironmentObject var authState: AuthState
    
    var body: some View {
        CommonBackgroundView {
            
            VStack(alignment: .leading) {
                descriptionTitle()
                passwordTextField()
                continueForgetPasswordButton()
                
            }
            .appBarBackButton(text: "Change E-Mail", action: {navigationState.state = "Email"})
            .padding()
            .alert(item: $viewModel.alertItem) { alert in
                Alert(title: alert.title, message: alert.message, dismissButton: alert.dismissButton)
            }
            
            if authState.isLoading {
                LoadingView()
            }
        }
    }
    
    func descriptionTitle() -> some View {
        VStack(alignment: .leading) {
            Text("LAST STEP")
                .font(.title)
                .fontWeight(.medium)
            Text("ENTER PASSWORD AND CONTINUE")
                .font(.title3)
            
        }
    }
    func passwordTextField() -> some View {
        VStack(alignment: .leading){
            SecureField("Password", text: $authState.password)
                .appTextFieldStyle()
            
            if authState.error != "" {
                Text("\(authState.error)").foregroundStyle(.red).font(.caption)
            }
        }
    }
    func continueForgetPasswordButton() -> some View {
        HStack{
            Button("Forget Password?"){
                viewModel.handleForgetPasswordButton(navigationState: navigationState)
            }
            .font(.subheadline)
            Spacer()
            Button(action: {
                Task {
                    await viewModel.handleContinueButton(navigationState: navigationState, authState: authState)
                }
            }, label: {
                Text("Continue")
                    .loginButtonStyle()
            })
       
        }
    }
    
}

#Preview {
    PasswordView()
        .environmentObject(AuthState())
}
