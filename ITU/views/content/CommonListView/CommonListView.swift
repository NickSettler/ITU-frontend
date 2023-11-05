//
//  ListView.swift
//  ITU
//
//  Created by Nikita Moiseev on 26.10.2023.
//

import SwiftUI

let tabs = ["ALL","HOME","CAR","COUNTRY","CLUB","VILLA"]

struct CommonListView: View {
    @ObservedObject private var viewModel = CommonListViewModel()
    
    @State var offset: CGFloat = 0
    @State var offsetY: CGFloat = 0
    
    var size: CGSize
    var safeArea: EdgeInsets
    
    @State var currentTab: String = tabs[0]
    
    var body: some View {
        NavigationView {
            SearchingView(searchText: $viewModel.searchQuery) {
                VStack {
                    TabBarView(currentTab: self.$currentTab)
                    TabView(selection: self.$currentTab) {
                        ListView(
                            drugs: $viewModel.drugs,
                            folderID: ""
                        ).tag(tabs[0])
                        ListView(
                            drugs: $viewModel.drugs,
                            folderID: ""
                        ).tag(tabs[1])
                        ListView(
                            drugs: $viewModel.drugs,
                            folderID: ""
                        ).tag(tabs[2])
                        ListView(
                            drugs: $viewModel.drugs,
                            folderID: ""
                        ).tag(tabs[3])
                        ListView(
                            drugs: $viewModel.drugs,
                            folderID: ""
                        ).tag(tabs[4])
                        ListView(
                            drugs: $viewModel.drugs,
                            folderID: ""
                        ).tag(tabs[5])
                    }
                    .refreshable {
                        Task {
                            await viewModel.getAllUserDrugs()
                        }
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
            Task {
                await viewModel.getAllUserDrugs()
            }
        }
    }
}

#Preview {
    CommonListView(size: .zero, safeArea: .init(.zero))
}
