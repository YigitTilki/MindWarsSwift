//
//  ImageExtensions.swift
//  MindWars
//
//  Created by Yiğit Tilki on 14.07.2025.
//

import SwiftUI

extension Image {
    func fillScreen() -> some View {
        self
            .resizable()
            .scaledToFill()
            .frame(maxWidth: .infinity, maxHeight: .infinity)
            .ignoresSafeArea()
    }
}
