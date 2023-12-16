//
//  ContentView.swift
//  ITU
//
//  Created by Nikita Moiseev
//

import SwiftUI

/// `ContentView` decides which view to present based on whether the user is authenticated or not.
struct ContentView: View {
    // Access token from the AppStorage
    @AppStorage(E_AUTH_STORAGE_KEYS.ACCESS_TOKEN.rawValue) var access_token: String?
    
    /// Defines the view structure.
    var body: some View {
        // If the user is not authenticated, an `AuthView` is shown allowing the user to authenticate.
        if access_token == nil {
            AuthView()
                .transition(
                    .move(edge: .top).animation(.easeInOut)
                    .combined(with: .opacity.animation(.easeInOut))
                )
        } else {
            // If the user is authenticated, a `MainView` is shown which likely contains the main content of your app.
            MainView()
                .transition(.opacity)
        }
    }
}

// Preview of the `ContentView`.
#Preview {
    ContentView()
}
