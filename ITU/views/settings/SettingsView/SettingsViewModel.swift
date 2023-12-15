//
//  SettingsViewModel.swift
//  ITU
//
//  Created by Elena Marochkina
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
