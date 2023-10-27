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
}
