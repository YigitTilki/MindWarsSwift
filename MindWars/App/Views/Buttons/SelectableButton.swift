//
//  SelectableButton.swift
//  MindWars
//
//  Created by Yiğit Tilki on 26.02.2025.
//

import SwiftUI

struct SelectableButton: View {
    let title: LocalizedStringKey
    let isSelected: Bool
    var selectedColor: Color?
    var defaultColor: Color?
    var foregroundColor: Color?
    let action: () -> Void
    var body: some View {
        Button(action: action) {
            Text(title)
                .font(.title3)
                .fontWeight(.medium)
                .frame(maxWidth: .infinity, maxHeight: .infinity)
                .background(isSelected ? selectedColor ?? .blue.opacity(0.8) : defaultColor ?? .gray.opacity(0.8))
                .foregroundStyle(foregroundColor ?? .white)
                .cornerRadius(10)
        }
        .frame(maxHeight: 50)
    }
}

#Preview {
    SelectableButton(title: "Hello", isSelected: true, action: {})
}
