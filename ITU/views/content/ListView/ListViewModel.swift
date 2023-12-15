//
//  ListViewModel.swift
//  ITU
//
//  Created by Nikita Moiseev
//

import SwiftUI
import Foundation

@MainActor class ListViewModel : ObservableObject {
    @Binding var drugsBinding: [Drug]
    @Published var folderID: String
    @Published var drugViewVisible = true
    
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
    
    init(drugs: Binding<[Drug]>, folderID: String) {
        self._drugsBinding = drugs
        self.folderID = folderID
    }
    
    func handleAppear() {
        
    }
}
