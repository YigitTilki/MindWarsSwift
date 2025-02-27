//
//  InfoText.swift
//  MindWars
//
//  Created by Yiğit Tilki on 26.02.2025.
//

import SwiftUI

struct InfoText: View {
    
    let title: LocalizedStringKey
    var foregroundColor: Color?
    
    var body: some View {
        HStack() {
            Image(systemName: "info.circle")
            Text(title)
                .font(.footnote)
        }
        .foregroundStyle(foregroundColor ?? .gray)
        .padding(.vertical, 5)
    }
}

#Preview {
    InfoText(title: "Hello World")
}
