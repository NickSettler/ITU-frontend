//
//  MenuTabModel.swift
//  ITU
//
//  Created by Nikita Pasynkov
//

import Foundation

/// `MenuTabModel` represents different tabs used in the bottom menu.
/// Conforms to `CaseIterable` so that you can access an array of its cases with `allCases`.
enum MenuTabModel : String, CaseIterable {

    // Different tabs
    case home = "Home"
    case settings = "Settings"

    // Returns the system image name associated with each tab
    var systemImage: String {
        switch self {
        case .home:
            return "house"
        case .settings:
            return "gearshape"
        }
    }

   // Returns the index of each tab in the bottom menu
    var index: Int {
        return MenuTabModel.allCases.firstIndex(of: self) ?? 0
    }
}
