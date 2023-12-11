//
//  HouseholdView.swift
//  ITU
//
//  Created by Никита Моисеев on 30.11.2023.
//

import SwiftUI

struct HouseholdView: View {
    @StateObject var viewModel = HouseholdViewModel()
    
    var body: some View {
        if let household = viewModel.currentUser?.household {
            ScrollView(.vertical, showsIndicators: false) {
                VStack(spacing: 20) {
                    VStack(spacing: 12) {
                        Text("Owner")
                            .font(.title)
                            .frame(maxWidth: .infinity, alignment: .leading)
                        
                        RoleGroup(role: .info) {
                            HStack() {
                                Image(systemName: "person.fill")
                                    .font(.system(size: 20))
                                Spacer()
                                
                                if let owner = household.user_created {
                                    let primary = !(owner.first_name.isEmpty || owner.last_name.isEmpty) ? "\(owner.first_name) \(owner.last_name)" : "\(owner.id)"
                                    
                                    let secondary = !owner.email.isEmpty ? "\(owner.email)" : nil
                                    
                                    VStack (alignment: .trailing, spacing: 2) {
                                        Text(primary)
                                            .font(.headline)
                                        
                                        if let secondaryText = secondary {
                                            Text(secondaryText)
                                                .font(.mono)
                                        }
                                    }
                                }
                            }
                        }
                    }
                    
                    Spacer()
                }
                .padding()
            }
            .navigationTitle("My Household")
            .navigationBarTitleDisplayMode(.inline)
            .onAppear {
                viewModel.getCurrentUser()
            }
        } else {
            noHousehold
        }
    }
    
    var noHousehold: some View {
        VStack (spacing: 24) {
            Image(systemName: "space")
                .font(.system(size: 60))
            
            Text("No household found")
                .textCase(.uppercase)
                .font(.title)
        }
        .foregroundColor(.grey200)
    }
}

#Preview {
    NavigationView {
        HouseholdView()
    }
}
