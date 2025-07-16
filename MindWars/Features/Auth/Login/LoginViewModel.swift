//
//  LoginViewModel.swift
//  MindWars
//
//  Created by Yiğit Tilki on 21.12.2024.
//

import Foundation
import SwiftUICore
import UIKit

@MainActor
class LoginViewModel: BaseViewModel, ObservableObject {
    @Published var state = LoginState()
    @Published var navigate: Bool = false

    private let authUseCase: AuthUseCaseProtocol

    init(authUseCase: AuthUseCaseProtocol = AuthUseCase()) {
        self.authUseCase = authUseCase
    }

    // MARK: - Clear Fields
    private func clearForm() { state = LoginState() }

    //MARK: - Login Button Action
    func onTapLogin() async {
        UIKitFunctions().dismissKeyboard()

        await performLoadingTask { [self] in
            await handleLogin()
        }
    }

    //MARK: - Login User
    private func handleLogin() async {

        let result = await authUseCase.signIn(state: state)

        switch result {

        case .success(let data):
            clearForm()
            navigate = true
        case .failure(let error):
            toast = Toast(
                style: .error,
                message: ErrorMessageProvider.firebaseErrorMessage(error: error)
            )
        }
    }

}
