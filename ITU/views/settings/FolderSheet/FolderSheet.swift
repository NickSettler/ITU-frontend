//
//  FolderSheet.swift
//  ITU
//
//  Created by Elena Marochkina
//

import SwiftUI
import SymbolPicker

struct FolderSheet: View {
    @Environment(\.presentationMode) var presentationMode
    
    @StateObject private var viewModel : FolderSheetViewModel
    
    init(currentFolder: Binding<Folder>) {
        _viewModel = StateObject(wrappedValue: FolderSheetViewModel(currentFolder: currentFolder))
    }
    
    var body: some View {
        NavigationStack {
            VStack {
                HStack{
                    CustomTextField(
                        sfIcon: "textformat.size.larger",
                        hint: "Name",
                        value: $viewModel.currentFolder.name
                    )
                    
                    Button {
                        viewModel.isSymbolPickerPresent = true
                    } label: {
                        Image(systemName: viewModel.currentFolder.icon ?? "")
                            .foregroundColor(Color.TextColorPrimary)
                            .padding(8)
                            .frame(
                                width: 48,
                                height: 48
                            )
                            .background {
                                RoundedRectangle(cornerRadius: 8)
                                    .strokeBorder(Color.TextColorSecondary, lineWidth: 2)
                            }
                    }
                    .sheet(isPresented: $viewModel.isSymbolPickerPresent) {
                        SymbolPicker(symbol: $viewModel.currentFolder.icon)
                    }
                }
                Spacer()
                
                GradientButton(title: "Save", fullWidth: true) {
                    if(viewModel.isCreate){
                        viewModel.createFolder()
                    } else {
                        viewModel.updateFolder()
                    }
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
        FoldersView()
    }
}
