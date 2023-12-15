//
//  DrugMoveSheetModel.swift
//  ITU
//
//  Created by Никита Моисеев on 15.12.2023.
//

import Foundation

@MainActor final class DrugMoveSheetModel : ObservableObject {
    private(set) var drugID: Int
    
    @Published var userFolders: [Folder] = []
    @Published var currentFolder: Folder = .empty
    
    @Published var didMoveComplete = false
    
    init(drugID: Int, currentFolder: Folder) {
        self.drugID = drugID
        self.currentFolder = currentFolder
    }
    
    func getUserFolders() {
        Task {
            let folders = await FoldersService.getFolders()?.data
            
            if let folders = folders {
                self.userFolders = folders
            }
        }
    }
    
    func moveDrug() {
        Task {
            let done = await DrugsService.moveDrug(drugID, folderID: currentFolder != .empty ? currentFolder.id : nil)
            
            if done {
                self.didMoveComplete = true
            }
        }
    }
}
