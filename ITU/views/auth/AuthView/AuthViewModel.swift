//
//  AuthViewModel.swift
//  ITU
//
//  Created by Nikita Moiseev
//

import SwiftUI
import Foundation

@MainActor class AuthViewModel: ObservableObject {
    @Published var showSignup: Bool = false
    @Published var isKeyboardShowing: Bool = false
    
    @AppStorage(E_AUTH_STORAGE_KEYS.ACCESS_TOKEN.rawValue) var accessToken: String?
}
