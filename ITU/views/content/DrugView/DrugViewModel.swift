//
//  DrugViewModel.swift
//  ITU
//
//  Created by Никита Моисеев on 06.11.2023.
//

import SwiftUI
import Foundation

@MainActor class DrugViewModel : ObservableObject {
    @Binding var drugBinding: Drug
    
    init(drug: Binding<Drug>) {
        self._drugBinding = drug
    }
}
