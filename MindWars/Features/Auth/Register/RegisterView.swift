//
//  RegisterView.swift
//  MindWars
//
//  Created by Yiğit Tilki on 21.12.2024.
//

import SwiftUI

struct RegisterView: View {

    
    @StateObject private var vm = RegisterViewModel()
    @Binding var email: String
    
    var body: some View {
        CommonBackgroundView {
            VStack(alignment: .leading){
                
                descriptionTitle()
                textFields()
                signUpButton()
            
            }
            .padding()
            

            
            if vm.isLoading  {
                LoadingView()
            }
        }
    }
    
    func textFields() -> some View {
        VStack {
            TextField("UserName", text: $vm.userName)
                .appTextField()
            TextField("Email", text: $email)
                .appTextField()
            TextField("Birth Date", text: $vm.birthDate)
                .appTextField()
            TextField("Password", text: $vm.password)
                .appTextField()
            TextField("Re-Password", text: $vm.rePassword)
                .appTextField()
                .disabled(vm.password.isEmpty)
            
          
        }
    }
    
    func signUpButton() -> some View {
        HStack{
            Spacer()
            Button("Sign Up"){
                Task{
                    await vm.signUp(email: email)                       }
                
            }
            .loginButtonStyle(isEmpty: vm.isFieldsEmpty(email: email))
            
        }
        //.disabled(vm.isFieldsEmpty(email: email))
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
    RegisterView(email: .constant("yigittilkiw@gmail.com"))
        .environmentObject(AuthState())
}
