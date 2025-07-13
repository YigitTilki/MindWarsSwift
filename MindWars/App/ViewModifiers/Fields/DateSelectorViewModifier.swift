//
//  DateSelectorViewModifier.swift
//  MindWars
//
//  Created by Yiğit Tilki on 13.07.2025.
//

import SwiftUI

struct DateSelectorViewModifier: ViewModifier {
    var keyboardType: UIKeyboardType = .default

    func body(content: Content) -> some View {
        content
            .padding(.vertical, 8)
            .padding(.horizontal, 15)
            .font(.system(size: 14, weight: .light))
            .background(.white)
            .foregroundStyle(.mainGrey)
            .overlay(
                RoundedRectangle(cornerRadius: 5)
                    .stroke(Color.mainGrey, lineWidth: 1)
            )
            .autocapitalization(.none)
            .autocorrectionDisabled()
            .keyboardType(keyboardType)
    }
}
