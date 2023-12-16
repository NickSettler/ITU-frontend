//
//  SettingsViewModel.swift
//  ITU
//
//  Created by Elena Marochkina
//

import Foundation

/// `SettingsViewModel` is responsible for providing the data required by the `SettingsView`, including the current user.
/// It fetches the current user's data when the view appears.
@MainActor final class SettingsViewModel : ObservableObject {
    // The current user
    @Published var currentUser: User?
    
    /// Fetches the current user's information when the SettingsView appears, updates `currentUser` accordingly.
    func handleAppear() {
        Task {
            self.currentUser = await UsersService.getCurrentUser()?.data
        }
    }
}
