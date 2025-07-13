//
//  StorageManager.swift
//  MindWars
//
//  Created by Yiğit Tilki on 12.07.2025.
//

import RealmSwift

protocol RealmDatabaseProtocol {
    func add<T: Object>(model: T)
    func clearAll<T: Object>(model: T.Type)
    func getItems<T: Object>() -> [T]
    func getItem<T: Object>(key: String) -> T?
    func delete<T: Object>(model: T)
    func deleteFromId<T: Object>(model: T.Type, id: String)

    func listenChanges<T: Object>(model: T.Type, result: @escaping (RealmDatabaseUpdate, [Int]) -> Void)
}

enum RealmDatabaseUpdate {
    case delete
    case insert
    case modify
}
