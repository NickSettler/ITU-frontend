//
//  FolderSheetViewModel.swift
//  ITU
//
//  Created by Elena Marochkina
//

import SwiftUI
import Foundation

@MainActor class FolderSheetViewModel : ObservableObject {
    private(set) var initialBinding: Binding<Folder>
    private(set) var isCreate: Bool = true
    
    @Published var didRequestComplete: Bool = false
    @Published var isSymbolPickerPresent: Bool = false
    
    @Published var currentFolder: Folder
    
    var descriptionText: String {
        get {
            currentFolder.description ?? ""
        }
        set {
            currentFolder.description = newValue
        }
    }
    
    init(currentFolder: Binding<Folder>) {
        self.initialBinding = currentFolder
        self.currentFolder = currentFolder.wrappedValue
        self.isCreate = currentFolder.wrappedValue.isEmpty
    }
    
    func createFolder() {
        Task {
            let created = await FoldersService.createFolder(name: self.currentFolder.name, icon: self.currentFolder.icon ?? "", description: self.currentFolder.description ?? "", isPrivate: self.currentFolder.isPrivate)
            
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
                icon: self.currentFolder.icon ?? "",
                description: self.currentFolder.description ?? "",
                isPrivate: self.currentFolder.isPrivate
            )
            
            if updated {
                self.didRequestComplete = true
            }
        }
    }
    
    func calculateTextHeight(_ text: String) -> CGFloat {
        let font = UIFont.preferredFont(forTextStyle: .body)
        let constraintRect = CGSize(width: UIScreen.main.bounds.width - 32, height: .greatestFiniteMagnitude)
        let boundingBox = text.boundingRect(
            with: constraintRect,
            options: [.usesLineFragmentOrigin, .usesFontLeading],
            attributes: [.font: font],
            context: nil
        )
        return max(boundingBox.height + 16, 30) // Adjust as needed
    }
}
