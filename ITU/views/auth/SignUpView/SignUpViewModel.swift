//
//  SignUpViewModel.swift
//  ITU
//
//  Created by Nikita Pasynkov on 30.10.2023.
//

import Foundation
import SwiftUI

@MainActor class SignUpViewModel : ObservableObject {
    @Published var email: String = ""
    @Published var firstName: String = ""
    @Published var lastName: String = ""
    @Published var password: String = ""
    
    var isRegisterButtonDisabled: Bool {
        get {
            return self.email.isEmpty ||
            self.firstName.isEmpty ||
            self.lastName.isEmpty ||
            self.password.isEmpty
        }
    }
    
    func signUp() {
        Task {
            
        }
    }
}
