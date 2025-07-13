//
//  ValidationErrorViewModifier.swift
//  MindWars
//
//  Created by Yiğit Tilki on 13.07.2025.
//

import SwiftUI

struct ValidationErrorViewModifier: ViewModifier {

    func body(content: Content) -> some View {
        content
            .foregroundColor(.errorRed)
            .font(AppFont.body2)
    }
}
