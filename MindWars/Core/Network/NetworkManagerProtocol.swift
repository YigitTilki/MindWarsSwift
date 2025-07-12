//
//  NetworkManagerProtocol.swift
//  MindWars
//
//  Created by Yiğit Tilki on 12.07.2025.
//

import Foundation
import Alamofire

protocol NetworkManagerProtocol {
    func get<T: Codable>(
        baseUrl: String,
        path: String,
        type _: T.Type,
        headers: HTTPHeaders?
    ) async -> Result<T?, Error>
    
    func post<T: Codable, R: Encodable>(
        baseUrl: String,
        path: String,
        model: R,
        type _: T.Type,
        headers: HTTPHeaders?
    ) async -> Result<T, Error>
}

extension NetworkManagerProtocol {
    func post<T: Codable, R: Encodable>(
        baseUrl: String,
        path: String,
        model: R,
        type: T.Type
    ) async -> Result<T, Error> {
        await post(baseUrl: baseUrl, path: path, model: model, type: type, headers: nil)
    }
}
