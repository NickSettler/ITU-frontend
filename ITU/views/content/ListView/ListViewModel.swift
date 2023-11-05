//
//  ListViewModel.swift
//  ITU
//
//  Created by Никита Моисеев on 04.11.2023.
//

import Foundation

@MainActor class ListViewModel : ObservableObject {
    private var folderID: String
    
    init(folderID: String) {
        self.folderID = folderID
    }
    
    func handleAppear() {
        
    }
}
