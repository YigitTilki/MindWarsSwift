//
//  Toast.swift
//  MindWars
//
//  Created by Yiğit Tilki on 15.07.2025.
//

import SwiftUI

struct ToastView: View {

    var style: ToastStyle
    var message: String
    var width = CGFloat.infinity
    var onCancelTapped: (() -> Void)

    var body: some View {
        HStack(alignment: .center, spacing: 12) {
            Image(systemName: style.iconFileName)
                .foregroundColor(style.themeColor)
            Text(message)
                .font(AppFont.body2)
                .foregroundColor(.errorRed)

            Spacer(minLength: 10)

            Button {
                onCancelTapped()
            } label: {
                Image(systemName: "xmark")
                    .foregroundColor(style.themeColor)
            }
        }
        .padding()
        .frame(minWidth: 0, maxWidth: width)
        .background(.white.opacity(0.9))
        .overlay(
            RoundedRectangle(cornerRadius: 10)
                .stroke(style.themeColor, lineWidth: 1)
        )
        .cornerRadius(10)
        .padding(.horizontal, 16)
    }
}



extension View {
    func toastView(toast: Binding<Toast?>) -> some View {
        self.modifier(ToastModifier(toast: toast))
    }
}
