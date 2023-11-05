//
//  ListView.swift
//  ITU
//
//  Created by Nikita Moiseev on 04.11.2023.
//

import SwiftUI

struct ListView: View {
    @ObservedObject private var viewModel: ListViewModel
    
    @Binding var drugs: [Drug]
    
    init(drugs: Binding<[Drug]>, folderID: String) {
        print(drugs.wrappedValue)
        self._drugs = drugs
        self._viewModel = ObservedObject(initialValue: ListViewModel(drugs: drugs, folderID: folderID))
    }
    
    var body: some View {
        VStack {
            List {
                ForEach(self.drugs, id: \.id) { drug in
                    NavigationLink {
                        DrugView()
                    } label: {
                        HStack (alignment: .top, spacing: 4) {
                            Image(systemName: "pill")
                                .font(.headline)
                            
                            VStack (alignment: .leading, spacing: 4) {
                                Text(drug.name)
                                    .font(.headline)
                                Text(drug.complement ?? "")
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
