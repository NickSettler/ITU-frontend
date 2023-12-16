//
//  MainViewModel.swift
//  ITU
//
//  Created by Nikita Moiseev
//

import Foundation
import SwiftUI

/// `MainViewModel` is a class designed to manage and provide data for the Main View.
@MainActor class MainViewModel : ObservableObject {

    /// `currentTab` keeps track of the currently active tab in the Main View.
    @Published var currentTab: MenuTabModel = .home

    /// `tabShapePosition` keeps track of the position of the shape at the center of the currently selected tab item.
    @Published var tabShapePosition: CGPoint = .zero
}
