//
//  AuthViewModel.swift
//  ITU
//
//  Created by Никита Моисеев on 22.10.2023.
//

import SwiftUI
import Foundation

@MainActor class AuthViewModel: ObservableObject {
    @Published var showSignup: Bool = false
    @Published var isKeyboardShowing: Bool = false
}
