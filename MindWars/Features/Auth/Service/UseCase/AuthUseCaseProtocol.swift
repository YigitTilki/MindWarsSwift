//
//  AuthUseCaseProtocol.swift
//  MindWars
//
//  Created by Yiğit Tilki on 15.07.2025.
//

import Foundation

protocol AuthUseCaseProtocol {
    func signUp(state: RegisterState) async -> Result<Void, Error>
}
