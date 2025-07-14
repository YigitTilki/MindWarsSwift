//
//  TextFieldViewModifier.swift
//  MindWars
//
//  Created by Yiğit Tilki on 13.07.2025.
//

import SwiftUI

struct TextFieldViewModifier: ViewModifier {
    var keyboardType: UIKeyboardType = .default

    func body(content: Content) -> some View {
        content
            .padding(15)
            .font(AppFont.body2)
            .background(.white)
            .foregroundColor(.black)
            .overlay(
                RoundedRectangle(cornerRadius: 5)
                    .stroke(Color.mainGrey, lineWidth: 1)
            )
            .autocapitalization(.none)
            .autocorrectionDisabled()
            .keyboardType(keyboardType)
    }
}

