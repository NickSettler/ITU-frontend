//
//  ResizableTextBox.swift
//  ITU
//
//  Created by Elena Marochkina
//

import Foundation
import SwiftUI

struct TextEditorWithDynamicSize: View {
    @Binding var text: String
    @State private var contentHeight: CGFloat = .zero
    
    var body: some View {
        ZStack(alignment: .topLeading) {
            TextEditor(text: $text)
                .frame(minHeight: 10, maxHeight: .infinity)
                .background(
                    GeometryReader { proxy in
                        Color.clear.preference(
                            key: ViewHeightKey.self,
                            value: proxy.size.height
                        )
                    }
                )
                .onPreferenceChange(ViewHeightKey.self) {
                    contentHeight = max($0, 10) // Adjust the minimum height as needed
                }
                .frame(maxWidth: .infinity, maxHeight: .infinity)
                .overlay(
                    VStack {
                        if text.isEmpty {
                            Text("Enter folder description")
                                .padding(.vertical, 8)
                                .foregroundColor(Color.gray.opacity(0.6))
                                .multilineTextAlignment(.center)
                        }
                    }
                        .frame(maxWidth: .infinity, maxHeight: .infinity)
                )
        }
    }
}

struct ViewHeightKey: PreferenceKey {
    static var defaultValue: CGFloat { 10 }
    static func reduce(value: inout CGFloat, nextValue: () -> CGFloat) {
        value = max(value, nextValue())
    }
}
