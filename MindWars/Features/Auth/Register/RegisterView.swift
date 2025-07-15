//
//  RegisterView.swift
//  MindWars
//
//  Created by Yiğit Tilki on 21.12.2024.
//

import SwiftUI

struct RegisterView: View {
    @StateObject private var vm = RegisterViewModel()

    var body: some View {
        ZStack {
            AppBackground()
            VStack(alignment: .leading) {
                Spacer()
                descriptionTitle()
                fields()
                signUpButton()
                goLoginRow()
            }
            .padding()
            .navigationBarBackButtonHidden(true)
            .navigationDestination(isPresented: $vm.navigateToHome) {
                HomeView()
            }
            .toastView(toast: $vm.toast)

            if vm.isLoading {
                LoadingView()
            }
        }
    }

    // MARK: - All Fields

    private func fields() -> some View {
        VStack {
            userNameField()
            emailField()
            passwordField()
            rePasswordField()
            datePickerField()
        }
    }

    // MARK: - Go Login Row

    private func goLoginRow() -> some View {
        HStack {
            Text(LocaleKeys.Register.ahaacc.localized)
                .font(AppFont.body1)
            NavigationLink(
                LocaleKeys.signIn.localized,
                destination: {
                    LoginView()
                }
            )
            .foregroundStyle(.clickBlue)
            .font(AppFont.body1)
        }
        .frame(maxWidth: .infinity, alignment: .center)
        .padding(.top, 60)
        .padding(.bottom, 100)
    }

    // MARK: - User Name Field
    private func userNameField() -> some View {
        VStack(alignment: .leading) {
            TextField(LocaleKeys.userName.localized, text: $vm.state.userName)
                .modifier(TextFieldViewModifier(textContentType: .username))
            if let error = vm.state.userNameError {
                Text(error).modifier(ValidationErrorViewModifier())
            }
        }
    }

    // MARK: - Email Field
    private func emailField() -> some View {
        VStack(alignment: .leading) {
            TextField(LocaleKeys.email.localized, text: $vm.state.email)
                .modifier(TextFieldViewModifier(textContentType: .emailAddress))
            if let error = vm.state.emailError {
                Text(error).modifier(ValidationErrorViewModifier())
            }
        }
    }

    // MARK: - Password Field
    private func passwordField() -> some View {
        VStack(alignment: .leading) {
            SecureField(LocaleKeys.password.localized, text: $vm.state.password)
                .modifier(TextFieldViewModifier(textContentType: .newPassword))
            if let error = vm.state.passwordError {
                Text(error).modifier(ValidationErrorViewModifier())
            }
        }
    }

    // MARK: - Re-Password Field
    private func rePasswordField() -> some View {
        VStack(alignment: .leading) {
            SecureField(LocaleKeys.rePassword.localized, text: $vm.state.rePassword)
                .modifier(TextFieldViewModifier())
                .disabled(vm.state.password.isEmpty)
            if let error = vm.state.rePasswordError {
                Text(error).modifier(ValidationErrorViewModifier())
            }
        }
    }

    // MARK: - Date Picker Field
    private func datePickerField() -> some View {
        VStack(alignment: .leading) {
            DatePicker(
                LocaleKeys.birthDate.localized,
                selection: $vm.state.birthDate,
                displayedComponents: .date
            )
            .datePickerStyle(.compact)
            .modifier(DateSelectorViewModifier())

            if let error = vm.state.birthDateError {
                Text(error).modifier(ValidationErrorViewModifier())
            }
        }
    }

    // MARK: - Sign Up Button
    private func signUpButton() -> some View {
        HStack {
            Spacer()
            Button(LocaleKeys.signUp.localized) {
                Task { await vm.onTapSignUp() }
            }
            .buttonStyle(AppButtonStyle(isDisabled: vm.state.isFieldsEmpty))
            .disabled(vm.state.isFieldsEmpty)
        }
        .padding(.top, 10)
    }

    // MARK: - Description
    private func descriptionTitle() -> some View {
        VStack(alignment: .leading) {
            Text(LocaleKeys.Register.letsSignUp.localized)
                .font(AppFont.title)
            Text(LocaleKeys.Register.eyctsu.localized)
                .font(AppFont.subtitle)
        }
    }
}

// MARK: - Preview
#Preview {
    NavigationStack {
        RegisterView()
    }
}
