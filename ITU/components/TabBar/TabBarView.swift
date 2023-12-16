//
//  TabBarView.swift
//  ITU
//
//  Created by Elena Marochkina
//

import SwiftUI

/// `TabBarView` is a customizable SwiftUI view component that represents a horizontal scrollable custom tab bar.
struct TabBarView: View {
    // The currently selected folder tab.
    @Binding var currentFolder: Folder
    // The array of "Folder"s which will comprise the tabs in the tab bar.
    @Binding var folders: [Folder]
    // A dictionary mapping the folder id to respective colors.
    var folderColors: Dictionary<String, Color>?
    // A namespace for transitions.
    @Namespace var namespace

    /// Body of `TabBarView`.
    var body: some View {
        HStack {
            ScrollView(.horizontal, showsIndicators: false) {
                HStack(spacing: 0) {
                    ForEach(self.folders, id: \.id) { folder in
                        TabBarItem(
                            currentFolder: self.$currentFolder,
                            tabColor: folderColors?[folder.id], namespace: namespace.self,
                            folder: folder
                        )
                    }
                }
                .padding(.horizontal)
            }
            .background(Color.white)
        }
        .background(Color.white)
        .frame(height: 48)
        .shadow(
            color: Color.textColorPrimary.opacity(0.15),
            radius: 12,
            x: 0,
            y: 4
        )
        .mask(
            Rectangle()
                .padding(.top, 1)
                .padding(.bottom, -64)
        )
    }
}

// a preview of a `TabBarView` with a single "All" folder tab.
#Preview {
    TabBarView(
        currentFolder: .constant(.allFolder),
        folders: .constant([.allFolder])
    )
}
