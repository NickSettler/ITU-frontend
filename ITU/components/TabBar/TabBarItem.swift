//
//  TabBarItem.swift
//  ITU
//
//  Created by Nikita Moiseev on 05.11.2023.
//

import SwiftUI

struct TabBarItem: View {
    @Binding var currentFolder: Folder
    let namespace: Namespace.ID
    
    var folder: Folder
    
    var body: some View {
        Button {
            withAnimation(.spring(response: 0.2, dampingFraction: 0.4, blendDuration: 0.3)) {
                self.currentFolder = folder
            }
        } label: {
            VStack(spacing: 0) {
                Text(folder.name)
                    .padding(.horizontal, 12)
                    .frame(
                        maxWidth: .infinity,
                        minHeight: 44,
                        maxHeight: 44,
                        alignment: .center
                    )
                    .font(.callout)
                    .fontWeight(.medium)
                
                if currentFolder == folder {
                    Color.colorPrimaryLight
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
            ? Color.colorPrimaryLight
            : Color.textColorSecondary
        )
    }
}

#Preview {
    TabBarView(
        currentFolder: .constant(.allFolder),
        folders: .constant([.allFolder])
    )
}
