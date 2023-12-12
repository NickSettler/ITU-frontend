//
//  FoldersView.swift
//  ITU
//
//  Created by Nikita Pasynkov, Elena Marochkina on 05.11.2023.
//

import SwiftUI

struct FoldersView: View {
    @Environment(\.editMode) var editMode
    
    @StateObject var viewModel = FoldersViewModel()
    
    var body: some View {
        GeometryReader { proxy in
            ScrollView(.vertical, showsIndicators: false) {
                VStack(spacing: 20) {
                    VStack (spacing: 16) {
                        Image(systemName: "folder")
                            .symbolEffect(
                                .bounce.up.byLayer,
                                value: viewModel.isAnimating
                            )
                            .font(.system(size: 52))
                            .onTapGesture {
                                withAnimation(.bouncy, completionCriteria: .logicallyComplete, {
                                    viewModel.isAnimating = true
                                }, completion: {
                                    viewModel.isAnimating = false
                                })
                            }
                        Text("Create folders to organize you drugs in different locations")
                            .font(.subheadline)
                            .multilineTextAlignment(.center)
                    }
                    .padding(.top, 12)
                    .padding(.horizontal, 64)
                    
                    List {
                        Section(header: Text("Folders")) {
                            Text("Create folder")
                                .foregroundStyle(Color.accentColor)
                                .onTapGesture {
                                    viewModel.isPresented = true
                                }
    
                            Text("All")
                            
                            ForEach($viewModel.folders, id: \.id) { $folder in
                                NavigationLink {
                                    FolderSheet(currentFolder: $folder)
                                } label: {
                                    HStack {
                                        Image(systemName: folder.icon ?? "")
                                            .foregroundColor(Color.TextColorPrimary)
                                            .padding(4)
                                            .frame(
                                                width: 32,
                                                height: 32
                                            )
                                        Text(folder.name)
                                    }
                                }
                            }
                            .onDelete {
                                viewModel.handleDelete(offsets: $0)
                            }
                            .onMove {
                                viewModel.handleMove(a: $0, b: $1)
                            }
                            .scrollContentBackground(.hidden)
                            .scrollDisabled(true)
                        }
                        .listRowBackground(Color.gray.opacity(0.1))
                    }
                    .frame(
                        width: proxy.size.width - 5,
                        height: proxy.size.height - 50,
                        alignment: .center
                    )
                    .listStyle(.insetGrouped)
                    .scrollContentBackground(.hidden)
                }
            }
        }
        .sheet(isPresented: $viewModel.isPresented) {
            FolderSheet(currentFolder: .constant(Folder.empty))
        }
        .onChange(of: editMode?.wrappedValue, initial: false) {
            if ($0 == .active && $1 == .inactive) {
                viewModel.handleSaveChanges()
            }
        }
        .onReceive(viewModel.$isPresented) {
            if(!$0) {
                viewModel.getAllUserFolders()
            }
        }
        .padding(.vertical, 36)
        .toolbar {
            ToolbarItem(placement: .topBarTrailing) {
                EditButton()
            }
        }
        .navigationTitle("Folders")
        .navigationBarTitleDisplayMode(.inline)
        .onAppear {
            viewModel.getAllUserFolders()
            
            withAnimation(.smooth, completionCriteria: .logicallyComplete, {
                viewModel.isAnimating = true
            }, completion: {
                viewModel.isAnimating = false
            })
        }
    }
}

#Preview {
    NavigationStack {
        FoldersView()
    }
}
