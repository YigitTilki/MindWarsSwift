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
    // MARK: - Auth Alerts

    static let wrongPassword = AlertItem(title: Text("Wrong Password"),
                                         message: Text("Your password is wrong. Check your password and email then try again"),
                                         dismissButton: .default(Text("OK")))

    static let questionPartCantEmpty = AlertItem(title: Text("question_part_cannot_empty"),
                                                 message: Text("question_part_cannot_empty_message"),
                                                 dismissButton: .default(Text("ok")))

    static let questionCreatedSuccesfully = AlertItem(title: Text("question_created"),
                                                      message: Text("question_created_message"),
                                                      dismissButton: .default(Text("ok")))

    static let unexpectedError = AlertItem(title: Text("unexpected_error"),
                                           message: Text("unexpected_error_message"),
                                           dismissButton: .default(Text("ok")))

    static let unavailableService = AlertItem(title: Text("unavaliable_service"),
                                              message: Text("unavaliable_service_message"),
                                              dismissButton: .default(Text("ok")))
}
