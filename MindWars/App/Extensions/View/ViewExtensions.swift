//
//  ViewExtensions.swift
//  MindWars
//
//  Created by Yiğit Tilki on 20.12.2024.
//

import SwiftUI

extension View {
    func languageSelectionDialog(isPresented: Binding<Bool>, languageManager: Language) -> some View {
        confirmationDialog(
            "Select Language",
            isPresented: isPresented,
            titleVisibility: .visible
        ) {
            Button("Turkish") {
                languageManager.locale = Locale(identifier: "tr-TR")
            }
            Button("English") {
                languageManager.locale = Locale(identifier: "en-US")
            }
            Button("Close", role: .cancel) {}
        }
    }
}
