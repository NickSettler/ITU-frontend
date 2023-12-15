//
//  DrugMoveSheet.swift
//  ITU
//
//  Created by Никита Моисеев on 15.12.2023.
//

import SwiftUI

struct DrugMoveSheet: View {
    @Environment (\.dismiss) var dismiss
    
    @StateObject private var viewModel: DrugMoveSheetModel
    
    init(drugID: Int, currentFolder: Folder) {
        self._viewModel = StateObject(
            wrappedValue: DrugMoveSheetModel(
                drugID: drugID,
                currentFolder: currentFolder
            )
        )
    }
    
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

#Preview {
    NavigationStack {
        DrugMoveSheet(drugID: -1, currentFolder: .empty)
    }
}
