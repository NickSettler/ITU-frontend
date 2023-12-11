//
//  HouseholdViewMode.swift
//  ITU
//
//  Created by Никита Моисеев on 30.11.2023.
//

import Foundation

@MainActor final class HouseholdViewModel : ObservableObject {
    @Published var currentUser: User? = .init(id: "ABABBA")
    
    func getCurrentUser() {
        Task {
            if let currentUser = await UsersService.getCurrentUser() {
                print(currentUser.data)
            }
        }
    }
}
