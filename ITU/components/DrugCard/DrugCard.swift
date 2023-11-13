//
//  DrugCard.swift
//  ITU
//
//  Created by Никита Моисеев on 06.11.2023.
//

import SwiftUI

struct DrugCard: View {
    @Binding var drug: Drug
    var expDate: Date

    init(drug: Binding<Drug>, expDate: Date = Calendar.current.date(from: DateComponents(year: 2022, month: 12, day: 23)) ?? Date()) {
        self._drug = drug
        self.expDate = expDate
    }

    var body: some View {
        let currentDate = Date()
        let sixMonthsFromNow = Calendar.current.date(byAdding: .month, value: 6, to: currentDate) ?? Date()

        let rectangleColor: (Color, Color, Color)
        if expDate < currentDate {
            rectangleColor = (Color.Quaternary300, Color.Quaternary400, Color.Quaternary600)
        } else if expDate < sixMonthsFromNow {
            rectangleColor = (Color.Secondary100, Color.Secondary200, Color.Secondary400)
        } else {
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
                        Text("exp. date: 12/2023")
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
