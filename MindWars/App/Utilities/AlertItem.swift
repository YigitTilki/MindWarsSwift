//
//  AlertItem.swift
//  MindWars
//
//  Created by Yiğit Tilki on 29.12.2024.
//

import SwiftUI

struct AlertItem: Identifiable {
    let id = UUID()
    let title: Text
    let message: Text
    let dismissButton: Alert.Button
}

enum AlertContext {

    static let wrongPassword = AlertItem(title: Text("wrong_password"),
                                         message: Text("wrong_password_explain"),
                                         dismissButton: .default(Text("OK")))

    static let unexpectedError = AlertItem(title: Text("unexpected_error"),
                                           message: Text("unexpected_error_message"),
                                           dismissButton: .default(Text("ok")))

    static let unavailableService = AlertItem(title: Text("unavaliable_service"),
                                              message: Text("unavaliable_service_message"),
                                              dismissButton: .default(Text("ok")))
}
