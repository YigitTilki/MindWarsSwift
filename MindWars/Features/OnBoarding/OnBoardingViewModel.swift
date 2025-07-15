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

    private let authUseCase: AuthUseCaseProtocol
    private let realmDatabase: RealmDatabaseProtocol

    init(
        realm: RealmDatabaseProtocol = RealmDatabase(),
        authUseCase: AuthUseCaseProtocol = AuthUseCase()
    ) {
        self.realmDatabase = realm
        self.authUseCase = authUseCase
    }

    func onTapLetsStart() async {
        await performLoadingTask { [self] in
            let token = getToken()
            guard let refreshToken = token?.refreshToken, !refreshToken.isEmpty
            else {
                navigateLogin = true
                return
            }

            let result = await authUseCase.refreshAndLoadUser(refreshToken: refreshToken)

            switch result {
            case .success:
                navigateHome = true
            case .failure(let error):
                navigateLogin = true
            }
        }
    }
    
    private func getToken() -> StorageTokenModel? {
        return realmDatabase.getItem(key: StorageKeys.authToken.rawValue)
    }

}
