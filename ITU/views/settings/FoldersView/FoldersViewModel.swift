//
//  FoldersViewModel.swift
//  ITU
//
//  Created by Elena Marochkina
//

import Foundation
import SwiftUI

extension Array where Element: Hashable {
    func difference(from other: [Element]) -> [Element] {
        let thisSet = Set(self)
        let otherSet = Set(other)
        return Array(thisSet.symmetricDifference(otherSet))
    }
}

/// `FoldersViewModel` is a class designed to manage and provide data for the FoldersView.
@MainActor class FoldersViewModel : ObservableObject {
    var currentFolder: Binding<Folder?> = .constant(nil)
    
    // Represents whether the folder creation modal is presented.
    @Published var isPresented: Bool = false

    // Manages the animation state.
    @Published var isAnimating: Bool = true

    // List of folders in the view.
    @Published var folders: [Folder] = []
    
    var initialFolders: [Folder] = []
    
    /// Fetches all user folders using the FoldersService.
    func getAllUserFolders() {
        Task {
            let foldersResponse = await FoldersService.getFolders()
            
            if let folders = foldersResponse?.data {
                self.folders = folders
            }
            
            self.folders = self.folders.sorted {
                return Int($0.sort ?? -1) > Int($1.sort ?? -1)
            }
            
            self.initialFolders = self.folders
        }
    }
    
    /// Handles moving a folder from an index to another.
    ///
    /// - Parameters:
    ///     - a: The index set of the folder to move.
    ///     - b: The index to move the folder to.
    func handleMove(a: IndexSet, b: Int) {
        self.folders.move(fromOffsets: a, toOffset: b)
    }
    
    /// Handles deleting folders with the given offsets.
    ///
    /// - Parameters:
    ///     - offsets: The index set of the folders to delete.
    func handleDelete(offsets: IndexSet) {
        let idsToDelete = offsets.map { self.folders[$0].id }
        Task {
            let deleted = await FoldersService.deleteFolders(ids: idsToDelete)
            
            if (deleted) {
                self.folders.remove(atOffsets: offsets)
            }
        }
    }
    
    /// Handles saving changes in folders' order.
    func handleSaveChanges() {
        self.folders = self.folders.enumerated().map { index, element in
            var _element = element
            _element.sort = index
            return _element
        }
    }
}
