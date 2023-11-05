//
//  ListView.swift
//  ITU
//
//  Created by Никита Моисеев on 04.11.2023.
//

import SwiftUI

struct ListView: View {
    var body: some View {
        List(allDrugs, id: \.id) { drug in
            NavigationLink {
                DrugView()
            } label: {
                HStack (alignment: .top, spacing: 4) {
                    Image(systemName: "pill")
                        .font(.headline)
                    
                    VStack (alignment: .leading, spacing: 4) {
                        Text(drug.name)
                            .font(.headline)
                        Text(drug.complement)
                            .font(.subheadline)
                    }
                }
            }
        }
        .listStyle(.inset)
    }
}

#Preview {
    ListView()
}
