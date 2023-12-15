//
//  TabBarView.swift
//  ITU
//
//  Created by Elena Marochkina
//

import SwiftUI

/// Tab bar view component
struct TabBarView: View {
    @Binding var currentFolder: Folder
    @Binding var folders: [Folder]
    @Namespace var namespace

    var body: some View {
        HStack {
            ScrollView(.horizontal, showsIndicators: false) {
                HStack(spacing: 0) {
                    ForEach(self.folders, id: \.id) { folder in
                        TabBarItem(
                            currentFolder: self.$currentFolder,
                            namespace: namespace.self,
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

#Preview {
    TabBarView(
        currentFolder: .constant(.allFolder),
        folders: .constant([.allFolder])
    )
}
