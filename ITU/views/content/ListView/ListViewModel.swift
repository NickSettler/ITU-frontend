//
//  ListViewModel.swift
//  ITU
//
//  Created by Никита Моисеев on 02.11.2023.
//

import Foundation
import SwiftUI

@MainActor class ListViewModel : ObservableObject {
    @Published var searchQuery: String = ""
    @Published var drugs: [Drug] = []
}
