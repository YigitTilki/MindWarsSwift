//
//  NetworkManager.swift
//  MindWars
//
//  Created by Yiğit Tilki on 4.07.2025.
//

import Alamofire
import Foundation

class NetworkManager: NetworkManagerProtocol {
    func get<T: Codable>(
        baseUrl: String,
        path: String,
        type _: T.Type,
        headers: HTTPHeaders? = nil
    ) async -> Result<T, Error> {
        let dataRequest = AF.request(
            "\(baseUrl)\(path)",
            method: .get,
            headers: headers
        )
            .validate()
            .serializingDecodable(T.self)
        
        print("📤 Request: \(baseUrl)\(path)")
        print("📦 Request headers: \(String(describing: headers))")
        
        let result = await dataRequest.response
        
        if let value = result.value {
            print("✅ SUCCESS: \(value)")
            return .success(value)
        } else {
            print("❌ ERROR: \(String(describing: result.error))")
            
            if let data = result.data {
                print("📦 Response body: \(String(data: data, encoding: .utf8) ?? "N/A")")
                
                if let firebaseError = try? JSONDecoder().decode(FirebaseErrorResponse.self, from: data) {
                    return .failure(firebaseError)
                }
            }
            
            return .failure(result.error ?? NSError(domain: "NetworkError", code: -1, userInfo: nil))
        }
    }
    
    func post<T: Codable, R: Encodable>(
        baseUrl: String,
        path: String,
        model: R,
        type _: T.Type,
        headers: HTTPHeaders? = nil
    ) async -> Result<T, Error> {
        let jsonEncoder = JSONEncoder()
        guard let data = try? jsonEncoder.encode(model) else {
            return .failure(NSError(domain: "NetworkError", code: -1, userInfo: [NSLocalizedDescriptionKey: "Failed to encode model to JSON"]))
        }
        guard String(data: data, encoding: .utf8) != nil else {
            return .failure(NSError(domain: "NetworkError", code: -1, userInfo: [NSLocalizedDescriptionKey: "Invalid JSON encoding"]))
        }
        let dataRequest = AF.request(
            "\(baseUrl)\(path)",
            method: .post,
            parameters: model,
            encoder: JSONParameterEncoder.default,
            headers: headers
        )
            .validate()
            .serializingDecodable(T.self)
        
        print("📤 Request: \(baseUrl)\(path)")
        print("📦 Request body: \(String(data: data, encoding: .utf8) ?? "N/A")")
        print("📦 Request headers: \(String(describing: headers))")
        
        let result = await dataRequest.response
        
        if let value = result.value {
            print("✅ SUCCESS: \(value)")
            return .success(value)
        } else {
            print("❌ ERROR: \(String(describing: result.error))")
            
            if let data = result.data {
                print("📦 Response body: \(String(data: data, encoding: .utf8) ?? "N/A")")
                
                if let firebaseError = try? JSONDecoder().decode(FirebaseErrorResponse.self, from: data) {
                    return .failure(firebaseError)
                }
            }
            
            return .failure(result.error ?? NSError(domain: "NetworkError", code: -1, userInfo: nil))
        }
    }
}
