//
//  DrugView.swift
//  ITU
//
//  Created by Никита Моисеев on 04.11.2023.
//

import SwiftUI

struct DrugView: View {
    @State var scrollOffset: CGPoint = .zero
    @Environment(\.presentationMode) var presentationMode: Binding<PresentationMode>
    
    var body: some View {
        ScrollView {
            ZStack {
                VStack (alignment: .leading) {
                    HStack {
                        Text("General")
                            .font(.callout)
                            .textCase(.uppercase)
                        
                        Spacer()
                    }
                    .padding(.horizontal, 12)
                    .padding(.vertical, 2)
                    .background(.gray.opacity(0.4))
                    .foregroundStyle(Color.black.opacity(0.5))
                    
                    VStack (spacing: 8) {
                        VStack (spacing: 2) {
                            Text("Strength")
                                .font(.subheadline)
                                .frame(maxWidth: .infinity, alignment: .leading)
                            Text("PARACETAMOL AUROVITAS")
                                .font(.headline)
                                .frame(maxWidth: .infinity, alignment: .leading)
                        }
                        VStack (spacing: 2) {
                            Text("Name")
                                .font(.subheadline)
                                .frame(maxWidth: .infinity, alignment: .leading)
                            Text("PARACETAMOL AUROVITAS")
                                .font(.headline)
                                .frame(maxWidth: .infinity, alignment: .leading)
                        }
                    }
                    .padding(.horizontal, 12)
                    .padding(.vertical, 8)
                    
                    Spacer()
                }
            }
        }
        .navigationTitle("PARACETAMOL AUROVITAS")
        .navigationBarTitleDisplayMode(.inline)
        .frame(maxWidth: .infinity, maxHeight: .infinity)
    }
}

#Preview {
    NavigationView {
        DrugView()
    }
}
