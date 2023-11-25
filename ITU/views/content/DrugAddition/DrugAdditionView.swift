//
//  DrugAdditionView.swift
//  ITU
//
//  Created by Nikita on 25.11.2023.
//

import SwiftUI

struct DrugAdditionView: View {
    
    @StateObject var viewModel = DrugAdditionViewModel()
    
    @Environment(\.presentationMode) var presentationMode
    
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
    
    @State private var selectedDosage: drugDosage = .mg
    @State private var selectedMeasurement: countMeasurement = .pcs
    
    @State private var strengthNumber: String = ""
    @State private var countNumber: String = ""
    
    @State private var date = Date()
    
    var body: some View {
        NavigationStack {
            VStack {
                CustomTextField(
                    sfIcon: "textformat.size.larger",
                    hint: "Name",
                    value: $viewModel.createdDrug.name
                )
                
                HStack {
                    CustomTextField(
                        hint: "Dose",
                        value: $strengthNumber
                    )
                    
                    Picker("Dosage", selection: $selectedDosage) {
                        ForEach(drugDosage.allCases) { option in
                            Text(String(describing: option)).tag(option)
                        }
                    }
                    .pickerStyle(.wheel)
                    
                    
                    Picker("Form", selection: $viewModel.createdDrug.form.form) {
                        Text("Tablet").tag("TBL NOB")
                        Text("Tobolka").tag("CPS")
                        Text("Injekce").tag("INJ")
                        Text("Sirup").tag("SIR")
                        Text("Suspenze").tag("SUS")
                        Text("Roztok").tag("SOL")
                        Text("Krém").tag("CRM")
                        Text("Mast").tag("UNG")
                        Text("Gel").tag("GEL")
                        Text("Powder").tag("PLV")
                        Text("Inhaler").tag("ING")
                        Text("Čípek").tag("SUP")
                        Text("Pastilka").tag("PAS")
                        Text("Drops").tag("GTT")
                        Text("Sprej").tag("SPR")
                    }
                }
                .padding(.top, 24)
                DatePicker(
                    "Expiration date",
                    selection: $viewModel.createdDrug.expiration_date,
                    displayedComponents: .date
                )
                
                HStack (spacing: 24) {
                    CustomTextField(
                        hint: "Count",
                        value: $countNumber
                    )
                    
                    Picker("Count", selection: $selectedMeasurement) {
                        ForEach(countMeasurement.allCases) { option in
                            Text(String(describing: option)).tag(option)
                        }
                    }
                }
                .padding(.top, 24)
                
                
                Spacer()
                
                
                GradientButton(title: "Add", fullWidth: true) {
                    if (strengthNumber != "" && countNumber != "") {
                        viewModel.countBinding = "\(countNumber)\(selectedMeasurement.rawValue)"
                        viewModel.strengthBinding = "\(strengthNumber)\(selectedDosage.rawValue)"
                    }
                    viewModel.createDrug()
                }
                .disabled(viewModel.createdDrug.name.isEmpty)
                .padding(.top, 64)
            }
            .padding()
            .toolbar {
                ToolbarItem(placement: .topBarLeading) {
                    Button {
                        self.presentationMode.wrappedValue.dismiss()
                    } label: {
                        Text("Close")
                    }
                }
            }
        }
        .presentationDetents([.medium])
        .onReceive(viewModel.$didRequestComplete) {
            if ($0) {
                self.presentationMode.wrappedValue.dismiss()
            }
        }
    }
}

