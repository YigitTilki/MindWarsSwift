//
//  RegisterViewModel.swift
//  MindWars
//
//  Created by Yiğit Tilki on 21.12.2024.
//

import Foundation
import SwiftUICore

@MainActor
final class RegisterViewModel: BaseViewModel, ObservableObject {
    @Published var state = RegisterState()
    @Published var navigateToHome: Bool = false

    private let authUseCase: AuthUseCaseProtocol

    init(authUseCase: AuthUseCaseProtocol = AuthUseCase()) {
        self.authUseCase = authUseCase
    }

    // MARK: - Clear Forms
    private func clearForm() { state = RegisterState() }

    // MARK: - Is Forms Validate
    private func validate() {
        state.emailError = Validator.validateEmail(state.email)
        state.passwordError = Validator.validatePassword(state.password)
        state.rePasswordError = Validator.validateRePassword(state.password, state.rePassword)
        state.userNameError = Validator.validateUsername(state.userName)
        state.birthDateError = Validator.validateBirthdate(state.birthDate)
        }

    // MARK: - Sign Up Button Action
    func onTapSignUp() async {
        validate()
        
        guard state.isValid else { return }
        
        UIKitFunctions().dismissKeyboard()

        await performLoadingTask { [self] in
            await handleSignUp()
        }
    }

    private func handleSignUp() async {

        let result = await authUseCase.signUp(state: state)

        switch result {
        case .success:
            clearForm()
            navigateToHome = true
        case .failure(let error):
            toast = Toast(
                style: .error,
                message: ErrorMessageProvider.authMessage(error: error)
            )
        }
    }

}

