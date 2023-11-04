//
//  SettingsView.swift
//  ITU
//
//  Created by Никита Моисеев on 04.11.2023.
//

import SwiftUI

struct SettingsView: View {
    @AppStorage(E_AUTH_STORAGE_KEYS.ACCESS_TOKEN.rawValue) private var accessToken: String?
    
    var body: some View {
        Button {
            withAnimation {
                accessToken = nil
            }
        } label: {
            Text("Log out")
        }
    }
}

#Preview {
    SettingsView()
}
