//
//  DrugViewModel.swift
//  ITU
//
//  Created by Никита Моисеев on 06.11.2023.
//

import SwiftUI
import Foundation

struct DrugChipData : Codable, Hashable {
    var text: String
    var role: E_ROLE_GROUP
    var hintTitle: String?
    var hintText: String?
    
    enum CodingKeys: CodingKey {
        case text
        case role
        case hintTitle
        case hintText
    }
    
    init(text: String, role: E_ROLE_GROUP, hintTitle: String? = nil, hintText: String? = nil) {
        self.text = text
        self.role = role
        self.hintTitle = hintTitle
        self.hintText = hintText
    }
}

@MainActor class DrugViewModel : ObservableObject {
    private(set) var drugBinding: Binding<Drug>
    
    @Published var drug: Drug
    @Published var getRequestInProgress: Bool = false
    @Published var rotation = 0.0
    
    var expiryDateToastRole: E_ROLE_GROUP {
        get {
            switch(drug.expiry_state) {
            case .not:
                return .success
            case .soon:
                return .warning
            case .expired:
                return .error
            }
        }
    }
    
    var tags: [DrugChipData] {
        get {
            var result: [DrugChipData] = []
            
            switch(drug.expiry_state) {
            case .not:
                result.append(.init(text: "Not Expired", role: .success))
            case .soon:
                result.append(.init(text: "Expires soon", role: .warning))
            case .expired:
                result.append(.init(text: "Expired", role: .error))
            }
            
            if let strength = drug.strength {
                result.append(.init(text: "\(strength)", role: .success))
            }
            
            if let form = drug.form?.name {
                result.append(.init(text: "\(form)", role: .success))
            }
            
            if let route = drug.route?.name {
                result.append(.init(text: "\(route)", role: .success))
            }
            
            if let package = drug.package {
                result.append(.init(text: "\(package)", role: .success))
            }
            
            if let dosage = drug.dosage?.name {
                result.append(.init(text: "\(dosage)", role: .success))
            }
            
            if let pharm_class = drug.pharm_class?.name {
                result.append(.init(text: "\(pharm_class)", role: .success))
            }
            
            result = result.sorted { tag1, tag2 in
                return tag1.role.rawValue > tag2.role.rawValue
            }
            
            return result
        }
    }
    
    init(drug: Binding<Drug>) {
        self.drugBinding = drug
        self.drug = drug.wrappedValue
    }
    
    func getDrugInfo() {
        Task {
            withAnimation(.interactiveSpring(response: 0.55, dampingFraction: 0.65, blendDuration: 0.65)) {
                getRequestInProgress = true
            }
            withAnimation(
                .linear(duration: 1.5)
                .repeatForever(autoreverses: false)
            ) {
                rotation = 360.0
            }
            
            try await Task.sleep(nanoseconds: 2_000_000_000)
            
            let data = await DrugsService.getUserDrug(drugBinding.id)
            
            withAnimation(.interactiveSpring(response: 0.55, dampingFraction: 0.65, blendDuration: 0.65)) {
                getRequestInProgress = false
                rotation = 0.0
                
                if let drug = data?.data {
                    self.drug = drug
                    self.drugBinding.wrappedValue = self.drug
                }
            }
        }
    }
}
