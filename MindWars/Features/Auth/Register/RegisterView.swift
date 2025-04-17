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
            Text("already_have_an_account")
            NavigationLink("sign_in", destination: {
                LoginView()
            })
        }
        .frame(maxWidth: .infinity, alignment: .center)
        .padding(.top, 50)
    }

    // MARK: - User Name Field

    func userNameField() -> some View {
        VStack {
            TextField("username", text: $vm.userName)
                .appTextField()
            if let error = vm.userNameError {
                Text(error).foregroundColor(.red)
            }
        }
    }

    // MARK: - Email Field

    func emailField() -> some View {
        VStack {
            TextField("email", text: $vm.email)
                .appTextField()
            if let error = vm.emailError {
                Text(error).foregroundColor(.red)
            }
        }
    }

    // MARK: - Password Field

    func passwordField() -> some View {
        VStack {
            TextField("password", text: $vm.password)
                .appTextField()
            if let error = vm.passwordError {
                Text(error).foregroundColor(.red)
            }
        }
    }

    // MARK: - Re-Password Field

    func rePasswordField() -> some View {
        VStack {
            TextField("re_password", text: $vm.rePassword)
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
            DatePicker("birth_date", selection: $vm.birthDate, displayedComponents: .date)
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
                title: "sign_up",
                backgroundColor: vm.isFieldsEmpty ? .gray : .blue,
                action: {
                    Task {
                        await vm.signUpButtonOnPressed()
                    }
                }
            )
            .disabled(vm.isFieldsEmpty)
        }
    }

    // MARK: - Description

    func descriptionTitle() -> some View {
        VStack(alignment: .leading) {
            Text("lets_sign_up")
                .font(.title)
            Text("enter_your_credentials_to_sign_up")
                .font(.callout)
        }
    }
}

// MARK: - Preview

#Preview {
    RegisterView()
}
