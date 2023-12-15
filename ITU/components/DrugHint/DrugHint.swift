//
//  DrugHint.swift
//  ITU
//
//  Created by Nikita Moiseev
//

import SwiftUI

/// Drug hint component
struct DrugHint: View {
    let color: [Color]
    let title: String
    let text: String

    /// Init drug hint with color, title and text
    init(color: [Color], title: String, text: String) {
        self.color = color
        self.title = title
        self.text = text
    }
    
    var body: some View {
        VStack(alignment: .center, spacing: 12) {
            Text(self.title)
                .font(.helvetica22)
                .fontWeight(/*@START_MENU_TOKEN@*/.bold/*@END_MENU_TOKEN@*/)
                .kerning(3.3)
                .tracking(1.15)
            
            Text(self.text)
                .font(.helvetica16)
                .kerning(1.76)
                .multilineTextAlignment(.center)
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .top)
        .padding(.top, 64)
        .padding(.horizontal, 24)
        .foregroundColor(self.color[0])
        .background(self.color[3])
        .ignoresSafeArea()
    }
}

#Preview {
    DrugHint(
        color: E_ROLE_GROUP.success.color,
        title: "Route",
        text: "Some text describing what route means in terms of drugs"
    )
}
