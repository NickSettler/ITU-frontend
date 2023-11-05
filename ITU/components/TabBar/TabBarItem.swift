//
//  TabBarItem.swift
//  ITU
//
//  Created by Никита Моисеев on 05.11.2023.
//

import SwiftUI

struct TabBarItem: View {
    @Binding var currentTab: String
    let namespace: Namespace.ID
    
    var tabBarItemName: String
    var tab: String
    
    var body: some View {
        Button {
            withAnimation(.spring(response: 0.2, dampingFraction: 0.4, blendDuration: 0.3)) {
                self.currentTab = tab
            }
        } label: {
            VStack {
                Spacer()
                Text(tabBarItemName)
                if currentTab == tab {
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
            .animation(.spring(.smooth, blendDuration: 0.15), value: self.currentTab)
        }
        .buttonStyle(.plain)
        .fontWeight(.bold)
        .foregroundColor(
            currentTab == tab
            ? Color.colorPrimaryLight
            : Color.textColorSecondary
        )
    }
}

#Preview {
    @Namespace var namespace
    
    return TabBarItem(
        currentTab: .constant("ALL"),
        namespace: namespace.self,
        tabBarItemName: "All",
        tab: "ALL"
    )
}
