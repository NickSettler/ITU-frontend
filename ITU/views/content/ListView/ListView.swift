//
//  ListView.swift
//  ITU
//
//  Created by Никита Моисеев on 26.10.2023.
//

import SwiftUI

struct ListView: View {
    @AppStorage("access_token") var access_token: String?
    
    var body: some View {
        List(allDrugs, id: \.id) { drug in
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
    ListView()
}
