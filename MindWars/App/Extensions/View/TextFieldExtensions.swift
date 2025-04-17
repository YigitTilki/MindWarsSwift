//
//  TextFieldExtensions.swift
//  MindWars
//
//  Created by Yiğit Tilki on 26.02.2025.
//

import SwiftUI

extension TextField {
    func appTextField() -> some View {
        self
            .padding(15)
            .cornerRadius(5)
            .font(.subheadline)
            .background(.white)
            .overlay(
                RoundedRectangle(cornerRadius: 5)
                    .stroke(Color.gray, lineWidth: 1)
            )
            .autocapitalization(.none)
            .autocorrectionDisabled()
    }
}
