//
//  GradientButton.swift
//  ITU
//
//  Created by Elena Marochkina
//

import SwiftUI

/// `GradientButton` is a SwiftUI custom view component that represents a button with a gradient background.
struct GradientButton: View {
    // The title of the button.
    var title: String
    // The SystemName of SF icon to display.
    var icon: String?
    // If `true`, the button will have the maximum width.
    var fullWidth: Bool = false
    // If `true`, disables the button.
    var disabled: Bool = false
    // The closure that is triggered when the button is clicked.
    var onClick: () -> ()
    
    /// Body of `GradientButton`.
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

// A variety of `GradientButton`s.
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
