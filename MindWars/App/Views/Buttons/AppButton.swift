//
//  AppButton.swift
//  MindWars
//
//  Created by Yiğit Tilki on 17.04.2025.
//

import SwiftUI

struct AppButton: View {
    let title: String
    var backgroundColor: Color?
    var foregroundColor: Color?
    let action: () -> Void

    var body: some View {
        Button(action: action) {
            Text(title)
                .padding(10)
                .background(backgroundColor ?? .blue)
                .foregroundColor(foregroundColor ?? .white)
                .cornerRadius(5)
        }
    }
}

#Preview {
    AppButton(title: "Hello World", action: {})
}
