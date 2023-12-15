//
//  DrugChip.swift
//  ITU
//
//  Created by Nikita Moiseev
//

import SwiftUI

struct DrugChip: View {
    @State var isHintVisible: Bool = false
    
    let role: E_ROLE_GROUP
    let text: String
    let hintTitle: String?
    let hintText: String?
    
    let color: [Color]
    
    init(text: String) {
        self.init(role: .success, text: text)
    }
    
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
