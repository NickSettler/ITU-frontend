//
//  ListViewModel.swift
//  ITU
//
//  Created by Nikita Moiseev
//

import Foundation
import SwiftUI

@MainActor class CommonListViewModel : ObservableObject {
    @Published var selectedFolder: Folder = .allFolder
    @Published var searchQuery: String = ""
    @Published var isDrugCreateVisible: Bool = false
    
    @Published var folders: [Folder] = [.allFolder]
    @Published var drugs: [Drug] = []
    
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
    
    func refresh() {
        self.getAllUserFolders()
        self.getAllUserDrugs()
    }
}
