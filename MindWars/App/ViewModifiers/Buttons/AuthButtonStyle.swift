//
//  AuthButtonViewModifier.swift
//  MindWars
//
//  Created by Yiğit Tilki on 13.07.2025.
//

import SwiftUI

struct AuthButtonStyle: ButtonStyle {
    var backgroundColor: Color = .clickBlue
    var foregroundColor: Color = .white
    var cornerRadius: CGFloat = 5
    var font: Font = AppFont.button
    var isDisabled: Bool = false

    func makeBody(configuration: Configuration) -> some View {
        configuration.label
            .font(font)
            .foregroundColor(foregroundColor)
            .padding(.vertical, 10)
            .padding(.horizontal, 24)
            .background(isDisabled ? Color.lightGrey : backgroundColor)
            .cornerRadius(cornerRadius)
            .opacity(configuration.isPressed ? 0.7 : 1.0)
            .contentShape(Rectangle())
    }
}
