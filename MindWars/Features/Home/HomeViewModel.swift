//
//  HomeViewModel.swift
//  MindWars
//
//  Created by Yiğit Tilki on 21.12.2024.
//

import Foundation

@MainActor
class HomeViewModel: ObservableObject {
    
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
    
    func getUser() -> StorageUserModel? {
        return realmDatabase.getItem(key: StorageKeys.userDetails.rawValue)
    }
}
