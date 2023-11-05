//
//  ListViewModel.swift
//  ITU
//
//  Created by Никита Моисеев on 02.11.2023.
//

import Foundation
import SwiftUI

@MainActor class CommonListViewModel : ObservableObject {
    @Published var selectedFolder: String = "ALL"
    @Published var searchQuery: String = ""
    
    func getAllUserDrugs() async {
        await DrugsService.getAllUserDrugs { r in
            // 
        }
        await DrugsService.getAllUserDrugs { r in
            print(r)
        }
    }
}
