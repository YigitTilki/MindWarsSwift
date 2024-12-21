//
//  AppColors.swift
//  MindWars
//
//  Created by Yiğit Tilki on 18.12.2024.
//

import SwiftUI

extension Color {
    static let primaryColor = Color(red: 0.2, green: 0.6, blue: 0.8)
   public static let primaryTextColor = Color(hex: "#525252")
}

extension Color {
    init(hex: String) {
        let hex = hex.trimmingCharacters(in: .whitespacesAndNewlines)
        let scanner = Scanner(string: hex)
        if hex.hasPrefix("#") {
            scanner.currentIndex = hex.index(after: hex.startIndex)
        }
        var rgb: UInt64 = 0
        scanner.scanHexInt64(&rgb)
        let red = Double((rgb >> 16) & 0xFF) / 255.0
        let green = Double((rgb >> 8) & 0xFF) / 255.0
        let blue = Double(rgb & 0xFF) / 255.0
        self.init(red: red, green: green, blue: blue)
    }
}
