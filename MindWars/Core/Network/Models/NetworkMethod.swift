//
//  NetworkMethod.swift
//  MindWars
//
//  Created by Yiğit Tilki on 12.07.2025.
//

import Alamofire
import Foundation

enum NetworkMethod {
    case GET
    case POST
    case PUT
    
    var value: HTTPMethod {
        switch self {
        case .GET:
            return .get
        case .POST:
            return .post
        case .PUT:
            return .put
        }
    }
}
