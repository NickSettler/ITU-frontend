//
//  ListView.swift
//  ITU
//
//  Created by Nikita Moiseev on 26.10.2023.
//

import SwiftUI

let tabs = ["ALL","HOME","CAR","COUNTRY","CLUB","VILLA"]

struct CommonListView: View {
    @StateObject var viewModel = CommonListViewModel()
    
    @State var offset: CGFloat = 0
    @State var offsetY: CGFloat = 0
    
    var size: CGSize
    var safeArea: EdgeInsets
    
    @State var currentTab: String = tabs[0]
    @State var drugs: [Drug] = []
    
    var body: some View {
        NavigationView {
            SearchingView(searchText: $viewModel.searchQuery) {
                VStack(spacing: 0) {
                    TabBarView(currentTab: self.$currentTab)
                    
                    TabView(selection: self.$currentTab) {
                        ForEach(tabs, id: \.self) { tab in
                            ListView(
                                drugs: $viewModel.drugs,
                                folderID: tab
                            )
                            .tag(tab)
                        }
                    }
                    .refreshable {
                        viewModel.getAllUserDrugs()
                    }
                    .tabViewStyle(.page(indexDisplayMode: .never))
                }
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
            .navigationTitle("My drugs")
            .navigationBarTitleDisplayMode(.inline)
            .toolbarBackground(.hidden, for: .navigationBar)
        }
        .searchable(
            text: $viewModel.searchQuery,
            placement: .navigationBarDrawer(displayMode: .always),
            prompt: "Search drugs"
        )
        .onAppear {
            viewModel.getAllUserDrugs()
        }
    }
}

#Preview {
    CommonListView(size: .zero, safeArea: .init(.zero))
}
