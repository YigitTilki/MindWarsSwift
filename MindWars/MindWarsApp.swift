//
//  MindWarsApp.swift
//  MindWars
//
//  Created by Yiğit Tilki on 18.12.2024.
//

import SwiftUI
import FirebaseCore


class AppDelegate: NSObject, UIApplicationDelegate {
  func application(_ application: UIApplication,
                   didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey : Any]? = nil) -> Bool {
    FirebaseApp.configure()

    return true
  }
}

@main
struct MindWarsApp: App {
    @UIApplicationDelegateAdaptor(AppDelegate.self) var delegate
    @State var languageSettings = Language()
    
    var body: some Scene {
        
        WindowGroup {
            AppNavigation()
                .environment(languageSettings)
                .environment(\.locale, languageSettings.locale)
                
        }
    }
}


