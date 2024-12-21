//
//  WievExtensions.swift
//  MindWars
//
//  Created by Yiğit Tilki on 20.12.2024.
//

import SwiftUI

extension View {
    func appTextFieldStyle() -> some View {
        self
            .padding(15)
            .cornerRadius(5)
            .font(.subheadline)
            .overlay(
                RoundedRectangle(cornerRadius: 5)
                    .stroke(Color.gray, lineWidth: 1)
            )
            
    }
    func loginButtonStyle() -> some View {
        self
            .padding(10)
            .padding(.horizontal)
            .background(Color.red)
            .foregroundColor(.white)
            .font(.subheadline)
            .cornerRadius(5)
            .shadow(color: Color.black.opacity(0.2), radius: 5, x: 0, y: 2)
            .overlay(
                RoundedRectangle(cornerRadius: 5)
                    .stroke(.red, lineWidth: 1)
            )
            .padding(.vertical, 5)
    }
    func languageSelectionDialog(isPresented: Binding<Bool>, languageManager: LanguageManager) -> some View {
           self
            .confirmationDialog(
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
    func appBarBackButton(text: LocalizedStringKey, action: @escaping () -> Void) -> some View {
        self
            .toolbar(content: {
                ToolbarItem(placement: .topBarLeading, content: {
                    Button(action: action, label: {
                        HStack {
                               Image(systemName: "chevron.left")
                                Text(text)
                           }
                    })
                })
            })
    }
}
