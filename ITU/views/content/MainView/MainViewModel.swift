//
//  MainViewModel.swift
//  ITU
//
//  Created by Никита Моисеев on 27.10.2023.
//

import Foundation
import SwiftUI

@MainActor class MainViewModel : ObservableObject {
    @Published var currentTab: MenuTabModel = .home
    @Published var tabShapePosition: CGPoint = .zero
    
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
        set {
            //
        }
    }
}
