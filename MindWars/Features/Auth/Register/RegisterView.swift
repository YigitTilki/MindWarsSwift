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

            if vm.isLoading {
                LoadingView()
            }
        }
    }

    // MARK: - All Fields

    func fields() -> some View {
        VStack {
            userNameField()
            emailField()
            passwordField()
            rePasswordField()
            datePickerField()
        }
    }

    // MARK: - Go Login Row

    func goLoginRow() -> some View {
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

    func userNameField() -> some View {
        VStack(alignment: .leading) {
            TextField(LocaleKeys.userName.localized, text: $vm.userName)
                .modifier(TextFieldViewModifier())
            if let error = vm.userNameError {
                Text(error).modifier(ValidationErrorViewModifier())
            }
        }
    }

    // MARK: - Email Field

    func emailField() -> some View {
        VStack(alignment: .leading) {
            TextField(LocaleKeys.email.localized, text: $vm.email)
                .modifier(TextFieldViewModifier())
            if let error = vm.emailError {
                Text(error).modifier(ValidationErrorViewModifier())
            }
        }
    }

    // MARK: - Password Field

    func passwordField() -> some View {
        VStack(alignment: .leading) {
            TextField(LocaleKeys.password.localized, text: $vm.password)
                .modifier(TextFieldViewModifier())
            if let error = vm.passwordError {
                Text(error).modifier(ValidationErrorViewModifier())
            }
        }
    }

    // MARK: - Re-Password Field

    func rePasswordField() -> some View {
        VStack(alignment: .leading) {
            TextField(LocaleKeys.rePassword.localized, text: $vm.rePassword)
                .modifier(TextFieldViewModifier())
                .disabled(vm.password.isEmpty)
            if let error = vm.rePasswordError {
                Text(error).modifier(ValidationErrorViewModifier())
            }
        }
    }

    // MARK: - Date Picker Field

    func datePickerField() -> some View {
        VStack(alignment: .leading) {
            DatePicker(
                LocaleKeys.birthDate.localized,
                selection: $vm.birthDate,
                displayedComponents: .date
            )
            .datePickerStyle(.compact)
            .modifier(DateSelectorViewModifier())

            if let error = vm.birthDateError {
                Text(error).modifier(ValidationErrorViewModifier())
            }
        }
    }

    // MARK: - Sign Up Button

    func signUpButton() -> some View {
        HStack {
            Spacer()
            Button(LocaleKeys.signUp.localized) {
                Task { await vm.onTapSignUp() }
            }
            .buttonStyle(AppButtonStyle(isDisabled: vm.isFieldsEmpty))
            .disabled(vm.isFieldsEmpty)
        }
        .padding(.top, 10)
    }

    // MARK: - Description

    func descriptionTitle() -> some View {
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
    RegisterView()
}
