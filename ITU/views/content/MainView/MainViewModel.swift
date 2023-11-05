//
//  MainViewModel.swift
//  ITU
//
//  Created by Nikita Moiseev on 27.10.2023.
//

import Foundation
import SwiftUI

@MainActor class MainViewModel : ObservableObject {
    @Published var currentTab: MenuTabModel = .home
    @Published var tabShapePosition: CGPoint = .zero
}
