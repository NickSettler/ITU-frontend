//
//  ListView.swift
//  ITU
//
//  Created by Никита Моисеев on 26.10.2023.
//

import SwiftUI

let tabs = ["ALL","HOME","CAR","COUNTRY","CLUB","VILLA"]

struct CommonListView: View {
    @StateObject private var viewModel = CommonListViewModel()
    
    @State var offset: CGFloat = 0
    @State var offsetY: CGFloat = 0
    
    var size: CGSize
    var safeArea: EdgeInsets
    
    var body: some View {
        NavigationView {
            SearchingView(searchText: $viewModel.searchQuery) {
                GeometryReader{ proxy in
                    let rect = proxy.frame(in: .global)
                    
                    ScrollableTabBar(
                        tabs: tabs,
                        rect: rect,
                        offset: $offset
                    ) {
                        HStack(spacing: 0){
                            ForEach(tabs,id: \.self){ tab in
                                ListView()
                                    .frame(maxWidth: .infinity)
                            }
                        }
                        .ignoresSafeArea()
                    }
                }
                .padding(.top, 48)
                .overlay(
                    TabBar(offset: $offset),
                    alignment: .top
                )
                .toolbar {
                    ToolbarItem(placement: .topBarTrailing) {
                        Button {
                            //
                        } label: {
                            Image(systemName: "plus.circle")
                        }
                    }
                    
                }
            } searchContent: {
                Text("SEACRHHHH")
            }
            .navigationBarTitleDisplayMode(.inline)
            .toolbarBackground(.hidden, for: .navigationBar)
        }
        .searchable(
            text: $viewModel.searchQuery,
            placement: .navigationBarDrawer(displayMode: .always),
            prompt: "Search drugs"
        )
        .onAppear {
            Task {
                await viewModel.getAllUserDrugs()
            }
        }
    }
}

#Preview {
    CommonListView(size: .zero, safeArea: .init(.zero))
}
