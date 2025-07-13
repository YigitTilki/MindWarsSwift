//
//  ToJsonConvertible.swift
//  MindWars
//
//  Created by Yiğit Tilki on 17.04.2025.
//

import Foundation

protocol ToJsonConvertible: Encodable {
    func toJson() -> [String: Any]
}

extension ToJsonConvertible {
    func toJson() -> [String: Any] {
        guard let data = try? JSONEncoder().encode(self),
              let dictionary = try? JSONSerialization.jsonObject(with: data) as? [String: Any]
        else {
            return [:]
        }
        return dictionary
    }
}
