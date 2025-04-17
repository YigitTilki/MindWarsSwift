//
//  RedMindWarInfoModel.swift
//  MindWars
//
//  Created by Yiğit Tilki on 25.02.2025.
//

import Foundation

struct RedMindWarInfoModel: Decodable {
    let id: String
    let name: String
    let parts: [String]
}
