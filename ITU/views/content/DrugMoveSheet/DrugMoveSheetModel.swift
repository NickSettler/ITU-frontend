//
//  DrugMoveSheetModel.swift
//  ITU
//
//  Created by Nikita Moiseev
//

import Foundation

/// `DrugMoveSheetModel` is a view model designed to manage and publish the data for `DrugMoveSheet` view.
@MainActor final class DrugMoveSheetModel : ObservableObject {

    /// Private set variable representing the ID of a drug being moved
    private(set) var drugID: Int
    
    /// Publication of user's folders list and current/selected folder
    /// Also publishes when moving the drug is completed
    @Published var userFolders: [Folder] = []
    @Published var currentFolder: Folder = .empty
    
    @Published var didMoveComplete = false
    
    /// Initializer
    init(drugID: Int, currentFolder: Folder) {
        self.drugID = drugID
        self.currentFolder = currentFolder
    }
    
    /// Function to fetch user's folders from the server
    func getUserFolders() {
        Task {
            let folders = await FoldersService.getFolders()?.data
            
            if let folders = folders {
                self.userFolders = folders
            }
        }
    }
    
    /// Function to move the drug to the selected folder in the server
    func moveDrug() {
        Task {
            let done = await DrugsService.moveDrug(drugID, folderID: currentFolder != .empty ? currentFolder.id : nil)
            
            if done {
                self.didMoveComplete = true
            }
        }
    }
}
