//
//  ff.swift
//  MindWars
//
//  Created by Yiğit Tilki on 12.07.2025.
//

import Foundation


@propertyWrapper
struct FirestoreField<T: Codable> {
    var wrappedValue: T
    
    init(wrappedValue: T) {
        self.wrappedValue = wrappedValue
    }
}

extension FirestoreField: Codable {
    func encode(to encoder: Encoder) throws {
        var container = encoder.singleValueContainer()
        
        if let optional = wrappedValue as? OptionalProtocol, optional.isNil {
            try container.encode(FirestoreValue.null)
            return
        }

        switch wrappedValue {
        case let v as String:
            try container.encode(FirestoreValue.string(v))
        case let v as Int:
            try container.encode(FirestoreValue.int(v))
        case let v as Double:
            try container.encode(FirestoreValue.double(v))
        case let v as Bool:
            try container.encode(FirestoreValue.bool(v))
        case let v as Date:
            let isoDate = ISO8601DateFormatter().string(from: v)
            try container.encode(FirestoreValue.timestamp(isoDate))
        default:
            let stringValue = String(describing: wrappedValue)
            try container.encode(FirestoreValue.string(stringValue))
        }
    }

    
    init(from decoder: Decoder) throws {
        let container = try decoder.singleValueContainer()
        let firestoreValue = try container.decode(FirestoreValue.self)
        switch firestoreValue {
        case .string(let v) where T.self == String.self:
            wrappedValue = v as! T
        case .int(let v) where T.self == Int.self:
            wrappedValue = v as! T
        case .double(let v) where T.self == Double.self:
            wrappedValue = v as! T
        case .bool(let v) where T.self == Bool.self:
            wrappedValue = v as! T
        case .timestamp(let v) where T.self == Date.self:
            wrappedValue = ISO8601DateFormatter().date(from: v) as! T
        case .null:
            wrappedValue = Optional<Any>.none as! T
        default:
            throw DecodingError.dataCorruptedError(in: container, debugDescription: "Mismatched Firestore value type")
        }
    }
}





protocol OptionalProtocol {
    var isNil: Bool { get }
}

extension Optional: OptionalProtocol {
    var isNil: Bool { self == nil }
}
