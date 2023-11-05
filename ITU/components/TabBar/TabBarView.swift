//
//  TabBarView.swift
//  ITU
//
//  Created by Nikita Moiseev on 05.11.2023.
//

import SwiftUI

struct TabBarView: View {
    @Binding var currentTab: String
    @Namespace var namespace
    
    var tabBarOptions: [String] = ["Hello World", "This is", "Something cool that I'm doing"]
    var body: some View {
        ScrollView(.horizontal, showsIndicators: false) {
            HStack(spacing: 20) {
                ForEach(tabs, id: \.self) { tab in
                    TabBarItem(
                        currentTab: self.$currentTab,
                        namespace: namespace.self,
                        tabBarItemName: tab,
                        tab: tab
                    )
                    
                }
            }
            .padding(.horizontal)
        }
        .background(Color.white)
        .frame(height: 48)
    }
}

#Preview {
    TabBarView(currentTab: .constant(tabs[0]))
}
