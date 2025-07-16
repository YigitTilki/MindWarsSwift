//
//  AuthUseCaseProtocol.swift
//  MindWars
//
//  Created by Yiğit Tilki on 15.07.2025.
//

import Foundation

protocol AuthUseCaseProtocol {
    func signUp(state: RegisterState) async -> Result<Void, Error>
    func signIn(state: LoginState) async -> Result<Void, Error>
    func refreshAndLoadUser(refreshToken: String) async -> Result<Void, Error>
}
