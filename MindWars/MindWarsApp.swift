//
//  MindWarsApp.swift
//  MindWars
//
//  Created by Yiğit Tilki on 18.12.2024.
//

import SwiftUI

@main
struct MindWarsApp: App {
    @State var languageSettings = Language()
    @StateObject var authState = AuthState()
    
    var body: some Scene {
        
        WindowGroup {
            AppNavigation()
                .environment(languageSettings)
                .environment(\.locale, languageSettings.locale)
                .environmentObject(authState)
        }
    }
}


