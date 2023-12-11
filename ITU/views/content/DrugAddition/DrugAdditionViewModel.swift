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
    
    enum drugDosage: String, CaseIterable, Identifiable {
        case mg = "mg"
        case mcg = "mcg"
        case g = "g"
        case ml = "ml"
        
        var id: String { self.rawValue }
    }
    
    enum countMeasurement: String, CaseIterable, Identifiable {
        case pcs = "pcs"
        case bottle = "bottle"
        case tube = "tube"
        case ml = "ml"
        
        var id: String { self.rawValue }
    }
    
    @Published var selectedDosage: drugDosage = .mg
    @Published var selectedMeasurement: countMeasurement = .pcs
    @Published var selectedForm = "TBL NOB"
    
    @Published var strengthNumber: String = ""
    @Published var countNumber: String = ""
    
    @Published var date = Date()

    @Published var didRequestComplete: Bool = false

    func createDrug() {
        Task {
            if (countNumber != "") {
                countBinding = "\(countNumber) \(selectedMeasurement.rawValue)"
            }
            
            if (strengthNumber != "") {
                strengthBinding = "\(strengthNumber) \(selectedDosage.rawValue)"
            }
            
            if (createdDrug.form == nil) {
                createdDrug.form = .init(form: selectedForm)
            } else {
                createdDrug.form!.form = selectedForm
            }
            
            createdDrug.form!.form = selectedForm
            
            let created = await DrugsService.createDrug(createdDrug: createdDrug)
            
            if (created) {
                self.didRequestComplete = true
            }
        }
    }
}
