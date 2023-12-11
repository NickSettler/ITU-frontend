//
//  NotificationView.swift
//  ITU
//
//  Created by Елена Марочкина on 30.11.2023.
//

import SwiftUI
import UserNotifications

struct NotificationView: View {
    @StateObject var viewModel = NotificationViewModel()
    
    var body: some View {
        
        VStack {
            List{
                Toggle("Allow Expiration date notifications", isOn: $viewModel.isNotificationAllowed)
                    .onChange(of: viewModel.isNotificationAllowed) {
                        newValue in
                        if (newValue) {
                            viewModel.performOnAction()
                        }
                    }
                    .padding()
                if viewModel.isNotificationAllowed {
                    Section(header: Text("Reminder Frequency")) {
                        Picker("Select Frequency", selection: $viewModel.reminderFrequency) {
                            Text("Every day").tag(24 * 60 * 60)
                            Text("Every week").tag(84 * 60 * 60)
                            Text("Every month").tag(720 * 60 * 60)
                        }
                        .pickerStyle(SegmentedPickerStyle())
                    }
                }
                
            }
            .onDisappear {
                viewModel.getAllUserDrugs()
                //Check if there is any drug with an expired state
                let hasExpiredDrug = viewModel.drugs.contains { $0.expiry_state == .expired }
                //If notifications are allowed and there is an expired drug, schedule a daily notification
                viewModel.scheduleNotification()
            }
        }
    }
}




#Preview {
    NotificationView()
}
