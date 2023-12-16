//
//  TabBarItem.swift
//  ITU
//
//  Created by Elena Marochkina
//

import SwiftUI

/// `TabBarItem` is a structure to render a tab bar item for the custom tab bar.
struct TabBarItem: View {
    // The currently selected folder tab
    @Binding var currentFolder: Folder
    // The color of the tab
    var tabColor: Color?

    // The matched geometry effect namespace
    let namespace: Namespace.ID

    // The folder that this tab represents
    var folder: Folder

    /// Body of `TabBarItem`.
    var body: some View {
        Button {
            withAnimation(.spring(response: 0.2, dampingFraction: 0.4, blendDuration: 0.3)) {
                self.currentFolder = folder
            }
        } label: {
            VStack(spacing: 0) {
                HStack(spacing: 0){
                    Image(systemName: folder.icon ?? "folder")
                        .font(.system(size: 14))
                    
                    Text(folder.name)
                        .padding(.horizontal, 2)
                        .frame(
                            maxWidth: .infinity,
                            minHeight: 44,
                            maxHeight: 44,
                            alignment: .center
                        )
                        .font(.callout)
                        .fontWeight(.medium)
                }
                .padding(.horizontal, 10)
                
                if currentFolder == folder {
                    (tabColor != Color.textColorSecondary 
                     ? tabColor
                     : Color.Primary300)
                        .frame(height: 2)
                        .matchedGeometryEffect(
                            id: "underline",
                            in: namespace,
                            properties: .frame
                        )
                } else {
                    Color.clear.frame(height: 2)
                }
            }
            .contentShape(Rectangle())
            .animation(
                .spring(.smooth, blendDuration: 0.15),
                value: self.currentFolder
            )
        }
        .buttonStyle(.plain)
        .foregroundColor(
            currentFolder == folder 
            ? (tabColor != Color.textColorSecondary
               ? tabColor
               : Color.Primary300)
            : tabColor
        )
    }
}

// Usage of `TabBarItem` in a custom `TabBarView`.
#Preview {
    TabBarView(
        currentFolder: .constant(.allFolder),
        folders: .constant([.allFolder])
    )
}
