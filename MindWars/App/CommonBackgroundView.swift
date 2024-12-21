//
//  CommonBackgroundView.swift
//  MindWars
//
//  Created by Yiğit Tilki on 21.12.2024.
//

import SwiftUI

struct CommonBackgroundView<Content: View>: View {
    let content: Content

    init(@ViewBuilder content: () -> Content) {
        self.content = content()
    }

    var body: some View {
        ZStack {
            AppBackground()
            Image(.appLogo)
                .resizable()
                .frame(width: 300, height: 300)
                .opacity(0.3)
            content
        }
    }
}


