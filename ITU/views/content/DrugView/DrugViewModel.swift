//
//  DrugViewModel.swift
//  ITU
//
//  Created by Никита Моисеев on 06.11.2023.
//

import SwiftUI
import Foundation

@MainActor class DrugViewModel : ObservableObject {
    private(set) var drugBinding: Binding<Drug>
    
    @Published var drug: Drug
    @Published var getRequestInProgress: Bool = false
    @Published var rotation = 0.0
    
    var expiryDateToastRole: DrugToastRole {
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
