//
//  SearchingView.swift
//  ITU
//
//  Created by Elena Marochkina
//

import SwiftUI

/// Searching view
struct SearchingView<MContent : View, SContent: View>: View {
    @Environment(\.isSearching) private var isSearching
    @Binding var searchText: String
    
    var mainContent: MContent
    var searchContent: SContent

    /// Init searching view
    /// - Parameters:
    ///   - searchText: Binding to search text
    ///   - mainContent: Main content
    ///   - searchContent: Search content
    init(
        searchText: Binding<String>,
        @ViewBuilder mainContent: () -> MContent,
        @ViewBuilder searchContent: () -> SContent
    ) {
        self._searchText = searchText
        self.mainContent = mainContent()
        self.searchContent = searchContent()
    }
    
    var body: some View {
        if isSearching {
            searchContent
        } else {
            mainContent
        }
    }
}

#Preview {
    NavigationView {
        SearchingView(searchText: .constant("")) {
            Text("MAIN")
        } searchContent: {
            Text("SEARCH")
        }
        .searchable(text: .constant(""))
    }
}
