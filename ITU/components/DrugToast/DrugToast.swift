//
//  DrugToast.swift
//  ITU
//
//  Created by Никита Моисеев on 25.11.2023.
//

import SwiftUI
import SheeKit
import UniformTypeIdentifiers

enum DrugToastRole : String {
    case success
    case warning
    case error
    case info
    
    var color: [Color] {
        get {
            switch (self) {
            case .error:
                return [.Quaternary200, .Quaternary400, .Quaternary500, .Quaternary600]
            case .warning:
                return [.Secondary50, .Secondary200, .Secondary300, .Secondary400]
            case .success:
                return [.Primary50, .Primary200, .Primary300, .Primary600]
            case .info:
                return [.Tertiary100, .Tertiary300, .Tertiary400, .Tertiary500]
            }
        }
    }
}

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

struct DrugToast: View {
    @StateObject var viewModel = DrugToastModel()
    
    let role: DrugToastRole
    
    var title: String
    var text: String
    var hintTitle: String? = nil
    var hintText: String? = nil
    
    let color: [Color]
    
    init(
        role: DrugToastRole,
        title: String,
        text: String
    ) {
        self.role = role
        self.color = role.color
        self.title = title
        self.text = text
    }
    
    init(
        role: DrugToastRole,
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
        ZStack {
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
        .foregroundColor(self.color[3])
        .padding(.horizontal, 12)
        .padding(.vertical, 8)
        .frame(maxWidth: .infinity)
        .background {
            RoundedRectangle(cornerRadius: 12)
                .fill(self.color[1].opacity(0.36))
                .stroke(
                    LinearGradient(
                        colors: [self.color[2], self.color[1]],
                        startPoint: .topLeading,
                        endPoint: .bottomTrailing
                    )
                    .opacity(0.48),
                    lineWidth: 1
                )
        }
        .contentShape(
            .contextMenuPreview,
            RoundedRectangle(cornerRadius: 12)
                .inset(by: -0.5)
        )
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
                        viewModel.isHintVisible = true
                    }
                }
                .shee(isPresented: $viewModel.isHintVisible,
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
                    hintSheet
                }
        }
    }
    
    var hintSheet: some View {
        VStack(alignment: .center, spacing: 12) {
            Text(self.hintTitle ?? "")
                .font(.helvetica22)
                .fontWeight(/*@START_MENU_TOKEN@*/.bold/*@END_MENU_TOKEN@*/)
                .kerning(3.3)
                .tracking(1.15)
            
            Text(self.hintText ?? "")
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
    var hintTitle = "Route"
    var hintText = "Route means a way how the medicine should be delivered into the organism. For example, oral route mostly means that you should swallow the medicine."
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
