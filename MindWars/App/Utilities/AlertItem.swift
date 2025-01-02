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
    
    
}
