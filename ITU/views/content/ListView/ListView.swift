//
//  ListView.swift
//  ITU
//
//  Created by Никита Моисеев on 26.10.2023.
//

import SwiftUI

struct ListView: View {
    @AppStorage("access_token") var access_token: String?
    
    var body: some View {
        GradientButton(title: "Log out", icon: "house.fill") {
            self.access_token = nil
        }
    }
}

#Preview {
    ListView()
}
