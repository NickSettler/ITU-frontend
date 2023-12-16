//
//  HouseholdAddSheet.swift
//  ITU
//
//  Created by Nikita Pasynkov
//

import SwiftUI

/// `HouseholdAddSheet` is a view representing a sheet for adding a new user to a household by searching for their email.
struct HouseholdAddSheet: View {

    // ViewModel for managing and providing data
    @StateObject var viewModel: HouseholdAddSheetModel
    
    @Environment(\.presentationMode) var presentationMode
    
    /// Initializes a new instance of `HouseholdAddSheet` with a `Binding` representing the new member ID.
    init(memberID: Binding<String>) {
        self._viewModel = StateObject(wrappedValue: HouseholdAddSheetModel(memberID: memberID))
    }
    
    /// The body of `HouseholdAddSheet`.
    var body: some View {
        NavigationStack {
            VStack() {
                VStack(alignment: .leading, spacing: 16) {
                    CustomTextField(
                        sfIcon: "at",
                        hint: "E-Mail",
                        type: .email,
                        value: $viewModel.searchEmail
                    )
                    .onChange(of: viewModel.debouncedSearchEmail) {
                        viewModel.search(query: $0)
                    }
                    
                    
                    if viewModel.searched {
                        if !viewModel.foundCorrectUser {
                            Text("No users with \"\(viewModel.searchEmail)\" email found")
                                .font(.callout.smallCaps())
                                .foregroundStyle(Color.Quaternary500)
                        } else if !viewModel.newUserHasNoHousehold {
                            Text("User already has a household")
                                .font(.callout.smallCaps())
                                .foregroundStyle(Color.Quaternary500)
                        } else {
                            Text("User found")
                                .font(.callout.smallCaps())
                                .foregroundStyle(Color.Primary500)
                        }
                    }
                }
                
                Spacer()
                
                GradientButton(
                    title: "Add user",
                    fullWidth: true,
                    disabled: !(viewModel.searched && viewModel.foundCorrectUser && viewModel.newUserHasNoHousehold)
                ) {
                    viewModel.addUser()
                }
            }
            .padding()
            .toolbar {
                ToolbarItem(placement: .topBarTrailing) {
                    Button {
                        self.presentationMode.wrappedValue.dismiss()
                    } label: {
                        Text("Close")
                    }
                }
            }
        }
        .presentationDetents([.medium, .large])
    }
}

#Preview {
    HouseholdAddSheet(memberID: .constant(""))
}
