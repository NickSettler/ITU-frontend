//
//  RoleGroup.swift
//  ITU
//
//  Created by Nikita Moiseev
//

import SwiftUI

/// Enumeration to represent different types of alerts, conforming to both `Int` and `Codable`.
enum E_ROLE_GROUP : Int, Codable {
    // Cases
    case success = 0
    case warning = 1
    case error = 2
    case info = -1

    // Computed property to get a color theme based on the role group.
    var color: [Color] {
        get {
            switch (self) {
            case .error:
                return [.Quaternary200, .Quaternary300, .Quaternary400, .Quaternary500, .Quaternary600]
            case .warning:
                return [.Secondary50, .Secondary100, .Secondary200, .Secondary300, .Secondary400]
            case .success:
                return [.Primary50, .Primary200, .Primary200, .Primary300, .Primary600]
            case .info:
                return [.Tertiary100, .Tertiary200, .Tertiary300, .Tertiary400, .Tertiary500]
            }
        }
    }
}

/// Enumeration to define different forms of RoleGroup
enum E_ROLE_GROUP_FORM {
    case chip
    case rounded
}

/// A customizable SwiftUI view component that wraps some content and adjusts its appearance based on the alert type and form.
struct RoleGroup<Content : View>: View {

    // Various properties to decide style and content to display
    var form: E_ROLE_GROUP_FORM
    var role: E_ROLE_GROUP
    var content: Content
    
    let paddindX: CGFloat
    let paddindY: CGFloat
    
    let color: [Color]

    /// Init role group with content
    /// - Parameter content: content
    init(
        @ViewBuilder content: () -> Content
    ) {
        self.init(role: .info, form: .rounded, content: content)
    }

    /// Init role group with role and content
    /// - Parameters:
    ///   - role: role
    ///   - content: content
    init(
        role: E_ROLE_GROUP,
        @ViewBuilder content: () -> Content
    ) {
        self.init(role: role, form: .rounded, content: content)
    }

    /// Init role group with form and content
    /// - Parameters:
    ///   - form: form
    ///   - content: content
    init(
        form: E_ROLE_GROUP_FORM,
        @ViewBuilder content: () -> Content
    ) {
        self.init(role: .info, form: form, content: content)
    }

    /// Init role group with role, form and content
    /// - Parameters:
    ///   - role: role
    ///   - form: form
    init(
        role: E_ROLE_GROUP,
        form: E_ROLE_GROUP_FORM,
        @ViewBuilder content: () -> Content
    ) {
        self.role = role
        self.color = role.color
        self.form = form
        
        self.paddindX = form == .chip ? 8 : 12
        self.paddindY = form == .chip ? 4 : 8
        
        self.content = content()
    }

    /// Body of RoleGroup. Generates a view based on the values and content provided
    var body: some View {
        ZStack {
            content
        }
        .foregroundColor(self.color[4])
        .padding(.horizontal, paddindX)
        .padding(.vertical, paddindY)
        .if(form == .rounded) {
            $0.frame(maxWidth: .infinity)
        }
        .if(form == .chip) {
            $0.font(.mono)
        }
        .background {
            if (form == .chip) {
                chipBackground
            } else {
                roundedBackground
            }
        }
        .contentShape(
            .contextMenuPreview,
            RoundedRectangle(
                cornerRadius: self.form == .chip ? 10000 : 12
            ).inset(by: -0.5)
        )
    }

    // Computed properties to represent different background styles for role group
    var chipBackground: some View {
        RoundedRectangle(
            cornerRadius: 10000
        )
        .fill(self.color[1])
        .stroke(self.role != .success ? self.color[3] : .clear)
    }
    
    var roundedBackground: some View {
        RoundedRectangle(
            cornerRadius: 12
        )
        .fill(self.color[2].opacity(0.36))
        .stroke(
            LinearGradient(
                colors: [self.color[3], self.color[2]],
                startPoint: .topLeading,
                endPoint: .bottomTrailing
            )
            .opacity(0.48),
            lineWidth: 1
        )
    }
}

// Previews of the RoleGroup with different settings.
#Preview {
    VStack {
        VStack {
            RoleGroup(role: .info) {
                Text("HIIII!")
            }
            RoleGroup(role: .success) {
                Text("HIIII!")
            }
            RoleGroup(role: .warning) {
                Text("HIIII!")
            }
            RoleGroup(role: .error) {
                Text("HIIII!")
            }
        }
        .padding(.horizontal)
        
        ScrollView(.horizontal, showsIndicators: false) {
            HStack {
                RoleGroup(role: .error, form: .chip) {
                    Text("EXPIRED")
                }
                
                RoleGroup(role: .warning, form: .chip) {
                    Text("NEEDS PRESCRIPTION")
                }
                
                RoleGroup(role: .success, form: .chip) {
                    Text("400 MG")
                }
                
                RoleGroup(role: .success, form: .chip) {
                    Text("Tablets")
                }
            }
            .padding()
        }
    }
}
