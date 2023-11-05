//
//  ListViewModel.swift
//  ITU
//
//  Created by Nikita Moiseev on 02.11.2023.
//

import Foundation
import SwiftUI

@MainActor class CommonListViewModel : ObservableObject {
    @Published var selectedFolder: String = tabs[0]
    @Published var searchQuery: String = ""
    
    @Published var folders: [Folder] = defaultFolders
    @Published var drugs: [Drug] = []
    
    func getAllUserFolders() {
        Task {
//            await
        }
    }
    
    func getAllUserDrugs() async {
        if let res = await DrugsService.getAllUserDrugs() {
            await MainActor.run {
//                print(res.data)
                self.drugs = res.data
            }
        } else {
            print("Failed fetching drugs")
        }
    }
}
