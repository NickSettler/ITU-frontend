//
//  FolderSheetViewModel.swift
//  ITU
//
//  Created by Nikita Pasynkov, Elena Marochkina on 05.11.2023.
//

import SwiftUI
import Foundation

@MainActor class FolderSheetViewModel : ObservableObject {
    private(set) var initialBinding: Binding<Folder>
    private(set) var isCreate: Bool = true
    
    @Published var didRequestComplete: Bool = false
    @Published var isSymbolPickerPresent: Bool = false
    
    @Published var currentFolder: Folder
    
    init(currentFolder: Binding<Folder>) {
        print(currentFolder)
        self.initialBinding = currentFolder
        self.currentFolder = currentFolder.wrappedValue
        self.isCreate = currentFolder.wrappedValue.isEmpty
    }
    
    
    func createFolder() {
        Task {
            let created = await FoldersService.createFolder(name: self.currentFolder.name, icon: self.currentFolder.icon ?? "")
            
            if (created) {
                self.didRequestComplete = true
                
            }
        }
    }
    
    func updateFolder() {
        Task {
            let updated = await FoldersService.updateFolder(
                id: self.currentFolder.id,
                name: self.currentFolder.name,
                icon: self.currentFolder.icon ?? ""
            )
            
            if updated {
                self.didRequestComplete = true
            }
        }
    }
    
}
