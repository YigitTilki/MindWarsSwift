//
//  AuthRepositoryProtocol.swift
//  MindWars
//
//  Created by Yiğit Tilki on 12.07.2025.
//

import Foundation

protocol AuthRepositoryProtocol {
    func signUp(model: AuthUserPostModel) async -> Result<AuthUserResponseModel, Error>
    func signIn(model: AuthUserPostModel) async -> Result<AuthUserResponseModel, Error>
    func getToken(model: TokenPostModel) async -> Result<TokenResponseModel, Error>
    func createFirestoreUser(model: CreateFirestoreUserPostModel) async -> Result<CreateFirestoreUserPostModel, Error>
}
