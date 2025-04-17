//
//  NetworkPath.swift
//  MindWars
//
//  Created by Yiğit Tilki on 12.07.2025.
//

import Foundation

enum NetworkPath: String, NetworkPathProtocol {
    case podcast = "podcast"
    case search = "search"

    var value: String {
        self.rawValue
    }
}

protocol NetworkPathProtocol {
    var value: String { get }
}
