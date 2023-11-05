//
//  FoldersViewModel.swift
//  ITU
//
//  Created by Никита Моисеев on 05.11.2023.
//

import Foundation

@MainActor class FoldersViewModel : ObservableObject {
    @Published var isAnimating: Bool = true
    @Published var isSheetVisible: Bool = false
}
