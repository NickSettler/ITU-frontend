//
//  ListView.swift
//  ITU
//
//  Created by Никита Моисеев on 04.11.2023.
//

import SwiftUI

struct ListView: View {
    @ObservedObject private var viewModel: ListViewModel
    
    init(drugs: Binding<[Drug]>, folderID: String) {
        self._viewModel = ObservedObject(initialValue: ListViewModel(drugs: drugs, folderID: folderID))
    }
    
    var body: some View {
        VStack {
            List {
                ForEach(self.$viewModel.drugs, id: \.id) { drug in
                    NavigationLink {
                        DrugView()
                    } label: {
                        HStack (alignment: .top, spacing: 4) {
                            Image(systemName: "pill")
                                .font(.headline)
                            
                            VStack (alignment: .leading, spacing: 4) {
                                Text(drug.name.wrappedValue)
                                    .font(.headline)
                                Text(drug.complement.wrappedValue ?? "")
                                    .font(.subheadline)
                            }
                        }
                    }
                }
            }
            .listStyle(.inset)
        }
    }
}

#Preview {
    ListView(
        drugs: .constant(allDrugs),
        folderID: ""
    )
}
