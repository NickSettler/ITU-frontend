//
//  DrugAdditionViewModel.swift
//  ITU
//
//  Created by Nikita Moiseev
//

import SwiftUI
import Foundation

/// Enums representing drug dosage, count measurement, and drug addition mode.
/// Enums are conforming to `Identifiable` and `CaseIterable` for easy use with SwiftUI Pickers and iteration through all cases.

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

enum DRUG_ADDITION_MODE {
    case create
    case update
}

/// `DrugAdditionViewModel` is a view model designed to manage and publish the data for `DrugAdditionView`.
@MainActor class DrugAdditionViewModel : ObservableObject {

    // Private state objects and local variables
    private(set) var drugBinding: Binding<Drug>?
    private(set) var selectedFolder: Folder? = nil
    
    /// Publication of different types of data used in `DrugAdditionView`
    @Published var mode: DRUG_ADDITION_MODE = .create
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
    
    @Published var selectedDosage: drugDosage = .mg
    @Published var selectedMeasurement: countMeasurement = .pcs
    @Published var selectedForm = "TBL NOB"
    
    @Published var strengthNumber: String = ""
    @Published var countNumber: String = ""
    
    @Published var date = Date()
    
    @Published var didRequestComplete: Bool = false
    
    /// Initializers for updating a drug or creating a new drug in a selected folder.
    init(selectedFolder: Folder) {
        self.selectedFolder = selectedFolder
    }
    
    init(drug: Binding<Drug>) {
        self.drugBinding = drug
        
        self.mode = .update
        self.createdDrug = drug.wrappedValue
        
        var countComponents = self.createdDrug.count.components(separatedBy: " ")
        
        self.selectedMeasurement = .init(
            rawValue: countComponents.last ?? countMeasurement.pcs.rawValue
        ) ?? countMeasurement.pcs
        self.countNumber = countComponents.prefix(countComponents.count - 1).joined(separator: " ")
        
        if let strength = createdDrug.strength {
            var strengthComponents = strength.components(separatedBy: " ")
            
            self.selectedDosage = .init(
                rawValue: strengthComponents.last ?? drugDosage.mg.rawValue
            ) ?? drugDosage.mg
            self.strengthNumber = strengthComponents.prefix(strengthComponents.count - 1).joined(separator: " ")
        }
        
        if let form = createdDrug.form {
            self.selectedForm = form.form
        }
    }
    
    /// Prepare createdDrug for saving based on user inputs.
    private func prepare() {
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
        
        if selectedFolder != .allFolder {
            createdDrug.location = selectedFolder
        }
    }
    
    /// Function for creating a drug
    private func createDrug() {
        Task {
            self.prepare()
            
            let created = await DrugsService.createDrug(createdDrug: createdDrug)
            
            if (created) {
                self.didRequestComplete = true
            }
        }
    }
    
    /// Function for updating a drug
    private func updateDrug() {
        Task {
            self.prepare()
            
            let updated = await DrugsService.updateDrug(id: self.createdDrug.id, updatedDrug: self.createdDrug)
            
            if updated != nil {
                self.didRequestComplete = true
            }
        }
    }
    
    /// Function to handle saving of drug. If mode is `create`, create drug, else update drug.
    func save() {
        if mode == .create {
            self.createDrug()
        } else {
            self.updateDrug()
        }
    }
}
