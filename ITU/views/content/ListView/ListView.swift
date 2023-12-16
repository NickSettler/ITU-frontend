//
//  ListView.swift
//  ITU
//
//  Created by Nikita Moiseev
//

import SwiftUI

/// `ListView` is a view representing a list of drugs.
struct ListView: View {
    @Namespace var animation
    
    @Binding var drugs: [Drug]
    
    @ObservedObject var viewModel = ListViewModel(drugs: .constant([]), folderID: "")
    
    private(set) var refreshFunc: () -> Void
    
    /// Initializes a new instance of `ListView` with the provided binding to the drug list, folderID, and a function for refreshing data.
    init(drugs: Binding<[Drug]>, folderID: String, refreshFunc: @escaping () -> Void) {
        self._drugs = drugs
        self._viewModel = ObservedObject(wrappedValue: ListViewModel(drugs: drugs, folderID: folderID)
        )
        self.refreshFunc = refreshFunc
    }
    
    /// The body of `ListView`.
    var body: some View {
        // Displays a ScrollView containing a list of drugs with navigation links to `DrugView`.
        // Each item in the list is an instance of `DrugCard` view.
        if !self.viewModel.filteredDrugs.isEmpty {
            ScrollView(.vertical) {
                ForEach(self.viewModel.filteredDrugs.indices, id: \.self) { index in
                    let drug = self.$viewModel.filteredDrugs[index]
                    
                    NavigationLink {
                        DrugView(drug: drug, drugViewVisible: $viewModel.drugViewVisible)
                    } label: {
                        DrugCard(drug: drug)
                    }
                    .if(index == 0) {
                        $0.padding(.top, 20)
                    }
                    .padding(.horizontal)
                    .padding(.bottom, 24)
                }
            }
            .onReceive(viewModel.$drugViewVisible) {
                if !$0 {
                    self.refreshFunc()
                    viewModel.drugViewVisible = true
                }
            }
        } else {
            // Displays a VStack with a message and a refresh button, indicating that there are no drugs found in the folder.
            VStack (spacing: 48) {
                Spacer()
                
                VStack (spacing: 12) {
                    Image(systemName: "space")
                        .font(.system(size: 60))
                    
                    Text("No drugs found in the folder")
                        .multilineTextAlignment(.center)
                        .textCase(.uppercase)
                        .font(.title)
                }
                
                GradientButton(title: "REFRESH") {
                    self.refreshFunc()
                }
                
                Spacer()
            }
            .foregroundColor(.grey200)
        }
    }
}

#Preview {
    CommonListView(size: .zero, safeArea: .init(.zero))
}
