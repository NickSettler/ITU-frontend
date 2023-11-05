//
//  FolderSheet.swift
//  ITU
//
//  Created by Nikita Pasynkov, Elena Marochkina on 05.11.2023.
//

import SwiftUI

struct FolderSheet: View {
    @Environment(\.presentationMode) var presentationMode
    
    @ObservedObject private var viewModel = FolderSheetViewModel()
    
    var body: some View {
        NavigationStack {
            VStack {
                CustomTextField(
                    sfIcon: "textformat.size.larger",
                    hint: "Name",
                    value: $viewModel.name
                )
                
                Spacer()
                
                GradientButton(title: "Create", fullWidth: true) {
                    viewModel.createFolder()
                }
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
    NavigationStack {
        FolderSheet()
    }
}
