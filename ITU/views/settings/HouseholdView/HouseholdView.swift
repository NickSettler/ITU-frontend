//
//  HouseholdView.swift
//  ITU
//
//  Created by Nikita Pasynkov
//

import SwiftUI
import UniformTypeIdentifiers

/// `HouseholdView` is a view that shows the details of the user's household, including the owner and members. It also provides options to manage the household.
struct HouseholdView: View {
    @StateObject var viewModel = HouseholdViewModel()
    
    /// The body of `HouseholdView`.
    var body: some View {
        ZStack {
            // when a household exists
            if let household = viewModel.currentUser?.household {
                // scrollable list of household details
                ScrollView(.vertical, showsIndicators: false) {
                    VStack(spacing: 20) {
                        if viewModel.hasOwner {
                            // show owner details
                            VStack(spacing: 12) {
                                Text("Owner")
                                    .font(.title)
                                    .frame(maxWidth: .infinity, alignment: .leading)
                                
                                RoleGroup(role: .info) {
                                    HStack(spacing: 12) {
                                        Image(systemName: "person.fill")
                                            .font(.system(size: 20))
                                        
                                        VStack (alignment: .leading, spacing: 2) {
                                            Text(viewModel.ownerPrimaryText)
                                                .font(.headline)
                                            
                                            if let secondaryText = viewModel.ownerSecondaryText {
                                                Text(secondaryText)
                                                    .font(.mono)
                                            }
                                        }
                                        
                                        Spacer()
                                    }
                                }
                            }
                            .padding()
                        }
                        
                        // show member details
                        VStack(spacing: 12) {
                            Text("Members")
                                .font(.title)
                                .frame(maxWidth: .infinity, alignment: .leading)
                            
                            if !household.members.isEmpty {
                                ForEach(household.members, id: \.id) { member in
                                    let memberFirstName = member.first_name
                                    let memberLastName = member.last_name
                                    let memberEmail = member.email
                                    
                                    let memberPrimaryText = memberFirstName != nil ? "\(memberFirstName ?? "") \(memberLastName ?? "")" : member.id
                                    
                                    RoleGroup(role: .info) {
                                        HStack(spacing: 12) {
                                            Image(systemName: "person.fill")
                                                .font(.system(size: 20))
                                            
                                            VStack (alignment: .leading, spacing: 2) {
                                                Text(memberPrimaryText)
                                                    .font(.headline)
                                                
                                                Text("\(memberEmail)")
                                                    .font(.mono)
                                            }
                                            
                                            Spacer()
                                        }
                                    }
                                    .if(viewModel.currentUserIDRequired == member.id) {
                                        $0.contextMenu {
                                            Button(role: .destructive) {
                                                viewModel.removeMember(member.id)
                                            } label: {
                                                Label("Exclude", systemImage: "trash")
                                            }
                                        }
                                    }
                                    // context menus for household management
                                    .if(viewModel.isCurrentUserOwner) {
                                        $0.contextMenu {
                                            Button {
                                                UIPasteboard.general.setValue(
                                                    "\(memberEmail)",
                                                    forPasteboardType: UTType.plainText.identifier
                                                )
                                            } label: {
                                                Label("Copy email", systemImage: "at")
                                            }
                                            Button(role: .destructive) {
                                                viewModel.transfer(member.id)
                                            } label: {
                                                Label("Transfer ownership", systemImage: "person.fill.checkmark")
                                            }
                                            Button(role: .destructive) {
                                                viewModel.removeMember(member.id)
                                            } label: {
                                                Label("Exclude", systemImage: "trash")
                                            }
                                        }
                                    }
                                }
                            }
                        }
                        .padding()
                    }
                    
                    Spacer()
                }
                .refreshable {
                    viewModel.getCurrentUser()
                }
                .if(viewModel.isCurrentUserOwner) {
                    $0.toolbar {
                        ToolbarItem(placement: .topBarTrailing) {
                            Menu(content: {
                                Button {
                                    viewModel.addMemberID = ""
                                } label: {
                                    Text("Add member")
                                }
                                
                                Button(role: .destructive) {
                                    viewModel.deleteHousehold()
                                } label: {
                                    Text("Delete")
                                }
                            }, label: {
                                Image(systemName: "ellipsis")
                            })
                        }
                    }
                }
                .sheet(isPresented: $viewModel.addSheetVisible) {
                    HouseholdAddSheet(memberID: $viewModel.addMemberIDRequired)
                }
            } else {
                // view when no household exists
                noHousehold
            }
        }
        .navigationTitle("My Household")
        .navigationBarTitleDisplayMode(.inline)
        .onAppear {
            viewModel.getCurrentUser()
        }
        .onReceive(viewModel.$addMemberID) { _ in
            viewModel.addMember()
        }
    }
    
     // View for when no household exists:
    var noHousehold: some View {
        VStack (spacing: 48) {
            // information about missing household
            VStack (spacing: 12) {
                Image(systemName: "space")
                    .font(.system(size: 60))
                
                Text("No household found")
                    .textCase(.uppercase)
                    .font(.title)
            }
            
            // Button for creating a new household
            GradientButton(title: "CREATE") {
                viewModel.createHousehold()
            }
        }
        .foregroundColor(.grey200)
    }
}

#Preview {
    NavigationView {
        HouseholdView()
    }
}
