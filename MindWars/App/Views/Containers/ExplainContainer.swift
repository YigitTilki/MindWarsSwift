//
//  ExplainContainer.swift
//  MindWars
//
//  Created by Yiğit Tilki on 26.02.2025.
//

import SwiftUI

struct ExplainContainer: View {
    
    let title: String?
    let description: String?
    let backgroundColor: Color
    var foregroundColor: Color?
    
    var body: some View {
        VStack {
            Text(title ?? "")
                .padding(.vertical, 5)
                .font(.title2)
                .fontWeight(.semibold)
            Text(description ?? "")
                .padding(.all, 5)
                .multilineTextAlignment(.center)
                .fontWeight(.medium)
        }
        .frame(maxWidth: .infinity, minHeight: 150)
        .padding()
        .background(
            LinearGradient(gradient: Gradient(colors: [backgroundColor, backgroundColor.opacity(0.5)]),
                           startPoint: .center,
                           endPoint: .bottom)
        )
        .foregroundColor(foregroundColor ?? .white)
        .border(.gray.opacity(0.3), width: 3)
        .cornerRadius(15)
        .padding(.top, 50)
       
    
    }
}

#Preview {
    ExplainContainer(title: "Hello", description: "World",backgroundColor: .yellow)
}
