//
//  DrugToast.swift
//  ITU
//
//  Created by Никита Моисеев on 25.11.2023.
//

import SwiftUI

enum DrugToastRole : String {
    case success
    case warning
    case error
    case info
    
    var color: Color[] {
        get {
            switch (self) {
            case .error:
                return [.]
            }
        }
    }
}

struct DrugToast: View {
    let role: DrugToastRole = .success
    
    var body: some View {
        Text(/*@START_MENU_TOKEN@*/"Hello, World!"/*@END_MENU_TOKEN@*/)
    }
}

#Preview {
    DrugToast()
}
