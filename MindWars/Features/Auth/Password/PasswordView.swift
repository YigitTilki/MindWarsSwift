//
//  PasswordView.swift
//  MindWars
//
//  Created by Yiğit Tilki on 21.12.2024.
//

import SwiftUI

struct PasswordView: View {
    @StateObject private var viewModel = PasswordViewModel()
    @State var authState = AuthState()
    
    var body: some View {
        CommonBackgroundView {
            
            VStack(alignment: .leading) {
                descriptionTitle()
                passwordTextField()
                continueForgetPasswordButton()
                
            }
            .padding()
            .alert(item: $viewModel.alertItem) { alert in
                Alert(title: alert.title, message: alert.message, dismissButton: alert.dismissButton)
            }
            .animation(.easeInOut, value: !authState.error.isEmpty)
            
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
                
            
            if authState.error != "" {
                Text("\(authState.error)").foregroundStyle(.red).font(.caption)
            }
        }
    }
    func continueForgetPasswordButton() -> some View {
        HStack{
            Button("Forget Password?"){
                
            }
            .font(.subheadline)
            Spacer()
            Button(action: {
//                Task {
//                    await viewModel.handleContinueButton(navigationState: navigationState, authState: authState)
//                }
            }, label: {
                Text("Continue")
                    .loginButtonStyle(isEmpty: authState.password.isEmpty)
            })
       
        }
    }
    
}

#Preview {
    PasswordView()
        .environmentObject(AuthState())
}
