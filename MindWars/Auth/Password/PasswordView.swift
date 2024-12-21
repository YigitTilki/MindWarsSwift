//
//  PasswordView.swift
//  MindWars
//
//  Created by Yiğit Tilki on 21.12.2024.
//

import SwiftUI

struct PasswordView: View {
    @EnvironmentObject var navigationState: NavigationState
    @StateObject private var viewModel = PasswordViewModel()
    
    var body: some View {
        CommonBackgroundView {
            VStack(alignment: .leading) {
                Text("LAST STEP")
                    .font(.title)
                Text("ENTER PASSWORD AND CONTINUE")
                    .font(.title3)
                TextField("Password", text: $viewModel.password)
                    .appTextFieldStyle()
                HStack{
                    Button("Forget Password?"){
                        viewModel.handleForgetPasswordButton(navigationState: navigationState)
                    }
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
        .appBarBackButton(text: "Change E-Mail", action: {navigationState.state = "Email"})
    }
}

#Preview {
    PasswordView()
}
