//
//  AuthViewModel.swift
//  ITU
//
//  Created by Nikita Moiseev
//

import SwiftUI
import Foundation

/// `AuthViewModel` is the main view model for `AuthView`, which manages and publishes authentication-related states.
@MainActor class AuthViewModel: ObservableObject {

    /// A boolean state published to represent whether to show the signup view.
    @Published var showSignup: Bool = false
    /// A boolean state published to represent the keyboard visibility for managing UI changes.
    @Published var isKeyboardShowing: Bool = false
    
    /// A string state for storing and retrieving the access token from AppStorage.
    @AppStorage(E_AUTH_STORAGE_KEYS.ACCESS_TOKEN.rawValue) var accessToken: String?
}
