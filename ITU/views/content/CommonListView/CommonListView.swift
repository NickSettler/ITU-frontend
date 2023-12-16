//
//  ListView.swift
//  ITU
//
//  Created by Nikita Moiseev
//

import SwiftUI

/// `CommonListView` is a view representing a list of common items, such as drugs.
struct CommonListView: View {
    // The ViewModel to manage the list data
    @StateObject var viewModel = CommonListViewModel()
    
    /// Offset states for tracking user's scroll offset
    @State var offset: CGFloat = 0
    @State var offsetY: CGFloat = 0
    
    /// Size and safeArea are properties to define the view's layout constraint.
    var size: CGSize
    var safeArea: EdgeInsets
    
    /// Body of `CommonListView`.
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
        // This action calls viewModel.refresh() when the view first appears
        .onAppear {
            viewModel.refresh()
        }
    }
}

// Represents `CommonListView`.
#Preview {
    CommonListView(size: .zero, safeArea: .init(.zero))
}
