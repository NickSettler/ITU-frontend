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
            HStack(spacing: 4) {
                Spacer()
                
                Text("exp. date:")
                
                Text(
                    drug.expiration_date.formatted(
                        .dateTime.month(.twoDigits).year()
                    )
                )
            }
            .font(.caption)
            .foregroundColor(rectangleColor.2)
            .padding(.vertical, 12)
            .padding(.horizontal, 10)
            .background(
                LinearGradient(
                    gradient: Gradient(colors: [rectangleColor.0, rectangleColor.1]),
                    startPoint: .leading,
                    endPoint: .trailing
                )
            )
            
            VStack(spacing: 12) {
                HStack(alignment: .firstTextBaseline) {
                    Text(drug.name)
                        .font(.headline)
                        .foregroundStyle(Color.Grey700)
                        .multilineTextAlignment(.leading)
                    
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
        .clipShape(RoundedRectangle(cornerRadius: 8))
        .shadow(color: .grey500.opacity(0.12), radius: 20, x: 0, y: 2)
        .shadow(color: .grey700.opacity(0.08), radius: 8, x: 0, y: 1)
    }
}


#Preview {
    CommonListView(size: .zero, safeArea: .init(.zero))
}
