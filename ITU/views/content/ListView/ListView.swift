//
//  ListView.swift
//  ITU
//
//  Created by Nikita Moiseev on 04.11.2023.
//

import SwiftUI

struct ListView: View {
    @Namespace var animation
    
    @Binding var drugs: [Drug]
    
    @ObservedObject var viewModel = ListViewModel(drugs: .constant([]), folderID: "")
    
    init(drugs: Binding<[Drug]>, folderID: String) {
        self._drugs = drugs
        self._viewModel = ObservedObject(wrappedValue: ListViewModel(drugs: drugs, folderID: folderID)
        )
    }
    
    var body: some View {
        ScrollView(.vertical) {
            ForEach(self.viewModel.filteredDrugs.indices, id: \.self) { index in
                let drug = self.$viewModel.filteredDrugs[index]
                NavigationLink {
                    DrugView(drug: drug)
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
    }
}

#Preview {
    CommonListView(size: .zero, safeArea: .init(.zero))
}
