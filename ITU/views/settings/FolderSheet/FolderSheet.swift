//
//  FolderSheet.swift
//  ITU
//
//  Created by Elena Marochkina
//

import SwiftUI
import SymbolPicker
import UIKit

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
                
                // Privacy Checkbox
                Toggle("Private", isOn: $viewModel.currentFolder.isPrivate)
                    .padding(.vertical, 32)
                
                // Description Field
                ZStack(alignment: .topLeading) {
                        TextEditorWithDynamicSize(
                            text: Binding(
                                get: { viewModel.currentFolder.description ?? "" },
                                set: { newValue in viewModel.currentFolder.description = newValue }
                                )
                            )
                                .cornerRadius(8)
                                .overlay(
                                    RoundedRectangle(cornerRadius: 4)
                                        .stroke(Color.gray, lineWidth: 1) // Border styling
                                        )
                        
                    }
                .frame(maxHeight: calculateTextHeight(viewModel.currentFolder.description ?? ""))
        
                
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

        }
        .presentationDetents([.medium])
        .onReceive(viewModel.$didRequestComplete) {
            if ($0) {
                self.presentationMode.wrappedValue.dismiss()
            }
        }
    }
}

private func calculateTextHeight(_ text: String) -> CGFloat {
        let font = UIFont.preferredFont(forTextStyle: .body)
        let constraintRect = CGSize(width: UIScreen.main.bounds.width - 32, height: .greatestFiniteMagnitude)
        let boundingBox = text.boundingRect(
            with: constraintRect,
            options: [.usesLineFragmentOrigin, .usesFontLeading],
            attributes: [.font: font],
            context: nil
        )
        return max(boundingBox.height + 16, 30) // Adjust as needed
    }

struct TextEditorWithDynamicSize: View {
    @Binding var text: String
    @State private var contentHeight: CGFloat = .zero

    var body: some View {
        ZStack(alignment: .topLeading) {
            TextEditor(text: $text)
                .frame(minHeight: 10, maxHeight: .infinity)
                .background(
                    GeometryReader { proxy in
                        Color.clear.preference(
                            key: ViewHeightKey.self,
                            value: proxy.size.height
                        )
                    }
                )
                .onPreferenceChange(ViewHeightKey.self) {
                    contentHeight = max($0, 10) // Adjust the minimum height as needed
                }
                .frame(maxWidth: .infinity, maxHeight: .infinity)
                .overlay(
                    VStack {
                        if text.isEmpty {
                            Text("Enter folder description")
                                .padding(.vertical, 8)
                                .foregroundColor(Color.gray.opacity(0.6))
                                .multilineTextAlignment(.center)
                        }
                    }
                    .frame(maxWidth: .infinity, maxHeight: .infinity)
                )
        }
    }
}

struct ViewHeightKey: PreferenceKey {
    static var defaultValue: CGFloat { 10 }
    static func reduce(value: inout CGFloat, nextValue: () -> CGFloat) {
        value = max(value, nextValue())
    }
}

#Preview {
    NavigationStack {
        FoldersView()
    }
}
