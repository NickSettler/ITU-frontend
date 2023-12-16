//
//  DrugAdditionView.swift
//  ITU
//
//  Created by Nikita Moiseev
//

import SwiftUI
import Combine

/// `DrugAdditionView` is a view representing a form UI to add new drug to the list.
struct DrugAdditionView: View {

    /// `dismiss` environment variable used for dismissing the sheet
    @Environment (\.dismiss) var dismiss
    
    /// ViewModel for drug addition
    @StateObject var viewModel: DrugAdditionViewModel

    /// Initializers for creating or updating a drug
    /// - Parameters:
    ///     - selectedFolder: Selected `Folder` to add new drug
    ///     - drug: Binding to the drug data to update
    init(selectedFolder: Folder) {
        self._viewModel = StateObject(wrappedValue: DrugAdditionViewModel(selectedFolder: selectedFolder))
    }
    
    init(drug: Binding<Drug>) {
        self._viewModel = StateObject(wrappedValue: DrugAdditionViewModel(drug: drug))
    }
    
    /// Body of `DrugAdditionView`.
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
                    Text("Tablet").tag("TBL NOB")
                    Text("Capsule").tag("CPS")
                    Text("Injection").tag("INJ")
                    Text("Syrup").tag("SIR")
                    Text("Suspension").tag("SUS")
                    Text("Solution").tag("SOL")
                    Text("Cream").tag("CRM")
                    Text("Ointment").tag("UNG")
                    Text("Gel").tag("GEL")
                    Text("Powder").tag("PLV")
                    Text("Inhalation").tag("INH")
                    Text("Suppository").tag("SUP")
                    Text("Lozenges").tag("PAS")
                    Text("Drops").tag("GTT")
                    Text("Spray").tag("SPR")
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

// Represents `DrugAdditionView` with an `.allFolder` selected.
#Preview {
    DrugAdditionView(selectedFolder: .allFolder)
}
