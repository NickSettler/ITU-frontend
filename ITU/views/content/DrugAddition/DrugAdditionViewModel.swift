//
//  DrugAdditionViewModel.swift
//  ITU
//
//  Created by Nikita on 25.11.2023.
//

import SwiftUI
import Foundation

@MainActor class DrugAdditionViewModel : ObservableObject {
    @Published var createdDrug: Drug = .empty
    
    var strengthBinding: String {
        get {
            return createdDrug.strength ?? ""
        }
        set {
            createdDrug.strength = newValue
        }
    }
    var countBinding: String {
        get {
            return createdDrug.count
        }
        set {
            createdDrug.count = newValue
        }
    }

    @Published var didRequestComplete: Bool = false

    func createDrug() {
        Task {
            let created = await DrugsService.createDrug(createdDrug: createdDrug)
            
            if (created) {
                self.didRequestComplete = true
            }
        }
    }
}
