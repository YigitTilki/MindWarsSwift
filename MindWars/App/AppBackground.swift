//
//  AppBackground.swift
//  MindWars
//
//  Created by Yiğit Tilki on 21.12.2024.
//

import SwiftUI

struct AppBackground: View {
    var body: some View {
        Image(.appBackground)
            .resizable()
            .scaledToFill()
            .frame(maxWidth: .infinity, maxHeight: .infinity)
            .ignoresSafeArea()
    }
}

#Preview {
    AppBackground()
}
