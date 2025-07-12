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
            .navigationDestination(isPresented: $vm.navigate) {
                HomeView()
            }

            if vm.isLoading {
                LoadingView()
            }
        }
    }

    // MARK: - Description

    func descriptionTitle() -> some View {
        VStack(alignment: .leading) {
            Text(LocaleKeys.Login.letsPlay.localized)
                .font(.title)
                .fontWeight(.medium)
            Text(LocaleKeys.Login.emww.localized)
                .font(.title3)
        }
    }

    // MARK: - Email Field

    func emailTextField() -> some View {
        VStack(alignment: .leading) {
            TextField(LocaleKeys.email.localized, text: $vm.email)
                .appTextField()
                .keyboardType(.emailAddress)
        }
    }

    // MARK: - PasswordField

    func passwordTextField() -> some View {
        VStack(alignment: .leading) {
            TextField(LocaleKeys.password.localized, text: $vm.password)
                .appTextField()

//            if let error = !vm.isValid {
//                Text(error).foregroundColor(.red)
//            }
        }
    }

    // MARK: - Login Button

    func continueButton() -> some View {
        HStack {
            Spacer()
            AppButton(
                title: LocaleKeys.continueValue.localized,
                backgroundColor: vm.email.isEmpty || vm.password.isEmpty ? .gray : .blue,
                action: {
                    Task {
                        await vm.onTapLogin()
                    }
                }
            )
            .disabled(vm.email.isEmpty || vm.password.isEmpty)
        }
    }

    // MARK: - Go Register Row

    func goRegisterRow() -> some View {
        HStack {
            Text(LocaleKeys.Login.dhacc.localized)

            NavigationLink(LocaleKeys.signUp.localized, destination: {
                RegisterView()
            })
        }
        .frame(maxWidth: .infinity, alignment: .center)
        .padding(.top, 50)
    }
}

// MARK: - Preview

#Preview {
    LoginView()
}
