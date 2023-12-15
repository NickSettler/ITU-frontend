//
//  SettingsView.swift
//  ITU
//
//  Created by Elena Marochkina
//

import SwiftUI

struct SettingsView: View {
    @AppStorage(E_AUTH_STORAGE_KEYS.ACCESS_TOKEN.rawValue) private var accessToken: String?
    @AppStorage(E_AUTH_STORAGE_KEYS.REFRESH_TOKEN.rawValue) private var refreshToken: String?
    
    @StateObject var viewModel = SettingsViewModel()
    
    var body: some View {
        NavigationStack {
            VStack {
                List {
                    if let currentUser = viewModel.currentUser {
                        Section(header: Text("User Info")) {
                            VStack(alignment: .leading, spacing: 4) {
                                Text("\(currentUser.first_name ?? "") \(currentUser.last_name ?? "")")
                                    .font(.headline)
                                    .foregroundStyle(Color.grey700)
                                
                                Text("\(currentUser.email)")
                                    .font(.subheadline)
                                    .foregroundStyle(Color.grey300)
                            }
                        }
                    }
                    Section(header: Text("In-App Settings")) {
                        NavigationLink {
                            FoldersView()
                        } label: {
                            HStack(alignment: .center) {
                                Image(systemName: "folder")
                                Text("Folders")
                            }
                        }
                        
                        NavigationLink {
                            HouseholdView()
                        } label: {
                            HStack(alignment: .firstTextBaseline) {
                                Image(systemName: "house")
                                
                                VStack (alignment: .leading, spacing: 4) {
                                    Text("Household")
                                    
                                    if viewModel.currentUser?.household == nil {
                                        Text("No household")
                                            .font(.subheadline)
                                            .foregroundStyle(Color.grey300)
                                    }
                                }
                            }
                            
                        }
                        HStack(alignment: .center) {
                            Image(systemName: "bell")
                            Text("Notifications")
                        }
                    }
                    Section(header: Text("Auth")) {
                        HStack(alignment: .center) {
                            Image(systemName: "door.right.hand.open")
                            Text("Log out")
                        }
                        .onTapGesture {
                            withAnimation {
                                accessToken = nil
                                refreshToken = nil
                            }
                        }
                    }
                }
                .listStyle(.grouped)
            }
            .onAppear {
                viewModel.handleAppear()
            }
            .navigationTitle("Settings")
            .navigationBarTitleDisplayMode(.inline)
        }
    }
}

#Preview {
    SettingsView()
}
