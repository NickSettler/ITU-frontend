//
//  ListViewModel.swift
//  ITU
//
//  Created by Nikita Moiseev on 04.11.2023.
//

import SwiftUI
import Foundation

@MainActor class ListViewModel : ObservableObject {
    @Binding var drugs: [Drug]
    @Published var folderID: String
    
    init(drugs: Binding<[Drug]>, folderID: String) {
        self._drugs = drugs
        self.folderID = folderID
    }
    
    func handleAppear() {
        
    }
}
