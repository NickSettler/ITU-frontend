//
//  SearchingView.swift
//  ITU
//
//  Created by Nikita Pasynkov
//

import SwiftUI

/// `SearchingView` is a customizable SwiftUI view component that switches between showing
/// the main content and search content based on whether a search is active or not.
struct SearchingView<MContent : View, SContent: View>: View {
    // Environment variable to detect if search is active
    @Environment(\.isSearching) private var isSearching
    // The text to be used in the search
    @Binding var searchText: String

    // The Main Content to show when not searching
    var mainContent: MContent
    // The Content to show when a search is active
    var searchContent: SContent

    /// Initialize SearchingView with search text, main content and search content.
    /// - Parameters:
    ///   - searchText: Binding to the searchText to be used in the search
    ///   - mainContent: A closure returning the content to show when not searching
    ///   - searchContent: A closure returning the content to show when searching
    init(
        searchText: Binding<String>,
        @ViewBuilder mainContent: () -> MContent,
        @ViewBuilder searchContent: () -> SContent
    ) {
        self._searchText = searchText
        self.mainContent = mainContent()
        self.searchContent = searchContent()
    }

    /// Body of SearchingView. Decides what to show based on whether search is active or not.
    var body: some View {
        if isSearching {
            searchContent
        } else {
            mainContent
        }
    }
}

// Example usage of SearchingView.
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
