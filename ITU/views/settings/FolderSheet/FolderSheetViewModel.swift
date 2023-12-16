//
//  FolderSheetViewModel.swift
//  ITU
//
//  Created by Elena Marochkina
//

import SwiftUI
import Foundation

/// `FolderSheetViewModel` is a class designed to manage and provide data for the FolderSheet view.
@MainActor class FolderSheetViewModel : ObservableObject {

    private(set) var initialBinding: Binding<Folder>
    // Determines whether a new Folder is being created or an existing Folder is being edited.
    private(set) var isCreate: Bool = true
    
    // Tracks if a create or update request has been completed.
    @Published var didRequestComplete: Bool = false

    // Tracks if the SymbolPicker is currently visible.
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
    
    /// Initializes a new instance of `FolderSheetViewModel` with the provided binding to the current folder.
    init(currentFolder: Binding<Folder>) {
        self.initialBinding = currentFolder
        self.currentFolder = currentFolder.wrappedValue
        self.isCreate = currentFolder.wrappedValue.isEmpty
    }
    
    /// Creates a new folder using the FoldersService.
    func createFolder() {
        Task {
            let created = await FoldersService.createFolder(name: self.currentFolder.name, icon: self.currentFolder.icon ?? "", description: self.currentFolder.description ?? "", isPrivate: self.currentFolder.isPrivate)
            
            if (created) {
                self.didRequestComplete = true
            }
        }
    }
    
    /// Updates an existing folder using the FoldersService.
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

    /// Method that calculates and returns an optimal height for the text container to display the given text.
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
