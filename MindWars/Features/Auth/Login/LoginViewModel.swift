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
    @Published var navigate: Bool = false
    @Published var errorMessage: String?
    
    private var isValid: Bool = false
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

    // MARK: - Clear Fields
    private func clearForm() {
        email = ""
        password = ""
    }

    // MARK: - Validation
    private func validate() -> Bool {
        isValid = !email.isEmpty && !password.isEmpty
            
        return isValid
    }

    //MARK: - Login Button Action
    func onTapLogin() async {
        guard validate() else { return }
        UIKitFunctions().dismissKeyboard()

        await performLoadingTask { [self] in
           await loginUser()
        }
    }
    
    //MARK: - Login User
    private func loginUser() async {
        let model = AuthUserPostModel(email: email, password: password)
        let result = await authRepository.signIn(model: model)

        switch result {

        case .success(let data):
            saveToken(data: data)
            await getUser(userId: data.localId, token: data.idToken)
            
        case .failure(_):
            errorMessage = LocaleKeys.Login.invalideop.localized
            break
        }
    }
    
    //MARK: - Save User Token to Realm Database
    private func saveToken(data: AuthUserResponseModel) {
        let token = StorageTokenModel()
        token.idToken = data.idToken
        token.refreshToken = data.refreshToken
        token.expiresIn = data.expiresIn

        realmDatabase.add(model: token)
    }
    
    private func getUser(userId: String, token: String) async {
        let result = await authRepository.getFirestoreUser(
            userId: userId,
            token: token
        )
        switch result {
        case .success(let data):
            saveUser(data: data)
            self.navigate = true
            clearForm()
        case .failure(let error):
            print("Error fetching user: \(error.localizedDescription)")
        }
    }
    
    private func saveUser(
        data: FirestoreResponseModel<FirestoreUserResponseModel>
    ) {
        let storage = StorageUserModel()
        storage.userId = data.fields.id
        storage.email = data.fields.email
        storage.birthDate = data.fields.birthDate
        storage.userName = data.fields.userName

        realmDatabase.add(model: storage)
    }

}
