//
//  LoginViewModel.swift
//  ITU
//
//  Created by Nikita Moiseev
//

import Foundation
import SwiftUI

@MainActor class LoginViewModel : ObservableObject {
    @Published var email: String = ""
    @Published var password: String = ""
    
    @AppStorage(E_AUTH_STORAGE_KEYS.ACCESS_TOKEN.rawValue) var access_token: String?
    @AppStorage(E_AUTH_STORAGE_KEYS.REFRESH_TOKEN.rawValue) var refresh_token: String?
    
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
