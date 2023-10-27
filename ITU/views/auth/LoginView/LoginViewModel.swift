//
//  LoginViewModel.swift
//  ITU
//
//  Created by Никита Моисеев on 26.10.2023.
//

import Foundation
import SwiftUI

@MainActor class LoginViewModel : ObservableObject {
    @Published var email: String = "moiseevnikita14@gmail.com"
    @Published var password: String = "JeWedu20"
    
    @AppStorage(E_AUTH_STORAGE_KEYS.ACCESS_TOKEN.rawValue) var access_token: String?
    
    func signIn() {
        Task {
            try await AuthService().signIn(
                email: email,
                password: password
            ) {r in
                switch r {
                case .success(let response):
                    DispatchQueue.main.async {
                        withAnimation {
                            self.access_token = response.data.access_token
                        }
                    }
                    break
                case .failure(let error):
                    print(error)
                    break
                }
            }
        }
    }
}
