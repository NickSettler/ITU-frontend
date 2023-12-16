//
//  DrugChip.swift
//  ITU
//
//  Created by Nikita Moiseev
//

import SwiftUI

/// A SwiftUI view component that displays a chipped form of a drug with a hint.
struct DrugChip: View {
    // State controlling the visibility of the hint
    @State var isHintVisible: Bool = false

    // Properties defining the look and content of the chip
    let role: E_ROLE_GROUP
    let text: String
    let hintTitle: String?
    let hintText: String?
    
    let color: [Color]

    // Multiple initializers for the component

    /// Init drug chip with text
    init(text: String) {
        self.init(role: .success, text: text)
    }

    /// Init drug chip with text, hint title and hint text
    init(text: String,
         hintTitle: String,
         hintText: String
    ) {
        self.init(
            role: .success,
            text: text,
            hintTitle: hintTitle,
            hintText: hintText
        )
    }

    /// Init drug chip with role and text
    init(
        role: E_ROLE_GROUP,
        text: String
    ) {
        self.init(
            role: role,
            text: text,
            hintTitle: nil,
            hintText: nil
        )
    }

    /// Init drug chip with role, text, hint title and hint text
    init(
        role: E_ROLE_GROUP,
        text: String,
        hintTitle: String?,
        hintText: String?
    ) {
        self.role = role
        self.color = role.color
        self.text = text
        self.hintTitle = hintTitle
        self.hintText = hintText
    }
    
    var body: some View {
        RoleGroup(role: role, form: .chip) {
            Text(text)
                .textCase(.uppercase)
        }
        .if(self.hintTitle != nil) {
            $0
                .onTapGesture {
                    withAnimation(.spring(response: 0.45, dampingFraction: 0.2, blendDuration: 0.35)) {
                        isHintVisible = true
                    }
                }
                .shee(isPresented: $isHintVisible,
                      presentationStyle:
                        .popover(
                            permittedArrowDirections: .up,
                            sourceRectTransform: { $0.offsetBy(dx: 16, dy: 16) },
                            adaptiveSheetProperties: .init(
                                prefersGrabberVisible: true,
                                preferredCornerRadius: 44,
                                detents: [ .medium() ],
                                animatesSelectedDetentIdentifierChange: true
                            )
                        )
                ) {
                    DrugHint(
                        color: color,
                        title: hintTitle ?? "",
                        text: hintText ?? ""
                    )
                }
        }
    }
}

// Previews of the DrugChip with different settings.
#Preview {
    ScrollView(.horizontal, showsIndicators: false) {
        HStack {
            DrugChip(text: "Hello")
            DrugChip(role: .warning, text: "WRONG")
            DrugChip(role: .error, text: "ERROR", hintTitle: "ERROR", hintText: "ERRRRRRRRR")
        }
        .padding()
    }
}
