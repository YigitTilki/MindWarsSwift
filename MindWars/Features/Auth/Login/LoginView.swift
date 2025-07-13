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
                Spacer()
                descriptionTitle()
                emailTextField()
                passwordTextField()
                continueButton()
                goRegisterRow()

            }
            .padding(15)
            .navigationBarBackButtonHidden(true)
            .navigationDestination(isPresented: $vm.navigate) { HomeView() }

            if vm.isLoading {
                LoadingView()
            }
        }
    }

    // MARK: - Description
    func descriptionTitle() -> some View {
        VStack(alignment: .leading) {
            Text(LocaleKeys.Login.letsPlay.localized)
                .font(AppFont.title)
            Text(LocaleKeys.Login.emww.localized)
                .font(AppFont.subtitle)
        }
    }

    // MARK: - Email Field
    func emailTextField() -> some View {
        TextField(LocaleKeys.email.localized, text: $vm.email)
            .modifier(TextFieldViewModifier(keyboardType: .emailAddress))
    }

    // MARK: - PasswordField
    func passwordTextField() -> some View {
        VStack(alignment: .leading) {
            SecureField(LocaleKeys.password.localized, text: $vm.password)
                .modifier(TextFieldViewModifier())

            Text(vm.errorMessage ?? "").modifier(ValidationErrorViewModifier())

        }
    }

    // MARK: - Login Button
    func continueButton() -> some View {
        let isDisabled = vm.email.isEmpty || vm.password.isEmpty

        return HStack {
            Spacer()
            Button(LocaleKeys.continueValue.localized) {
                Task { await vm.onTapLogin() }
            }
            .buttonStyle(AppButtonStyle(isDisabled: isDisabled))
            .disabled(isDisabled)
        }
        .padding(.top, 10)
    }

    // MARK: - Go Register Row
    func goRegisterRow() -> some View {
        HStack {
            Text(LocaleKeys.Login.dhacc.localized)
                .font(AppFont.body1)

            NavigationLink(
                LocaleKeys.signUp.localized,
                destination: { RegisterView() }
            )
            .foregroundStyle(.clickBlue)
            .font(AppFont.body1)
        }
        .frame(maxWidth: .infinity, alignment: .center)
        .padding(.top, 60)
        .padding(.bottom, 100)
    }
}

// MARK: - Preview
#Preview {
    LoginView()
}
