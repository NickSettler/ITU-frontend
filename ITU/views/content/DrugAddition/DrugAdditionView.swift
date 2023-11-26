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
    
    var body: some View {
        NavigationStack {
            VStack {
                CustomTextField(
                    sfIcon: "textformat.size.larger",
                    hint: "Name",
                    value: $viewModel.createdDrug.name
                )
                .padding(.top, 32)
                
                HStack {
                    CustomTextField(
                        hint: "Dose",
                        value: $viewModel.strengthNumber
                    )
                    
                    Picker("Dosage", selection: $viewModel.selectedDosage) {
                        ForEach(DrugAdditionViewModel.drugDosage.allCases) { option in
                            Text(String(describing: option)).tag(option)
                        }
                    }
                    
                    CustomTextField(
                        hint: "Count",
                        value: $viewModel.countNumber
                    )
                    
                    Picker("Count", selection: $viewModel.selectedMeasurement) {
                        ForEach(DrugAdditionViewModel.countMeasurement.allCases) { option in
                            Text(String(describing: option)).tag(option)
                        }
                    }
                }
                .padding(.top, 24)
                
                DatePicker(
                    "Expiration date",
                    selection: $viewModel.createdDrug.expiration_date,
                    displayedComponents: .date
                )
                .padding(.top, 24)
                
                Picker("Form", selection: $viewModel.selectedForm) {
                    Text("Tableta").tag("TBL NOB")
                    Text("Tobolka").tag("CPS")
                    Text("Injekce").tag("INJ")
                    Text("Sirup").tag("SIR")
                    Text("Suspenze").tag("SUS")
                    Text("Roztok").tag("SOL")
                    Text("Krém").tag("CRM")
                    Text("Mast").tag("UNG")
                    Text("Gel").tag("GEL")
                    Text("Prášek").tag("PLV")
                    Text("Inhaler").tag("INH")
                    Text("Čípek").tag("SUP")
                    Text("Pastilka").tag("PAS")
                    Text("Kapky").tag("GTT")
                    Text("Sprej").tag("SPR")
                }
                .padding(.horizontal, -12)
                .pickerStyle(.inline)
                .frame(maxWidth: .infinity, minHeight: 120)
       
                Spacer()
                
                
                GradientButton(title: "Add", fullWidth: true) {
                    if (viewModel.strengthNumber != "" && viewModel.countNumber != "") {
                        viewModel.countBinding = "\(viewModel.countNumber) \(viewModel.selectedMeasurement.rawValue)"
                        viewModel.strengthBinding = "\(viewModel.strengthNumber) \(viewModel.selectedDosage.rawValue)"
                        viewModel.createdDrug.form!.form = viewModel.selectedForm
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

#Preview {
    DrugAdditionView()
}
