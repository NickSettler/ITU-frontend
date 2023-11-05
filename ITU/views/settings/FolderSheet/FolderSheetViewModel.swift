//
//  FolderSheetViewModel.swift
//  ITU
//
//  Created by Nikita Pasynkov on 05.11.2023.
//

import SwiftUI
import Foundation

@MainActor class FolderSheetViewModel : ObservableObject {
    @Published var name: String = ""
    @Published var didRequestComplete: Bool = false
    
    func createFolder() {
        Task {
            let created = await FoldersService.createFolder(name: self.name)
            
            if (created) {
                self.didRequestComplete = true
            }
        }
    }
}

