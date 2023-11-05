//
//  GradientButton.swift
//  ITU
//
//  Created by Elena Marochkina on 22.10.2023.
//

import SwiftUI

struct GradientButton: View {
    var title: String
    var icon: String?
    var fullWidth: Bool = false
    var onClick: () -> ()
    
    var body: some View {
        Button(action: onClick, label: {
            HStack(spacing: 15) {
                Text(title)
                
                if let icon = self.icon {
                    Image(systemName: icon)
                }
            }
            .if(fullWidth) {
                $0.frame(maxWidth: .infinity)
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
    VStack {
        GradientButton(title: "Login", icon: "arrow.right") {
            // Nothing
        }
        GradientButton(title: "Continue") {
            // Nothing
        }
        GradientButton(title: "Continue", fullWidth: true) {
            // Nothing
        }
    }
    .padding()
}
