//
//  LoginView.swift
//  MindWars
//
//  Created by Yiğit Tilki on 20.12.2024.
//

import SwiftUI

struct LoginView: View {
    
    @StateObject private var vm = LoginViewModel()
    
    var body: some View {
        CommonBackgroundView {
            VStack(alignment: .leading) {
                descriptionTitle()
                emailTextField()
                passwordTextField()
                continueButton()
                goRegisterRow()
                
            }
            .padding()
            .navigationBarBackButtonHidden(true)
            .navigationDestination(isPresented: $vm.navigate){
                HomeView()
            }
            
            
            
            
            if vm.isLoading {
                LoadingView()
            }
        }
    }
    //MARK: - Description
    func descriptionTitle() -> some View {
        VStack(alignment: .leading){
            Text("LET'S PLAY")
                .font(.title)
                .fontWeight(.medium)
            Text("ENTER MIND WARS WORLD")
                .font(.title3)
        }
    }
    //MARK: - Email Field
    func emailTextField() ->  some View {
        VStack(alignment: .leading){
            TextField("email", text: $vm.email)
                .appTextField()
                .keyboardType(.emailAddress)
            
        }
        
    }
    //MARK: - PasswordField
    func passwordTextField() ->  some View {
        VStack(alignment: .leading){
            TextField("password", text: $vm.password)
                .appTextField()
            
            if vm.isError {
                Text("invalid_email_or_password").foregroundStyle(.red).font(.caption)
            }
        }
        
    }
    //MARK: - Login Button
    func continueButton() -> some View {
        HStack{
            Spacer()
            Button(action: {
                Task {
                    await vm.handleContinueButton()
                }
            }, label: {
                Text("continue")
                    .loginButtonStyle(isEmpty: vm.email.isEmpty || vm.password.isEmpty)
                
            }).disabled(vm.email.isEmpty || vm.password.isEmpty)
        }
    }
    //MARK: - Go Register Row
    func goRegisterRow() -> some View {
        HStack{
            
            Text("dont_have_an_account")
            
            NavigationLink("sign_up", destination: {
                RegisterView(email: $vm.email)
            })
            
            
            
        }
        .frame(maxWidth: .infinity, alignment: .center)
        .padding(.top, 50)
        
        
    }
}
//MARK: - Preview
#Preview {
    LoginView()
    
}
