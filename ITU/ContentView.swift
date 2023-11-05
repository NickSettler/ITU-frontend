//
//  ContentView.swift
//  ITU
//
//  Created by Nikita Moiseev on 22.10.2023.
//

import SwiftUI

struct ContentView: View {
    @AppStorage(E_AUTH_STORAGE_KEYS.ACCESS_TOKEN.rawValue) var access_token: String?
    
    var body: some View {
        if access_token == nil {
            AuthView()
                .transition(
                    .move(edge: .top).animation(.easeInOut)
                    .combined(with: .opacity.animation(.easeInOut))
                )
        } else {
            MainView()
                .transition(.opacity)
        }
    }
}

#Preview {
    ContentView()
}
