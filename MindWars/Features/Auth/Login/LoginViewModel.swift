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
    @Published var email: String = ""
    @Published var password: String = ""
    @Published var isValid: Bool = false
    @Published var navigate: Bool = false

    private let authRepository = AuthRepository()

    private var realmDatabase: StorageManagerProtocol!

    init(realm: StorageManagerProtocol = RealmDatabase()) {
        self.realmDatabase = realm
    }

    // MARK: - Clear Fields

    func clearForm() {
        email = ""
        password = ""
    }

    // MARK: - Validation

    func validate() -> Bool {
        isValid = !email.isEmpty && !password.isEmpty

        return isValid
    }

    //MARK: - Login Button Action

    func onTapLogin() async {
        guard validate() else { return }

        let model = AuthUserPostModel(email: email, password: password)

        UIKitFunctions().dismissKeyboard()

        await performLoadingTask { [self] in
            let result = await authRepository.signIn(model: model)

            switch result {

            case .success(let tokenResponse):
                let token = TokenModel()
                token.idToken = tokenResponse.idToken
                token.refreshToken = tokenResponse.refreshToken
                token.expiresIn = tokenResponse.expiresIn

                realmDatabase.add(model: token)

                self.navigate = true
                clearForm()

            case .failure(let error):
                print("Error: \(error.localizedDescription)")
            }
        }
    }
}
