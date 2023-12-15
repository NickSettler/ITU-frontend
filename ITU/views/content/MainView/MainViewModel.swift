//
//  MainViewModel.swift
//  ITU
//
//  Created by Nikita Moiseev
//

import Foundation
import SwiftUI

@MainActor class MainViewModel : ObservableObject {
    @Published var currentTab: MenuTabModel = .home
    @Published var tabShapePosition: CGPoint = .zero
}
