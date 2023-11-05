//
//  SettingsView.swift
//  ITU
//
//  Created by Nikita Moiseev on 04.11.2023.
//

import SwiftUI

struct SettingsView: View {
    @AppStorage(E_AUTH_STORAGE_KEYS.ACCESS_TOKEN.rawValue) private var accessToken: String?
    @AppStorage(E_AUTH_STORAGE_KEYS.REFRESH_TOKEN.rawValue) private var refreshToken: String?
    
    var body: some View {
        NavigationStack {
            VStack {
                List {
                    Section(header: Text("In-App Settings")) {
                        NavigationLink {
                            FoldersView()
                        } label: {
                            HStack(alignment: .center) {
                                Image(systemName: "folder")
                                Text("Folders")
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
            .navigationTitle("Settings")
            .navigationBarTitleDisplayMode(.inline)
        }
    }
}

#Preview {
    SettingsView()
}
