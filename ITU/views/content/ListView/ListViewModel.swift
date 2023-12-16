//
//  ListViewModel.swift
//  ITU
//
//  Created by Nikita Moiseev
//

import SwiftUI
import Foundation

/// `ListViewModel` is a class designed to manage and provide data for a List view.
@MainActor class ListViewModel : ObservableObject {
    @Binding var drugsBinding: [Drug]
    @Published var folderID: String
    @Published var drugViewVisible = true
    
    /// `filteredDrugs` computes and returns a list of drugs filtered based on a folder ID or returns
    /// whole drug list if folder ID matches with `Folder.allFolder.id`.
    var filteredDrugs: [Drug] {
        get {
            if (folderID == Folder.allFolder.id) {
                return drugsBinding
            }
            
            return self.drugsBinding.filter {
                return $0.location?.id == folderID
            }
        }
        set {
            self.drugsBinding = newValue
        }
    }
    
    /// Initializes a new instance of `ListViewModel` with the provided binding to the drug list and folder ID.
    init(drugs: Binding<[Drug]>, folderID: String) {
        self._drugsBinding = drugs
        self.folderID = folderID
    }
}
