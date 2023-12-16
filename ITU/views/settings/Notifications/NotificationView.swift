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
            List {
                Toggle("Allow Expiration date notifications", isOn: $viewModel.isNotificationAllowed)
                    .onChange(of: viewModel.isNotificationAllowed) { newValue in
                        if newValue {
                            viewModel.performOnAction()
                        }
                    }
                    .padding()
                
                if viewModel.isNotificationAllowed {
                    Section(header: Text("Reminder Settings")) {
                        Picker("Select Frequency", selection: $viewModel.reminderFrequency) {
                            Text("Every day").tag(24 * 60 * 60)
                            Text("Every week").tag(24 * 60 * 60 * 7)
                            Text("Every month").tag(24 * 60 * 60 * 30)
                        }
                        .pickerStyle(SegmentedPickerStyle())
                        .foregroundColor(.gray)
                        
                        
                    }
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





#Preview {
    NotificationView()
}
