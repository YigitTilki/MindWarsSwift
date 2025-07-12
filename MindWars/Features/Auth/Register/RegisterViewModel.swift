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
    
    var isFieldsEmpty: Bool {
        userName.isEmpty || email.isEmpty || password.isEmpty
            || rePassword.isEmpty
    }

    private let authRepository: AuthRepositoryProtocol

    private var realmDatabase: RealmDatabaseProtocol

    //MARK: - Init
    init(
        realm: RealmDatabaseProtocol = RealmDatabase(),
        authRepository: AuthRepositoryProtocol = AuthRepository()
    ) {
        self.realmDatabase = realm
        self.authRepository = authRepository
    }


    // MARK: - Clear Forms
    private func clearForm() {
        email = ""
        userName = ""
        birthDate = Date()
        password = ""
        rePassword = ""
    }

    // MARK: - Is Forms Validate
    private func validate() -> Bool {
        emailError = Validator.validateEmail(email)
        passwordError = Validator.validatePassword(password)
        rePasswordError = Validator.validateRePassword(password, rePassword)
        userNameError = Validator.validateUsername(userName)
        birthDateError = Validator.validateBirthdate(birthDate)

        return [emailError, passwordError, userNameError, birthDateError]
            .allSatisfy { $0 == nil }
    }

    // MARK: - Sign Up Button Action
    func onTapSignUp() async {
        guard validate() else { return }
        UIKitFunctions().dismissKeyboard()

        await performLoadingTask { [self] in
            await registerUser()
        }
    }

    //MARK: - Register User for Auth - 1.
    private func registerUser() async {
        let authModel = AuthUserPostModel(email: email, password: password)
        let result = await authRepository.signUp(model: authModel)

        switch result {
        case .success(let data):
            await handleAuthSuccess(data: data)
        case .failure(let error):
            self.error = error.localizedDescription
        }
    }

    //MARK: - Save User Token to Realm Database
    private func saveToken(data: AuthUserResponseModel) {
        let token = TokenModel()
        token.idToken = data.idToken
        token.refreshToken = data.refreshToken
        token.expiresIn = data.expiresIn

        realmDatabase.add(model: token)
    }

    //MARK: - Register User for Firestore - 2.
    private func handleAuthSuccess(data: AuthUserResponseModel) async {
        saveToken(data: data)

        let userCredentials = CreateFirestoreUserModel(
            id: data.localId,
            email: data.email,
            userName: userName,
            birthDate: birthDate
        )
        let firestoreModel = FirestorePostModel(fields: userCredentials)

        let result = await authRepository.createFirestoreUser(
            model: firestoreModel,
            token: data.idToken
        )

        switch result {
        case .success:
            clearForm()
            navigateToHome = true
        case .failure(let error):
            print("Firestore Error: \(error.localizedDescription)")
        }
    }
}
