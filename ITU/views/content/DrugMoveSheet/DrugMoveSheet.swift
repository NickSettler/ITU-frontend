//
//  DrugMoveSheet.swift
//  ITU
//
//  Created by Nikita Moiseev
//

import SwiftUI

/// `DrugMoveSheet` is a view presenting an UI to move the drug to a different folder.
struct DrugMoveSheet: View {

    /// `dismiss` environment variable used for dismissing the sheet
    @Environment (\.dismiss) var dismiss
    
    /// ViewModel for moving the drug
    @StateObject private var viewModel: DrugMoveSheetModel
    
    /// Initializer to create a new instance of `DrugMoveSheetModel` with provided `drugID` and `currentFolder`
    init(drugID: Int, currentFolder: Folder) {
        self._viewModel = StateObject(
            wrappedValue: DrugMoveSheetModel(
                drugID: drugID,
                currentFolder: currentFolder
            )
        )
    }
    
    /// Body of `DrugMoveSheet`.
    var body: some View {
        NavigationStack {
            VStack {
                Picker("Folder", selection: $viewModel.currentFolder.id) {
                    Text("None").tag(Folder.empty.id)
                    
                    ForEach(viewModel.userFolders, id: \.id) {
                        Text($0.name).tag($0.id)
                    }
                }
                .pickerStyle(.wheel)
                
                Spacer()
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
                ToolbarItem(placement: .topBarTrailing) {
                    Button {
                        viewModel.moveDrug()
                    } label: {
                        Text("Apply")
                    }
                }
            }
        }
        .onAppear {
            viewModel.getUserFolders()
        }
        .onReceive(viewModel.$didMoveComplete) {
            if $0 {
                self.dismiss()
            }
        }
        .presentationDetents([.medium])
    }
}

// Represents `DrugMoveSheet` with initial `drugID` as -1 and `currentFolder` as .empty
#Preview {
    NavigationStack {
        DrugMoveSheet(drugID: -1, currentFolder: .empty)
    }
}
