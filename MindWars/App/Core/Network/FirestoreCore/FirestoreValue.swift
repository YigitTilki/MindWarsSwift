//
//  FirestoreValue.swift
//  MindWars
//
//  Created by Yiğit Tilki on 13.07.2025.
//

import Foundation

enum FirestoreValue: Codable {
    case string(String)
    case int(Int)
    case double(Double)
    case bool(Bool)
    case timestamp(String)
    case null

    enum CodingKeys: String, CodingKey {
        case stringValue, integerValue, doubleValue, booleanValue, timestampValue, nullValue
    }

    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        if let v = try? container.decode(String.self, forKey: .stringValue) {
            self = .string(v)
        } else if let v = try? container.decode(Int.self, forKey: .integerValue) {
            self = .int(v)
        } else if let v = try? container.decode(Double.self, forKey: .doubleValue) {
            self = .double(v)
        } else if let v = try? container.decode(Bool.self, forKey: .booleanValue) {
            self = .bool(v)
        } else if let v = try? container.decode(String.self, forKey: .timestampValue) {
            self = .timestamp(v)
        } else if (try? container.decodeNil(forKey: .nullValue)) == true {
            self = .null
        } else {
            throw DecodingError.dataCorrupted(.init(codingPath: [], debugDescription: "Unknown Firestore value"))
        }
    }

    func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        switch self {
        case .string(let v): try container.encode(v, forKey: .stringValue)
        case .int(let v): try container.encode(v, forKey: .integerValue)
        case .double(let v): try container.encode(v, forKey: .doubleValue)
        case .bool(let v): try container.encode(v, forKey: .booleanValue)
        case .timestamp(let v): try container.encode(v, forKey: .timestampValue)
        case .null: try container.encodeNil(forKey: .nullValue)
        }
    }
}
