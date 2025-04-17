//
//  NetworkConfig.swift
//  MindWars
//
//  Created by Yiğit Tilki on 12.07.2025.
//

import Foundation

struct NetworkConfig {
    let baseUrl: String

    init(baseUrl: String) {
        self.baseUrl = baseUrl
    }

    init() {
        self.baseUrl = "http://localhost:8080"
    }
}
