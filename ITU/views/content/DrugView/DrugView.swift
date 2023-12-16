//
//  DrugView.swift
//  ITU
//
//  Created by Nikita Moiseev
//

import SwiftUI

/// `DrugView` is a view representing the detail information about a drug.
struct DrugView: View {

    /// Bindings to `Drug` object and visibility state of the drug view
    @Binding var drug: Drug
    @Binding var drugViewVisible: Bool
    
    /// `dismiss` environment variable used for dismissing the view
    @Environment(\.dismiss) var dismiss
    
    /// Body of `DrugView`.
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

// Represents `DrugView` with first drug from `allDrugs` and `drugViewVisible` as true
#Preview {
    NavigationView {
        DrugView(drug: .constant(allDrugs[0]), drugViewVisible: .constant(true))
    }
}
