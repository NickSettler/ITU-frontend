//
//  ListView.swift
//  ITU
//
//  Created by Никита Моисеев on 26.10.2023.
//

import SwiftUI

struct ListView: View {
    @Binding var drugs: [Drug]
    
    @AppStorage("access_token") var access_token: String?
    
    @StateObject private var viewModel = ListViewModel()
    
    var body: some View {
        List(self.drugs, id: \.id) { drug in
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
        .listStyle(.inset)
        .refreshable {
            //
        }
    }
}

#Preview {
    ListView(drugs: .constant(allDrugs))
}
