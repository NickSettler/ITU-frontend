//
//  DrugCard.swift
//  ITU
//
//  Created by Никита Моисеев on 06.11.2023.
//

import SwiftUI

struct DrugCard: View {
    @Binding var drug: Drug
    
    var body: some View {
        VStack(spacing: 0) {
            Rectangle()
                .fill(Color.colorPrimaryLight)
                .frame(height: 32)
            
            VStack(spacing: 12) {
                HStack {
                    Text(drug.name)
                        .font(.headline)
                        .foregroundStyle(Color.textColorPrimary)
                    
                    Spacer()
                    
                    Text("10 tablets")
                        .font(.caption)
                        .foregroundStyle(Color.textColorSecondary)
                }
                HStack {
                    Text("Tablets 100mg")
                        .font(.caption)
                        .foregroundStyle(Color.textColorSecondary)
                    
                    Spacer()
                    
                    Text("exp. date: 12/2023")
                        .font(.caption)
                        .foregroundStyle(Color.textColorSecondary)
                }
            }
            .padding(.horizontal, 16)
            .padding(.vertical, 12)
        }
        .background(Color.white)
        .clipShape(RoundedRectangle(cornerRadius: 12))
        .shadow(color: Color.textColorPrimary.opacity(0.05), radius: 8, x: 0, y: 4)
        .shadow(color: Color.textColorPrimary.opacity(0.1), radius: 24, x: 0, y: 4)
    }
}

#Preview {
    NavigationStack {
        List {
            ForEach(allDrugs, id: \.id) { drug in
                NavigationLink {
                    DrugView(drug: .constant(drug))
                } label: {
                    DrugCard(drug: .constant(drug))
                }
            }
            .listRowSeparator(.hidden)
        }
        .navigationTitle("Drug Card")
        .navigationBarTitleDisplayMode(.inline)
        .listRowSpacing(24)
        .listStyle(.inset)
    }
}
