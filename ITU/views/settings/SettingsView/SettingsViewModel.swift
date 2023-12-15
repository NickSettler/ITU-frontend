//
//  SettingsViewModel.swift
//  ITU
//
//  Created by Nikita Pasynkov
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
