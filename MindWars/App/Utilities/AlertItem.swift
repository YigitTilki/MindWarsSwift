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




struct AlertContext {
    //MARK: - Auth Alerts
    static let wrongPassword      = AlertItem(title: Text("Wrong Password"),
                                            message: Text("Your password is wrong. Check your password and email then try again"),
                                            dismissButton: .default(Text("OK")))
    
    static let questionPartCantEmpty      = AlertItem(title: Text("Question Part Cannot Empty"),
                                            message: Text("Your question part is empty. Check your question part then try again"),
                                            dismissButton: .default(Text("OK")))
    
    static let questionCreatedSuccesfully      = AlertItem(title: Text("Question Created"),
                                            message: Text("Your question has been created successfully"),
                                            dismissButton: .default(Text("OK")))
    
    static let unexpectedError      = AlertItem(title: Text("Unexpected Error"),
                                            message: Text("Something went wrong. Please try again later"),
                                            dismissButton: .default(Text("OK")))
    
    
}
