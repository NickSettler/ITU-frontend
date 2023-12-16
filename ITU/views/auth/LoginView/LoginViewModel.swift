//
//  LoginViewModel.swift
//  ITU
//
//  Created by Elena Marochkina
//

import Foundation
import SwiftUI

/// `LoginViewModel` is a class advised to handle user authorizations.
@MainActor class LoginViewModel : ObservableObject {

    /// User's credentials
    @Published var email: String = ""
    @Published var password: String = ""
    
    /// User's access and refresh tokens
    @AppStorage(E_AUTH_STORAGE_KEYS.ACCESS_TOKEN.rawValue) var access_token: String?
    @AppStorage(E_AUTH_STORAGE_KEYS.REFRESH_TOKEN.rawValue) var refresh_token: String?
    
    /// Function to process user sign in
    func signIn() {
        Task {
            if let res = await AuthService.signIn(email: email, password: password) {
                await MainActor.run {
                    self.access_token = res.data.access_token
                    self.refresh_token = res.data.refresh_token
                }
            } else {
                print("Error during login")
            }
        }
    }
}
