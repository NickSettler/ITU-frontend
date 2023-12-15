//
//  GradientButton.swift
//  ITU
//
//  Created by Elena Marochkina
//

import SwiftUI

struct GradientButton: View {
    var title: String
    var icon: String?
    var fullWidth: Bool = false
    var disabled: Bool = false
    var onClick: () -> ()
    
    var body: some View {
        Button(action: disabled ? {} : onClick, label: {
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
        .opacity(disabled ? 0.5 : 1)
        .disabled(self.disabled)
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
        GradientButton(title: "Continue", fullWidth: true, disabled: true) {
            // Nothing
        }
    }
    .padding()
}
