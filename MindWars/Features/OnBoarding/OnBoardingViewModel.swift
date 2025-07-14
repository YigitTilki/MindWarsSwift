//
//  OnBoardingViewModel.swift
//  MindWars
//
//  Created by Yiğit Tilki on 13.07.2025.
//

import Foundation

final class OnBoardingViewModel: BaseViewModel, ObservableObject {

    @Published var navigateLogin = false
    @Published var navigateHome = false

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

    func onTapLetsStart() async {
        await performLoadingTask { [self] in
            let getToken = getToken()
            let refreshToken = getToken?.refreshToken ?? ""

            guard !refreshToken.isEmpty else {
                navigateLogin = true
                return
            }

            let model = TokenPostModel(refresh_token: refreshToken)
            let result = await authRepository.getToken(model: model)

            switch result {
            case .success(let data):
                saveToken(data: data)
                await getUser(userId: data.userId, token: data.idToken)
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
    }

    private func getUser(userId: String, token: String) async {
        let result = await authRepository.getFirestoreUser(
            userId: userId,
            token: token
        )
        switch result {
        case .success(let data):
            saveUser(data: data)
            navigateHome = true
            
        case .failure(let error):
            print("Error fetching user: \(error.localizedDescription)")
        }
    }
    
    private func saveToken(data: TokenResponseModel) {
        let token = StorageTokenModel()
        token.idToken = data.idToken
        token.refreshToken = data.refreshToken
        token.expiresIn = data.expiresIn

        realmDatabase.add(model: token)
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
    
    private func getToken() -> StorageTokenModel? {
        return realmDatabase.getItem(key: StorageKeys.authToken.rawValue)
    }

}
