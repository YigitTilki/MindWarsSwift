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
        CommonBackgroundView {
            VStack(alignment: .leading) {
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
            NavigationLink(LocaleKeys.signIn.localized, destination: {
                LoginView()
            })
        }
        .frame(maxWidth: .infinity, alignment: .center)
        .padding(.top, 50)
    }

    // MARK: - User Name Field

    func userNameField() -> some View {
        VStack {
            TextField(LocaleKeys.userName.localized, text: $vm.userName)
                .appTextField()
            if let error = vm.userNameError {
                Text(error).foregroundColor(.red)
            }
        }
    }

    // MARK: - Email Field

    func emailField() -> some View {
        VStack {
            TextField(LocaleKeys.email.localized, text: $vm.email)
                .appTextField()
            if let error = vm.emailError {
                Text(error).foregroundColor(.red)
            }
        }
    }

    // MARK: - Password Field

    func passwordField() -> some View {
        VStack {
            TextField(LocaleKeys.password.localized, text: $vm.password)
                .appTextField()
            if let error = vm.passwordError {
                Text(error).foregroundColor(.red)
            }
        }
    }

    // MARK: - Re-Password Field

    func rePasswordField() -> some View {
        VStack {
            TextField(LocaleKeys.rePassword.localized, text: $vm.rePassword)
                .appTextField()
                .disabled(vm.password.isEmpty)
            if let error = vm.rePasswordError {
                Text(error).foregroundColor(.red)
            }
        }
    }

    // MARK: - Date Picker Field

    func datePickerField() -> some View {
        VStack {
            DatePicker(LocaleKeys.birthDate.localized, selection: $vm.birthDate, displayedComponents: .date)
                .datePickerStyle(.compact)
                .padding(.vertical)
            if let error = vm.birthDateError {
                Text(error).foregroundColor(.red)
            }
        }
    }

    // MARK: - Sign Up Button

    func signUpButton() -> some View {
        HStack {
            Spacer()
            AppButton(
                title: LocaleKeys.userName.localized,
                backgroundColor: vm.isFieldsEmpty ? .gray : .blue,
                action: {
                    Task {
                        await vm.onTapSignUp()
                    }
                }
            )
            .disabled(vm.isFieldsEmpty)
        }
    }

    // MARK: - Description

    func descriptionTitle() -> some View {
        VStack(alignment: .leading) {
            Text(LocaleKeys.Register.letsSignUp.localized)
                .font(.title)
            Text(LocaleKeys.Register.eyctsu.localized)
                .font(.callout)
        }
    }
}

// MARK: - Preview

#Preview {
    RegisterView()
}
