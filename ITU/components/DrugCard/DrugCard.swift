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
        let rectangleColor: (Color, Color, Color)
        
        switch drug.expiry_state {
                case .expired:
                    rectangleColor = (Color.Quaternary300, Color.Quaternary400, Color.Quaternary600)
                case .soon:
                    rectangleColor = (Color.Secondary100, Color.Secondary200, Color.Secondary400)
                case .not:
                    rectangleColor = (Color.Primary100, Color.Primary200, Color.Primary500)
                }
        
        return VStack(spacing: 0) {
            Rectangle()
                .fill(
                    LinearGradient(
                        gradient: Gradient(colors: [rectangleColor.0, rectangleColor.1]),
                        startPoint: .leading,
                        endPoint: .trailing
                    )
                )
                .frame(height: 32)
                .overlay(
                    Text(drug.expiration_date)
                            .font(.caption)
                            .foregroundColor(rectangleColor.2)
                            .padding(.trailing, 8)
                            .frame(maxWidth: .infinity, alignment: .trailing)
                                )
            VStack(spacing: 12) {
                HStack {
                    Text(drug.name)
                        .font(.headline)
                        .foregroundStyle(Color.Grey700)

                    Spacer()

                    Text("10 tablets")
                        .font(.caption)
                        .foregroundStyle(Color.Grey400)

                }
                HStack {
                    Text("Tablets 100mg")
                        .font(.caption)
                        .foregroundStyle(Color.Grey300)

                    Spacer()

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
