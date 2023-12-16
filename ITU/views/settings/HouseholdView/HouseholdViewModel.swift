//
//  HouseholdViewMode.swift
//  ITU
//
//  Created by Nikita Pasynkov
//

import Foundation

/// `HouseholdViewModel` is a class designed to manage and provide data for the HouseholdView,
/// includes methods for managing members of the household, making network requests to fetch, add, delete members,
/// and handling transfer of household ownership.
@MainActor final class HouseholdViewModel : ObservableObject {
    @Published var currentUser: User? = .init(id: "")
    @Published var addMemberID: String?
    
    // Various computed properties providing details based on the currentUser info, such as household and owner info, and if the view should show the add member sheet etc.
    var currentUserID: String? { self.currentUser?.id }
    var currentUserIDRequired: String { self.currentUser?.id ?? ""}
    var currentUserHousehold: Household? { self.currentUser?.household }
    var hasOwner: Bool { currentUserHousehold?.user_created != nil }
    var ownerPrimaryText: String {
        let owner = currentUserHousehold?.user_created
        
        guard let firstName = owner?.first_name else {
            return owner?.id ?? ""
        }
        guard let lastName = owner?.last_name else {
            return firstName
        }
        
        return "\(firstName) \(lastName)"
    }
    
    var ownerSecondaryText: String? {
        return currentUserHousehold?.user_created?.email
    }
    
    var isCurrentUserOwner: Bool {
        guard let ownerID = currentUserHousehold?.user_created?.id,
              let currentUserID = currentUserID else {
            return false
        }
        
        return ownerID == currentUserID
    }
    
    var addSheetVisible: Bool {
        get {
            guard let addMemberID = addMemberID else {
                return false
            }
            
            return addMemberID.isEmpty
        }
        set { addMemberID = nil }
    }
    
    var addMemberIDRequired: String {
        get { return addMemberID ?? "" }
        set { addMemberID = newValue }
    }
    
    /// Fetches the current user details from server using the UsersService.
    func getCurrentUser() {
        Task {
            self.currentUser = await UsersService.getCurrentUser()?.data
        }
    }
    
    /// Makes a network request to about creating a new household.
    func createHousehold() {
        Task {
            guard let uid = currentUser?.id else {
                return
            }
            
            _ = await HouseholdService.create(uid)
            
            self.getCurrentUser()
        }
    }

    /// If the member id is valid and the member is not already a part of the household, then a network request is made to add the member.
    /// After the request, it fetches the updated user info from the server.
    func addMember() {
        Task {
            guard let householdID = currentUser?.household?.id,
                  let addMemberID = addMemberID,
                  let members = currentUser?.household?.members else {
                return
            }
            
            if addMemberID.isEmpty || !matchesUUIDv4Regex(addMemberID) {
                return
            }
            
            var newMembers = members.map { $0.id }
            newMembers.append(addMemberID)
            
            _ = await HouseholdService.update(
                householdID,
                parameters: [
                    "members": newMembers
                ]
            )
            
            self.getCurrentUser()
            
            self.addMemberID = nil
        }
    }

    /// If the member to be removed is part of the current household, makes a network request to remove the member from the household.
    /// After the request, it fetches the updated user info from the server.
    func removeMember(_ mid: String) {
        Task {
            guard let householdID = currentUser?.household?.id,
                  let members = currentUser?.household?.members else {
                return
            }
            
            if mid.isEmpty || !matchesUUIDv4Regex(mid) {
                return
            }
            
            var newMembers = members
                .filter{ $0.id != mid }
                .map{ $0.id }
            
            _ = await HouseholdService.update(
                householdID,
                parameters: [
                    "members": newMembers
                ]
            )
            
            self.getCurrentUser()
            
            self.addMemberID = nil
        }
    }

/// If the new owner id is valid, makes a network request to transfer the ownership of the household to the new owner.
/// After the request, it fetches the updated user info from the server.
    func transfer(_ newOwnerID: String) {
        Task {
            guard let householdID = currentUser?.household?.id else {
                return
            }
            
            if newOwnerID.isEmpty || !matchesUUIDv4Regex(newOwnerID) {
                return
            }
            
            _ = await HouseholdService.update(
                householdID,
                parameters: [
                    "user_created": newOwnerID
                ]
            )
            
            self.getCurrentUser()
            
            self.addMemberID = nil
        }
    }

    /// Makes a network request to delete the current household. After the request, it fetches the updated user info from the server.
    func deleteHousehold() {
        Task {
            guard let householdID = currentUser?.household?.id else {
                return
            }
            
            await HouseholdService.delete(householdID)
            
            self.getCurrentUser()
        }
    }
}
