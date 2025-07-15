//
//  AuthUseCase.swift
//  MindWars
//
//  Created by Yiğit Tilki on 15.07.2025.
//

import Foundation

final class AuthUseCase: AuthUseCaseProtocol {
    private let authRepository: AuthRepositoryProtocol
    private let realmDatabase: RealmDatabaseProtocol

    init(
        authRepository: AuthRepositoryProtocol = AuthRepository(),
        realmDatabase: RealmDatabaseProtocol = RealmDatabase()
    ) {
        self.authRepository = authRepository
        self.realmDatabase = realmDatabase
    }

    func signUp(state: RegisterState) async -> Result<Void, Error> {
        let result = await authRepository.signUp(
            model: AuthUserPostModel(email: state.email, password: state.password)
        )

        switch result {
        case .success(let data):
            await MainActor.run { saveToken(data: data) }
                    
            let firestoreUserPostModel = FirestoreUserPostModel(
                id: data.localId,
                email: state.email,
                userName: state.userName,
                birthDate: state.birthDate
            )

            let firestoreModel = FirestorePostModel(
                fields: firestoreUserPostModel
            )

            let firestoreResult = await authRepository.createFirestoreUser(
                model: firestoreModel,
                token: data.idToken
            )

            switch firestoreResult {
            case .success(let userData):
                await MainActor.run { saveUser(data: userData) }
                return .success(())
            case .failure(let error):
                return .failure(error)
            }

        case .failure(let error):
            return .failure(error)
        }

    }

    @MainActor
    private func saveToken(data: AuthUserResponseModel) {

        let token = StorageTokenModel()
        token.idToken = data.idToken
        token.refreshToken = data.refreshToken
        token.expiresIn = data.expiresIn
        realmDatabase.add(model: token)
    }

    @MainActor
    private func saveUser(data: FirestoreResponseModel<FirestoreUserPostModel>)
    {
        let user = StorageUserModel()
        user.userId = data.fields.id
        user.email = data.fields.email
        user.birthDate = data.fields.birthDate
        user.userName = data.fields.userName
        realmDatabase.add(model: user)
    }
}
