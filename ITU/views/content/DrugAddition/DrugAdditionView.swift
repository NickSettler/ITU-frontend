//
//  DrugAdditionView.swift
//  ITU
//
//  Created by Nikita on 25.11.2023.
//

import SwiftUI
import Combine

struct DrugAdditionView: View {
    @Environment (\.dismiss) var dismiss
    
    @StateObject var viewModel = DrugAdditionViewModel()
    
    init() {
        self._viewModel = StateObject(wrappedValue: DrugAdditionViewModel())
    }
    
    init(drug: Binding<Drug>) {
        self._viewModel = StateObject(wrappedValue: DrugAdditionViewModel(drug: drug))
    }
    
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
                        value: $viewModel.strengthNumber
                    ).keyboardType(.numberPad)
                        .onReceive(Just(viewModel.strengthNumber)) { newValue in
                            let filtered = newValue.filter { "0123456789".contains($0) }
                            if filtered != newValue {
                                self.viewModel.strengthNumber = filtered
                            }
                        }
                    
                    
                    Picker("Dosage", selection: $viewModel.selectedDosage) {
                        ForEach(drugDosage.allCases) { option in
                            Text(String(describing: option)).tag(option)
                        }
                    }
                    
                    CustomTextField(
                        hint: "Count",
                        value: $viewModel.countNumber
                    ).keyboardType(.numberPad)
                        .onReceive(Just(viewModel.countNumber)) { newValue in
                            let filtered = newValue.filter { "0123456789".contains($0) }
                            if filtered != newValue {
                                self.viewModel.countNumber = filtered
                            }
                        }
                    
                    Picker("Count", selection: $viewModel.selectedMeasurement) {
                        ForEach(countMeasurement.allCases) { option in
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

                GradientButton(title: viewModel.mode == .create ? "Add" : "Save", fullWidth: true) {
                    viewModel.save()
                }
                .disabled(viewModel.createdDrug.name.isEmpty || viewModel.countNumber.isEmpty)
                .padding(.top, 64)
            }
            .padding()
            .toolbar {
                ToolbarItem(placement: .topBarLeading) {
                    Button {
                        self.dismiss()
                    } label: {
                        Text("Close")
                    }
                }
            }
        }
        .presentationDetents([.large])
        .onReceive(viewModel.$didRequestComplete) {
            if ($0) {
                self.dismiss()
            }
        }
    }
}

#Preview {
    DrugAdditionView()
}
