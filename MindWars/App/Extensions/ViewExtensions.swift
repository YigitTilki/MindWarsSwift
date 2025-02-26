//
//  WievExtensions.swift
//  MindWars
//
//  Created by Yiğit Tilki on 20.12.2024.
//

import SwiftUI

extension View {
   
    func loginButtonStyle(isEmpty: Bool) -> some View {
        self
            .frame(maxWidth: 100, maxHeight: 40)
            .foregroundColor(.white)
            .background(isEmpty ? .gray : .red)
            .cornerRadius(5)
        
    }
    
    
    func buttonTextStyle() -> some View {
        self
            .font(.subheadline)
            .foregroundColor(.white)
            .padding(5)
            
    }
    
    
    func languageSelectionDialog(isPresented: Binding<Bool>, languageManager: Language) -> some View {
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
