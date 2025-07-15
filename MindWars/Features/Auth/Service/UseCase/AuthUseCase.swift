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
    
    func refreshAndLoadUser(refreshToken: String) async -> Result<Void, Error> {
        let model = TokenPostModel(refreshToken: refreshToken)
        let result = await authRepository.getToken(model: model)

        switch result {
        case .success(let tokenData):
            await MainActor.run { saveToken(data: tokenData) }

            let userResult = await authRepository.getFirestoreUser(
                userId: tokenData.userId,
                token: tokenData.idToken
            )

            switch userResult {
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
    private func saveUser<T: FirestoreUserStorageProtocol>(data: FirestoreResponseModel<T>) {
        let user = StorageUserModel(from: data.fields)
        realmDatabase.add(model: user)
    }

    @MainActor
    private func saveToken<T: TokenStorageProtocol>(data: T) {
        let token = StorageTokenModel(from: data)
        realmDatabase.add(model: token)
    }

}
