//
//  HouseholdAddSheetModel.swift
//  ITU
//
//  Created by Никита Моисеев on 11.12.2023.
//

import Foundation
import Combine
import SwiftUI

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
    
    func addUser() {
        let isOnlyUser = foundUsers.count == 1 && foundUsers[0].email == searchEmail
        
        if foundCorrectUser {
            self.addMemberID.wrappedValue = foundUsers[0].id
        }
    }
}
