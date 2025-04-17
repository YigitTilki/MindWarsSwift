//
//  AuthRepository.swift
//  MindWars
//
//  Created by Yiğit Tilki on 5.07.2025.
//

import Alamofire
import Foundation

struct AuthRepository {
    private let networkManager = NetworkManager()

    func signUp(model: AuthUserPostModel) async -> Result<AuthUserResponseModel, Error> {
        let path = "signUp?key=\(Env.apiKey)"
        let response = await networkManager.post(
            baseUrl: Env.authBaseUrl,
            path: path,
            model: model,
            type: AuthUserResponseModel.self
        )
       
        return response
    }

    func signIn(model: AuthUserPostModel) async -> Result<AuthUserResponseModel, Error> {
        let path = "signInWithPassword?key=\(Env.apiKey)"
        let response = await networkManager.post(
            baseUrl: Env.authBaseUrl,
            path: path,
            model: model,
            type: AuthUserResponseModel.self
        )
        return response
    }
    
    func getToken(model: TokenPostModel) async -> Result<TokenResponseModel, Error> {
        let path = "token?key=\(Env.apiKey)"
        let response = await networkManager.post(
            baseUrl: Env.tokenBaseUrl,
            path: path,
            model: model,
            type: TokenResponseModel.self
        )
        return response
    }
}
