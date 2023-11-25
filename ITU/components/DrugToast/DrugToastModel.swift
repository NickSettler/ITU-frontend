//
//  DrugToastModel.swift
//  ITU
//
//  Created by Никита Моисеев on 25.11.2023.
//

import SwiftUI
import Foundation

@MainActor final class DrugToastModel : ObservableObject {
    @Published var isHintVisible: Bool = false
}
