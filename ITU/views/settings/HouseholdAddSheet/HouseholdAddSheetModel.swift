//
//  HouseholdAddSheetModel.swift
//  ITU
//
//  Created by Nikita Pasynkov
//

import Foundation
import Combine
import SwiftUI

/// `HouseholdAddSheetModel` is a class designed to manage and provide data for the HouseholdAddSheet view.
@MainActor final class HouseholdAddSheetModel : ObservableObject {
    @Published var searched: Bool = false
    @Published var searchEmail: String = ""
    @Published var debouncedSearchEmail: String = ""
    @Published var foundUsers: [User] = []
    var addMemberID: Binding<String>
    
    var foundCorrectUser: Bool {
        if !searched {
            return false
        }
        
        if foundUsers.count != 1 {
            return false
        }
        
        return foundUsers[0].email == searchEmail
    }
    
    var newUserHasNoHousehold: Bool {
        if !foundCorrectUser { return false }
        
        return foundUsers[0].household == nil
    }
    
    private var bag = Set<AnyCancellable>()
    
    /// Initializes a new instance of `HouseholdAddSheetModel` with a `Binding` representing the new member ID, and a debouncing delay time.
    init(memberID: Binding<String>, dueTime: TimeInterval = 0.5) {
        self.addMemberID = memberID
        $searchEmail
            .removeDuplicates()
            .debounce(for: .seconds(dueTime), scheduler: DispatchQueue.main)
            .sink(receiveValue: { [weak self] value in
                self?.debouncedSearchEmail = value
            })
            .store(in: &bag)
    }
    
    /// Searches for users whose emails match the provided query using the UsersService.
    ///
    /// - Parameters:
    ///     - query: The query to search for.
    func search(query: String) {
        Task {
            if query.isEmpty {
                self.searched = false
            }
            
            if let foundUsers = await UsersService.search(query: query)?.data {
                self.foundUsers = foundUsers
            }
            
            self.searched = true
        }
    }

    /// Adds the user found by email to the household.
    func addUser() {
        let isOnlyUser = foundUsers.count == 1 && foundUsers[0].email == searchEmail
        
        if foundCorrectUser {
            self.addMemberID.wrappedValue = foundUsers[0].id
        }
    }
}
