//
//  DrugButton.swift
//  ITU
//
//  Created by Nikita Moiseev
//

import SwiftUI

/// Drug button color enum
enum DRUG_BUTTON_COLOR : Int, Codable {
    case success = 0
    case warning = 1
    case error = 2
    case info = -1
    
    var color: [Color] {
        get {
            switch (self) {
            case .error:
                return [.Quaternary200, .Quaternary600, .Quaternary600]
            case .warning:
                return [.Secondary100, .Secondary500, .Secondary600]
            case .success:
                return [.Primary100, .Primary500, .Primary600]
            case .info:
                return [.Tertiary200, .Tertiary600, .Tertiary700]
            }
        }
    }
}

/// Drug button component
struct DrugButton: View {
    var title: String
    var color: DRUG_BUTTON_COLOR = .success
    var icon: String?
    var fullWidth: Bool = false
    var disabled: Bool = false
    var onClick: () -> ()
    
    var backgroundColor: Color {
        return color.color[0]
    }
    
    var textColor: Color {
        return color.color[1]
    }
    
    var iconColor: Color {
        return color.color[2]
    }
    
    var body: some View {
        Button {
            if !disabled {
                onClick()
            }
        } label: {
            HStack(alignment: .center) {
                if let icon = self.icon {
                    Image(systemName: icon)
                        .foregroundStyle(iconColor)
                        .font(.system(size: 14))
                }
                
                Text("\(title)")
                    .foregroundStyle(textColor)
            }
            .if(fullWidth) {
                $0.frame(maxWidth: .infinity)
            }
            .disabled(disabled)
            .textCase(.uppercase)
            .fontWeight(.bold)
            .padding(.vertical, 8)
            .padding(.horizontal, 16)
            .background(
                RoundedRectangle(cornerRadius: 8)
                    .fill(backgroundColor)
            )
        }
    }
}

#Preview {
    VStack {
        VStack {
            DrugButton(title: "Click", icon: "house.fill", fullWidth: true) {
                //
            }
        }
        .padding(.horizontal)
        
        ScrollView(.horizontal, showsIndicators: false) {
            HStack {
                DrugButton(title: "Update", icon: "house.fill") {
                    //
                }
                DrugButton(title: "Refill", color: .info, icon: "house.fill") {
                    //
                }
                DrugButton(title: "Remove", color: .warning, icon: "house.fill") {
                    //
                }
                DrugButton(title: "Delete", color: .error, icon: "house.fill") {
                    //
                }
            }
            .padding(.horizontal)
        }
    }
}
