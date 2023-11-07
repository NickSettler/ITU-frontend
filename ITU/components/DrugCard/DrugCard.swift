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
            .padding(.horizontal, 20)
            .padding(.vertical, 16)
        }
        .background(Color.white)
        .clipShape(RoundedRectangle(cornerRadius: 12))
        .shadow(color: Color.textColorSecondary.opacity(0.15), radius: 8, x: 0, y: 1)
        .shadow(color: Color.textColorPrimary.opacity(0.05), radius: 12, x: 0, y: 2)
    }
}

#Preview {
    CommonListView(size: .zero, safeArea: .init(.zero))
}
