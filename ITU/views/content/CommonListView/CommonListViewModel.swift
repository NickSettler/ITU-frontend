//
//  ListViewModel.swift
//  ITU
//
//  Created by Nikita Moiseev
//

import Foundation
import SwiftUI

/// `CommonListViewModel` is a view model designed to manage and publish the list data for `CommonListView`.
@MainActor class CommonListViewModel : ObservableObject {

    /// Selected `Folder` & search query
    @Published var selectedFolder: Folder = .allFolder
    @Published var searchQuery: String = ""

    /// Flag to control drug creation UI visibility
    @Published var isDrugCreateVisible: Bool = false
    
    /// User's folders and drugs data
    @Published var folders: [Folder] = [.allFolder]
    @Published var drugs: [Drug] = []
    
    /// Fetch user's folders from server
    func getAllUserFolders() {
        Task {
            if let res = await FoldersService.getFolders() {
                await MainActor.run {
                    self.folders = [.allFolder] + res.data
                    
                    if (!self.folders.contains(keyPath: \.id, matching: self.selectedFolder.id)) {
                        self.selectedFolder = .allFolder
                    }
                }
            } else {
                print("Failed fetching folders")
            }
        }
    }
    
    /// Fetch user's drugs from server
    func getAllUserDrugs() {
        Task {
            if let res = await DrugsService.getAllUserDrugs() {
                await MainActor.run {
                    self.drugs = res.data
                }
            } else {
                print("Failed fetching drugs")
            }
        }
    }
    
    /// Generate tabs color dictionary based on the drug state.
    /// This function takes no parameters.
    /// - Returns: A dictionary where keys are folder IDs, and values are the associated Color items.
    func getTabsColors() -> Dictionary<String, Color> {
        var folderColors: Dictionary<String, Color> = [:]
        
        for folder in folders {
            var currentTabColor = Color.textColorSecondary
            
            for drug in drugs {
                
                if (drug.location?.id == folder.id){
                    
                    if (drug.expiry_state == .expired) {
                        folderColors[folder.id] = Color.Quaternary400
                        break
                    } else if (drug.expiry_state == .soon) {
                        currentTabColor = Color.Secondary200
                    }
                }
            }
            
            if folderColors[folder.id] != Color.Quaternary400 {
                folderColors[folder.id] = currentTabColor
            }
        }
        
        return folderColors
    }

    /// Refresh the folders and drugs data.
    /// It updates 'folders' and 'drugs' properties by fetching latest data from the server.
    func refresh() {
        self.getAllUserFolders()
        self.getAllUserDrugs()
    }
}
