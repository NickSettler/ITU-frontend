//
//  DrugView.swift
//  ITU
//
//  Created by Nikita Moiseev
//

import SwiftUI

struct DrugView: View {
    @Binding var drug: Drug
    @Binding var drugViewVisible: Bool
    
    @Environment(\.dismiss) var dismiss
    
    var body: some View {
        GeometryReader {
            let size = $0.size
            let safeArea = $0.safeAreaInsets
            
            DrugViewInner(
                $drugViewVisible,
                size: size,
                safeArea: safeArea,
                drug: $drug
            )
        }
        .gesture(
            DragGesture(minimumDistance: 20, coordinateSpace: .global)
                .onChanged { value in
                    guard value.startLocation.x < 20, value.translation.width > 60 else {
                        return
                    }
                    
                    self.drugViewVisible = false
                    dismiss()
                }
        )
        .toolbar(.hidden)
        .navigationBarBackButtonHidden()
    }
}

#Preview {
    NavigationView {
        DrugView(drug: .constant(allDrugs[0]), drugViewVisible: .constant(true))
    }
}
