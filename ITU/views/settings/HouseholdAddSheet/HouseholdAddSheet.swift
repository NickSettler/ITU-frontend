//
//  HouseholdAddSheet.swift
//  ITU
//
//  Created by Никита Моисеев on 11.12.2023.
//

import SwiftUI

struct HouseholdAddSheet: View {
    @StateObject var viewModel: HouseholdAddSheetModel
    
    @Environment(\.presentationMode) var presentationMode
    
    init(memberID: Binding<String>) {
        self._viewModel = StateObject(wrappedValue: HouseholdAddSheetModel(memberID: memberID))
    }
    
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
