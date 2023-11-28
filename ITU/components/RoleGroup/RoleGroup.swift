//
//  RoleGroup.swift
//  ITU
//
//  Created by Никита Моисеев on 28.11.2023.
//

import SwiftUI

enum E_ROLE_GROUP : Int, Codable {
    case success = 0
    case warning = 1
    case error = 2
    case info = -1
    
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

enum E_ROLE_GROUP_FORM {
    case chip
    case rounded
}

struct RoleGroup<Content : View>: View {
    var form: E_ROLE_GROUP_FORM
    var role: E_ROLE_GROUP
    var content: Content
    
    let paddindX: CGFloat
    let paddindY: CGFloat
    
    let color: [Color]
    
    init(
        @ViewBuilder content: () -> Content
    ) {
        self.init(role: .info, form: .rounded, content: content)
    }
    
    init(
        role: E_ROLE_GROUP,
        @ViewBuilder content: () -> Content
    ) {
        self.init(role: role, form: .rounded, content: content)
    }
    
    init(
        form: E_ROLE_GROUP_FORM,
        @ViewBuilder content: () -> Content
    ) {
        self.init(role: .info, form: form, content: content)
    }
    
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
