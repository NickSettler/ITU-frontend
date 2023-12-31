//
//  DrugToast.swift
//  ITU
//
//  Created by Nikita Moiseev
//

import SwiftUI
import SheeKit
import UniformTypeIdentifiers

/// Bounds preference key struct
struct BoundsPreferenceKey: PreferenceKey {
    typealias Value = Anchor<CGRect>?
    
    static var defaultValue: Value = nil
    
    static func reduce(
        value: inout Value,
        nextValue: () -> Value
    ) {
        value = nextValue()
    }
}

/// A SwiftUI view component that displays brief information and allows for a context menu and hint overlay.
struct DrugToast: View {
    // State controlling the visibility of the hint
    @State var isHintVisible: Bool = false

    // Properties defining the role, color, title, text and hint of the Toast
    let role: E_ROLE_GROUP

    var title: String
    var text: String
    var hintTitle: String? = nil
    var hintText: String? = nil
    
    let color: [Color]

    /// Init drug toast with role, title and text
    init(
        role: E_ROLE_GROUP,
        title: String,
        text: String
    ) {
        self.role = role
        self.color = role.color
        self.title = title
        self.text = text
    }

    /// Init drug toast with role, title, text, hint title and hint text
    init(
        role: E_ROLE_GROUP,
        title: String,
        text: String,
        hintTitle: String,
        hintText: String
    ) {
        self.role = role
        self.color = role.color
        self.title = title
        self.text = text
        self.hintTitle = hintTitle
        self.hintText = hintText
    }
    
    var body: some View {
        RoleGroup(role: role) {
            HStack(alignment: .top, spacing: 0) {
                VStack(alignment: .leading, spacing: 2) {
                    Text(title)
                        .font(.system(size: 14, weight: .bold))
                    
                    Text(text)
                        .font(.mono)
                }
                .textCase(.uppercase)
                
                Spacer()
                
                if (self.hintText != nil) {
                    Image(systemName: "questionmark.circle")
                        .font(.system(size: 20))
                }
            }
        }
        .contextMenu {
            Button {
                UIPasteboard.general.setValue(
                    "\(title): \(text)",
                    forPasteboardType: UTType.plainText.identifier
                )
            } label: {
                HStack {
                    Image(systemName: "doc.on.doc")
                    
                    Text("Copy")
                }
            }
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

// Previews of the DrugToast with different settings.
#Preview {
    let hintTitle = "Route"
    let hintText = "Route means a way how the medicine should be delivered into the organism. For example, oral route mostly means that you should swallow the medicine."
    return VStack {
        DrugToast(
            role: .success,
            title: "Route",
            text: "Oral",
            hintTitle: hintTitle,
            hintText: hintText
        )
        DrugToast(
            role: .warning,
            title: "Route",
            text: "Oral",
            hintTitle: hintTitle,
            hintText: hintText
        )
        DrugToast(
            role: .error,
            title: "Strength",
            text: "100MG",
            hintTitle: hintTitle,
            hintText: hintText
        )
        DrugToast(
            role: .info,
            title: "Route",
            text: "Oral"
        )
    }
    .padding()
}
