//
//  FoldersView.swift
//  ITU
//
//  Created by Nikita Pasynkov on 05.11.2023.
//

import SwiftUI

struct FoldersView: View {
    @ObservedObject private var viewModel = FoldersViewModel()
    
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
                                    viewModel.isSheetVisible = true
                                }
                            
                            ForEach(tabs, id: \.self) { tab in
                                Text(tab)
                            }
                            .onDelete(perform: { _ in
                                //
                            })
                            .onMove(perform: { _,_  in
                                //
                            })
                            .scrollContentBackground(.hidden)
                            .scrollDisabled(true)
                        }
                        .listRowBackground(Color.gray.opacity(0.1))
                    }
                    .listStyle(.insetGrouped)
                    .background(Color.clear)
                    .scrollContentBackground(.hidden)
                    .frame(
                        width: proxy.size.width - 5,
                        height: proxy.size.height - 15,
                        alignment: .center
                    )
                }
            }
        }
        .sheet(isPresented: $viewModel.isSheetVisible) {
            FolderSheet()
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
