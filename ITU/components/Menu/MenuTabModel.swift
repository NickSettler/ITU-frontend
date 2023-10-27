//
//  MenuTabModel.swift
//  ITU
//
//  Created by Никита Моисеев on 27.10.2023.
//

import Foundation

enum MenuTabModel : String, CaseIterable {
    case home = "Home"
    case settings = "Settings"
    
    var systemImage: String {
        switch self {
        case .home:
            return "house"
        case .settings:
            return "gearshape"
        }
    }
    
    var index: Int {
        return MenuTabModel.allCases.firstIndex(of: self) ?? 0
    }
}
