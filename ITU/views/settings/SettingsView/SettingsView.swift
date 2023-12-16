//
//  SettingsView.swift
//  ITU
//
//  Created by Nikita Pasynkov
//

import SwiftUI

/// `SettingsView` displays the settings menu of the application that includes User Info, In-App Settings,
/// and Authentication options to log out.
struct SettingsView: View {
    // Access token from the AppStorage
    @AppStorage(E_AUTH_STORAGE_KEYS.ACCESS_TOKEN.rawValue) private var accessToken: String?
    // Refresh token from the AppStorage
    @AppStorage(E_AUTH_STORAGE_KEYS.REFRESH_TOKEN.rawValue) private var refreshToken: String?
    
    @StateObject var viewModel = SettingsViewModel()
    
    /// The UI structure for the SettingsView.
    var body: some View {
        NavigationStack {
            VStack {
                List {
                    // View to present current User Information
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
                    // In-App Settings Section
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
                        NavigationLink {
                            NotificationView()
                        } label: {HStack(alignment: .center) {
                            Image(systemName: "bell")
                            Text("Notifications")
                        }
                        }
                    }
                    // Authentication Section
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

// Preview of the `SettingsView`.
#Preview {
    SettingsView()
}
