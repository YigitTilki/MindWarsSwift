//
//  OnBoardingViewModel.swift
//  MindWars
//
//  Created by Yiğit Tilki on 13.07.2025.
//

import Foundation

class OnBoardingViewModel: BaseViewModel, ObservableObject {

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

    private func getToken() -> TokenModel? {
        return realmDatabase.getItem(key: StorageKeys.authToken.rawValue)
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
                navigateHome = true
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
    }
    
    private func saveToken(data: TokenResponseModel) {
        let token = TokenModel()
        token.idToken = data.idToken
        token.refreshToken = data.refreshToken
        token.expiresIn = data.expiresIn

        realmDatabase.add(model: token)
    }
}
