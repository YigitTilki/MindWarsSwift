//
//  QuestionButton.swift
//  MindWars
//
//  Created by Yiğit Tilki on 26.02.2025.
//

import SwiftUI

struct QuestionSelectButton: View {
    let prefix: String
    let title: String
    let isSelected: Bool
    var selectedColor: Color?
    var defaultColor: Color?
    var foregroundColor: Color?
    let action: () -> Void
    var body: some View {
        Button(action: action) {
            HStack(spacing: 0) {
                Text(prefix)
                    .font(.callout)
                    .fontWeight(.bold)
                    .padding(.trailing, 5)
                Text(title)
                    .font(.callout)
                    .fontWeight(.medium)
            }
            .frame(maxWidth: .infinity, minHeight: 50, alignment: .leading)
            .padding(.horizontal, 15)
            .background(isSelected ? selectedColor ?? .blue.opacity(0.8) : defaultColor ?? .gray.opacity(0.8))
            .foregroundStyle(foregroundColor ?? .white)
            .cornerRadius(8)
        }
        .frame(maxWidth: .infinity, maxHeight: 55)
    }
}

#Preview {
    QuestionSelectButton(prefix: "A-", title: "Hello World",isSelected: true,action: {})
}
