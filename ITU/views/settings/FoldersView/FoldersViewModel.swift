//
//  FoldersViewModel.swift
//  ITU
//
//  Created by Nikita Moiseev on 05.11.2023.
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

@MainActor class FoldersViewModel : ObservableObject {
    var currentFolder: Binding<Folder?> {
        didSet {
            print(currentFolder)
        }
    }
    
    @Published var isPresented: Bool = false
    @Published var isAnimating: Bool = true
    @Published var isSheetVisible: Bool = false
    @Published var folders: [Folder] = []
    
    init() {
        self.currentFolder = .constant(nil)
    }
    
    var initialFolders: [Folder] = []
    
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
    
    func handleMove(a: IndexSet, b: Int) {
        self.folders.move(fromOffsets: a, toOffset: b)
    }
    
    func handleDelete(offsets: IndexSet) {
        let idsToDelete = offsets.map { self.folders[$0].id }
        Task {
            let deleted = await FoldersService.deleteFolders(ids: idsToDelete)
            
            if (deleted) {
                self.folders.remove(atOffsets: offsets)
            }
        }
    }
    
    func handleSaveChanges() {
        self.folders = self.folders.enumerated().map { index, element in
            var _element = element
            _element.sort = index
            return _element
        }
    }
}
