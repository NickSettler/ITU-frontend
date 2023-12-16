//
//  NotificationView.swift
//  ITU
//
//  Created by Elena Marochkina
//

import SwiftUI
import UserNotifications

/// `NotificationView` allows user to set up and customize medication expiration alerts.
struct NotificationView: View {

    // View Model for the view
    @StateObject var viewModel = NotificationViewModel()
    
    /// The main view rendered by SwiftUI.
    var body: some View {
        VStack {
            List {
                // Shows a toggle button for the user to allow medication expiration alerts.
                Toggle("Allow Expiration date notifications", isOn: $viewModel.isNotificationAllowed)
                    .onChange(of: viewModel.isNotificationAllowed) { newValue in
                        if newValue {
                            viewModel.performOnAction()
                        }
                    }
                    .padding()
                
                // If notifications are allowed, shows additional customization options.
                if viewModel.isNotificationAllowed {
                    // Section for Reminder frequency settings
                    Section(header: Text("Reminder Settings")) {
                        Picker("Select Frequency", selection: $viewModel.reminderFrequency) {
                            Text("Every day").tag(24 * 60 * 60)
                            Text("Every week").tag(24 * 60 * 60 * 7)
                            Text("Every month").tag(24 * 60 * 60 * 30)
                        }
                        .pickerStyle(SegmentedPickerStyle())
                        .foregroundColor(.gray)
                    }

                    // Section for setting up the time before the medication expiration date when notifications should start.
                    Section{
                        Text("Choose the time before the expiration date you want to receive notifications from the app")
                            .font(.system(size: 14))
                            .foregroundColor(.gray)
                            .padding()
                        HStack {
                            VStack{
                                GeometryReader { geometry in
                                    Picker("Number", selection: $viewModel.selectedNumber) {
                                        ForEach(1..<32) { number in
                                            Text("\(number)")
                                                .tag(number)
                                                .font(.system(size: 16))
                                        }
                                    }
                                    .pickerStyle(WheelPickerStyle())
                                    .foregroundColor(.gray)
                                    .frame(width: geometry.size.width, height: geometry.size.height * 1.75)
                                }
                                .pickerStyle(WheelPickerStyle())
                                .foregroundColor(.gray)
                                .padding()
                                
                            }
                            
                            Picker("Unit", selection: $viewModel.selectedUnit) {
                                Text("Days").tag(1)
                                Text("Months").tag(30)
                            }
                            .pickerStyle(SegmentedPickerStyle())
                            .foregroundColor(.gray)
                            .padding(.top, 30)
                            
                        }
                    }
                }
            }
            // When value of `isNotificationAllowed` changes, it fetches all user drugs and schedules notifications as necessary.
            .onChange(of: viewModel.isNotificationAllowed) {
                viewModel.getAllUserDrugs()
                
                // Check if there is any drug with an expired state
                let hasExpiredDrug = viewModel.drugs.contains { $0.expiry_state == .expired }
                
                // If notifications are allowed and there is an expired drug, schedule a daily notification
                if viewModel.isNotificationAllowed && hasExpiredDrug {
                    viewModel.scheduleNotification()
                } else if !viewModel.isNotificationAllowed {
                    viewModel.removeNotifications()
                }
            }
        }
    }
}

// Preview of the `NotificationView`.
#Preview {
    NotificationView()
}
