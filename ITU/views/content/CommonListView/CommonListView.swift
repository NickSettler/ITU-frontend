//
//  ListView.swift
//  ITU
//
//  Created by Nikita Moiseev
//

import SwiftUI

struct CommonListView: View {
    @StateObject var viewModel = CommonListViewModel()
    
    @State var offset: CGFloat = 0
    @State var offsetY: CGFloat = 0
    
    var size: CGSize
    var safeArea: EdgeInsets
    
    var body: some View {
        NavigationView {
            SearchingView(searchText: $viewModel.searchQuery) {
                VStack(spacing: 0) {
                    TabBarView(
                        currentFolder: self.$viewModel.selectedFolder,
                        folders: self.$viewModel.folders,
                        folderColors: viewModel.getTabsColors()
                    )
                    
                    TabView(selection: self.$viewModel.selectedFolder) {
                        ForEach(self.viewModel.folders, id: \.id) { folder in
                            ListView(
                                drugs: $viewModel.drugs,
                                folderID: folder.id,
                                refreshFunc: viewModel.refresh
                            )
                            .tag(folder)
                        }
                    }
                    .refreshable {
                        viewModel.refresh()
                    }
                    .tabViewStyle(.page(indexDisplayMode: .never))
                }
                .toolbar {
                    ToolbarItem(placement: .topBarTrailing) {
                        Button {
                            viewModel.isDrugCreateVisible = true
                        } label: {
                            Image(systemName: "plus.circle")
                        }
                    }
                    
                }
            } searchContent: {
                Text("Search")
            }
            .navigationTitle("My drugs")
            .navigationBarTitleDisplayMode(.inline)
            .toolbarBackground(.hidden, for: .navigationBar)
        }
        .sheet(isPresented: $viewModel.isDrugCreateVisible) {
            DrugAdditionView(selectedFolder: viewModel.selectedFolder)
        }
        .searchable(
            text: $viewModel.searchQuery,
            placement: .navigationBarDrawer(displayMode: .always),
            prompt: "Search drugs"
        )
        .onReceive(viewModel.$isDrugCreateVisible) {
            if (!$0) {
                viewModel.refresh()
            }
        }
        .onAppear {
            viewModel.refresh()
        }
    }
}

#Preview {
    CommonListView(size: .zero, safeArea: .init(.zero))
}
