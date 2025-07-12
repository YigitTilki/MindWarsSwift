//
//  AuthRepository.swift
//  MindWars
//
//  Created by Yiğit Tilki on 5.07.2025.
//

import Alamofire
import Foundation

struct AuthRepository: AuthRepositoryProtocol {
    

    private let networkManager: NetworkManagerProtocol
    
    init(networkManager: NetworkManagerProtocol = NetworkManager()) {
            self.networkManager = networkManager
        }
        

    func signUp(model: AuthUserPostModel) async -> Result<
        AuthUserResponseModel, Error
    > {
        let path = "signUp?key=\(Env.apiKey)"
        let response = await networkManager.post(
            baseUrl: Env.authBaseUrl,
            path: path,
            model: model,
            type: AuthUserResponseModel.self
        )

        return response
    }

    func signIn(model: AuthUserPostModel) async -> Result<
        AuthUserResponseModel, Error
    > {
        let path = "signInWithPassword?key=\(Env.apiKey)"
        let response = await networkManager.post(
            baseUrl: Env.authBaseUrl,
            path: path,
            model: model,
            type: AuthUserResponseModel.self
        )
        return response
    }

    func getToken(model: TokenPostModel) async -> Result<
        TokenResponseModel, Error
    > {
        let path = "token?key=\(Env.apiKey)"
        let response = await networkManager.post(
            baseUrl: Env.tokenBaseUrl,
            path: path,
            model: model,
            type: TokenResponseModel.self
        )
        return response
    }

    func createFirestoreUser(model: FirestorePostModel<CreateFirestoreUserModel>, token: String) async
        -> Result<FirestoreResponseModel<CreateFirestoreUserModel>, Error>
    {
        let path = "users/"
        let response = await networkManager.post(
            baseUrl: Env.fireStoreBaseUrl,
            path: path,
            model: model,
            type: FirestoreResponseModel<CreateFirestoreUserModel>.self,
            headers: ["Authorization": "Bearer \(token)"]
        )
        return response
    }
}
