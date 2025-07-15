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
    func createFirestoreUser(model: FirestorePostModel<FirestoreUserPostModel>, token: String) async
        -> Result<FirestoreResponseModel<FirestoreUserPostModel>, Error>
    func getFirestoreUser(userId: String, token: String) async
        -> Result<FirestoreResponseModel<FirestoreUserResponseModel>, Error>
}
