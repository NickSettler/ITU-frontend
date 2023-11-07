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
    
    var body: some View {
        NavigationView {
            SearchingView(searchText: $viewModel.searchQuery) {
                VStack(spacing: 0) {
                    TabBarView(
                        currentFolder: self.$viewModel.selectedFolder,
                        folders: self.$viewModel.folders
                    )
                    
                    TabView(selection: self.$viewModel.selectedFolder) {
                        ForEach(self.viewModel.folders, id: \.id) { folder in
                            ListView(
                                drugs: $viewModel.drugs,
                                folderID: folder.id
                            )
                            .tag(folder)
                        }
                    }
                    .refreshable {
                        viewModel.getAllUserFolders()
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
            viewModel.getAllUserFolders()
            viewModel.getAllUserDrugs()
        }
    }
}

#Preview {
    CommonListView(size: .zero, safeArea: .init(.zero))
}
