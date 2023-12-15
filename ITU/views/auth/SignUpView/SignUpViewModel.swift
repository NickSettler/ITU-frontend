//
//  SignUpViewModel.swift
//  ITU
//
//  Created by Nikita Pasynkov,Elena Marochkina
//

import Foundation
import SwiftUI

@MainActor class SignUpViewModel : ObservableObject {
    @AppStorage(E_AUTH_STORAGE_KEYS.ACCESS_TOKEN.rawValue) var access_token: String?
    @AppStorage(E_AUTH_STORAGE_KEYS.REFRESH_TOKEN.rawValue) var refresh_token: String?
    
    @Published var email: String = ""
    @Published var password: String = ""
    @Published var lastName: String = ""
    @Published var firstName: String = ""
    
    @Published var isLoading: Bool = false
    
    
    var isRegisterButtonDisabled: Bool {
        get {
            return self.email.isEmpty ||
            self.firstName.isEmpty ||
            self.lastName.isEmpty ||
            self.password.isEmpty ||
            self.isLoading
        }
    }
    
    func signUp() {
        Task {
            self.isLoading = true
            
            if let res = await AuthService.signUp(
                email: email,
                password: password,
                firstName: firstName,
                lastName: lastName
            ) {
                await MainActor.run {
                    self.access_token = res.data.access_token
                    self.refresh_token = res.data.refresh_token
                }
                
                self.isLoading = false
            } else {
                print("Error during registration")
                
                self.isLoading = false
            }
        }
    }
}
