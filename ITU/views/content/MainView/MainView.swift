//
//  MainView.swift
//  ITU
//
//  Created by Никита Моисеев on 26.10.2023.
//

import SwiftUI

struct MainView: View {
    @Namespace private var animation
    @AppStorage(E_AUTH_STORAGE_KEYS.ACCESS_TOKEN.rawValue) var access_token: String?
    
    @StateObject private var viewModel = MainViewModel()
    
    var body: some View {
        GeometryReader {
            let size = $0.size
            let safeArea = $0.safeAreaInsets
            VStack(spacing: 0) {
                TabView(selection: $viewModel.currentTab) {
                    ListView()
                        .tag(MenuTabModel.home)
                    
                    ListView()
                        .tag(MenuTabModel.settings)
                }
                .padding(.top, -20)
                .offset(y: 20)
                
                CustomTabBar()
                    .background(.clear)
            }
        }
    }
    
    @ViewBuilder
    func CustomTabBar(
        _ tint: Color = .accentColor,
        _ inactiveTint: Color = .accentColor
    ) -> some View {
        HStack(alignment: .bottom, spacing: 0) {
            ForEach(MenuTabModel.allCases, id: \.rawValue) {
                MenuTabItem(
                    tint: tint,
                    inactiveTint: inactiveTint,
                    tab: $0,
                    animation: animation,
                    activeTab: $viewModel.currentTab,
                    position: $viewModel.tabShapePosition
                )
            }
        }
        .padding(.horizontal, 16)
        .padding(.vertical, 10)
        .background {
            MenuTabShape(midpoint: viewModel.tabShapePosition.x)
                .fill(Color.BackgroundColor)
                .ignoresSafeArea()
                .shadow(
                    color: Color.ColorPrimary.opacity(0.2),
                    radius: 5,
                    x: 0,
                    y: -5
                )
                .blur(radius: 2)
                .padding(.top, 24)
        }
        .animation(
            .interactiveSpring(
                response: 0.6,
                dampingFraction: 0.7,
                blendDuration: 0.7
            ),
            value: viewModel.currentTab
        )
    }
}

struct MenuTabItem : View {
    var tint: Color
    var inactiveTint: Color
    var tab: MenuTabModel
    var animation: Namespace.ID
    
    @Binding var activeTab: MenuTabModel
    @Binding var position: CGPoint
    
    @State private var tabPosition: CGPoint = .zero
    
    var body: some View {
        VStack(spacing: 2) {
            Image(systemName: tab.systemImage)
                .font(.title2)
                .foregroundColor(activeTab == tab ? .TextColorPrimary : .TextColorSecondary)
                .frame(width: activeTab == tab ? 58 : 35, height: activeTab == tab ? 58 : 35)
                .background {
                    if activeTab == tab {
                        Circle()
                            .fill(tint.gradient)
                            .matchedGeometryEffect(id: "ACTIVETAB", in: animation)
                    }
                }
            
            Text(tab.rawValue)
                .font(.caption)
                .foregroundColor(activeTab == tab ? .TextColorPrimary : .TextColorSecondary)
        }
        .frame(maxWidth: .infinity)
        .contentShape(Rectangle())
        .viewPosition{ rect in
            tabPosition.x = rect.midX
            
            if activeTab == tab {
                position.x = rect.midX
            }
        }
        .onTapGesture {
            activeTab = tab
            
            withAnimation(.interactiveSpring(response: 0.6, dampingFraction: 0.7, blendDuration: 0.7)) {
                position.x = tabPosition.x
            }
        }
    }
}

#Preview {
    MainView()
}
