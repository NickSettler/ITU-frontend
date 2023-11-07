//
//  TabBarView.swift
//  ITU
//
//  Created by Nikita Moiseev on 05.11.2023.
//

import SwiftUI

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
        .frame(height: 48)
        .background(Color.white)
        .shadow(
            color: Color.textColorPrimary.opacity(0.1),
            radius: 10,
            x: 0,
            y: 4
        )
        .mask(
            Rectangle()
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
