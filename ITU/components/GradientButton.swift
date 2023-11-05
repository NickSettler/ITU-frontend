//
//  GradientButton.swift
//  ITU
//
//  Created by Elena Marochkina on 22.10.2023.
//

import SwiftUI

struct GradientButton: View {
    var title: String
    var icon: String
    var onClick: () -> ()
    
    var body: some View {
        Button(action: onClick, label: {
            HStack(spacing: 15) {
                Text(title)
                Image(systemName: icon)
            }
            .fontWeight(.bold)
            .foregroundStyle(.white)
            .padding(.vertical, 12)
            .padding(.horizontal, 35)
            .background(
                .linearGradient(
                    colors: [.accentColor, .orange, .red],
                    startPoint: .top,
                    endPoint: .bottom
                ),
                in: .capsule
            )
        })
    }
}

#Preview {
    GradientButton(title: "Login", icon: "arrow.right") {
        // Nothing
    }
}
