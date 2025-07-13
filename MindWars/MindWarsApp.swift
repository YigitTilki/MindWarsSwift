//
//  MindWarsApp.swift
//  MindWars
//
//  Created by Yiğit Tilki on 18.12.2024.
//

import FirebaseCore
import SwiftUI

class AppDelegate: NSObject, UIApplicationDelegate {
    func application(_: UIApplication,
                     didFinishLaunchingWithOptions _: [UIApplication.LaunchOptionsKey: Any]? = nil) -> Bool
    {
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
            OnBoardingView()
//            SplashView()
//                .environment(languageSettings)
//                .environment(\.locale, languageSettings.locale)
        }
    }
}
