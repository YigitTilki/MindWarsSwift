//
//  WidthButton.swift
//  MindWars
//
//  Created by Yiğit Tilki on 26.02.2025.
//

import SwiftUI

struct WidthButton: View {
    let title: LocalizedStringKey
    var backgroundColor: Color?
    var foregroundColor: Color?
    let action: () -> Void

    var body: some View {
        Button(action: action) {
            Text(title)
                .frame(maxWidth: .infinity)
                .padding()
                .background(backgroundColor ?? .blue)
                .foregroundColor(foregroundColor ?? .white)
                .cornerRadius(8)
        }
    }
}

#Preview {
    WidthButton(title: "Hello World", action: {})
}
