//
//  RegisterViewModel.swift
//  MindWars
//
//  Created by Yiğit Tilki on 21.12.2024.
//

import FirebaseAuth
import Foundation
import SwiftUICore

@MainActor
class RegisterViewModel: BaseViewModel, ObservableObject {
    @Published var userName: String = ""
    @Published var userNameError: LocalizedStringKey?

    @Published var email: String = ""
    @Published var emailError: LocalizedStringKey?

    @Published var birthDate: Date = .init()
    @Published var birthDateError: LocalizedStringKey?

    @Published var password: String = ""
    @Published var passwordError: LocalizedStringKey?

    @Published var rePassword: String = ""
    @Published var rePasswordError: LocalizedStringKey?

    @Published var navigateToHome: Bool = false
    
    private let authRepository = AuthRepository()

    private var realmDatabase: StorageManagerProtocol!

    init(realm: StorageManagerProtocol = RealmDatabase()) {
        self.realmDatabase = realm
    }

    var isFieldsEmpty: Bool {
        userName.isEmpty || email.isEmpty || password.isEmpty || rePassword.isEmpty
    }

    // MARK: - Sign Up Button OnPressed

    func signUpButtonOnPressed() async {
        let validate = validate()
        if !validate { return }

        UIKitFunctions().dismissKeyboard()

        await performLoadingTask { [self] in
            let result = await AuthService.signUp(email: email, password: password)

            switch result {
            case let .success(user):
                let result = await AuthService.saveUserToFirestore(data: UserCreateModel(id: user.uid, username: userName, email: user.email, birthDate: birthDate))

                switch result {
                case .success:
                    navigateToHome = true

                case let .failure(error):
                    print("Error: \(error.localizedDescription)")
                }
            // TODO: Remove prints add modal
            case let .failure(error):
                print("Error: \(error.localizedDescription)")
                self.error = error.localizedDescription
            }
        }
    }

    // MARK: - Clear Forms

    func clearForm() {
        email = ""
        userName = ""
        birthDate = Date()
        password = ""
        rePassword = ""
    }

    // MARK: - Is Forms Validate

    func validate() -> Bool {
        emailError = Validator.validateEmail(email)
        passwordError = Validator.validatePassword(password)
        rePasswordError = Validator.validateRePassword(password, rePassword)
        userNameError = Validator.validateUsername(userName)
        birthDateError = Validator.validateBirthdate(birthDate)

        return [emailError, passwordError, userNameError, birthDateError].allSatisfy { $0 == nil }
    }
    
    // MARK: - Sign Up Button Action

    func onTapSignUp() async {
        
        let model = AuthUserPostModel(email: email, password: password)
        guard validate() else { return }

        UIKitFunctions().dismissKeyboard()

        await performLoadingTask { [self] in
            let result = await authRepository.signUp(model: model)

            switch result {
            case let .success(user):
                let result = await AuthService.saveUserToFirestore(data: UserCreateModel(id: user.localId, username: userName, email: user.email, birthDate: birthDate))

                switch result {
                case .success:
                    navigateToHome = true

                case let .failure(error):
                    print("Error: \(error.localizedDescription)")
                }
            // TODO: Remove prints add modal
            case let .failure(error):
                print("Error: \(error.localizedDescription)")
                self.error = error.localizedDescription
            }
        }
    }
}
