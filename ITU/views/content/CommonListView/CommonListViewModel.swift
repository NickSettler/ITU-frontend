//
//  ListViewModel.swift
//  ITU
//
//  Created by Никита Моисеев on 02.11.2023.
//

import Foundation
import SwiftUI

@MainActor class CommonListViewModel : ObservableObject {
    @Published var searchQuery: String = ""
    
    var searchResults: [Drug] {
        get {
            if searchQuery.isEmpty {
                return allDrugs
            } else {
                return allDrugs.filter {
                    $0.name.lowercased().contains(searchQuery.lowercased()) ||
                    $0.complement.lowercased().contains(searchQuery.lowercased())
                }
            }
        }
    }
}
