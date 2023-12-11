//
//  SettingsViewModel.swift
//  ITU
//
//  Created by Никита Моисеев on 11.12.2023.
//

import Foundation

@MainActor final class SettingsViewModel : ObservableObject {
    @Published var currentUser: User?
    
    func handleAppear() {
        Task {
            self.currentUser = await UsersService.getCurrentUser()?.data
        }
    }
}
