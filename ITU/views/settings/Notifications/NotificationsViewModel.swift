//
//  NotificationsViewModel.swift
//  ITU
//
//  Created by Елена Марочкина on 30.11.2023.
//

import Foundation
import SwiftUI

@MainActor class NotificationViewModel : ObservableObject {
    @Published var drugs: [Drug] = allDrugs
    @Published var expiredDrugs: [Drug] = []
    
    @AppStorage("isNotificationAllowed") var isNotificationAllowed: Bool = false
    @AppStorage("reminderFrequency") var reminderFrequency: Int = 24 * 60 * 60 // Default: 24 hours
    
    func getAllUserDrugs() {
        Task {
            if let res = await DrugsService.getAllUserDrugs() {
                await MainActor.run {
                    self.drugs = allDrugs + res.data
                }
            } else {
                print("Failed fetching drugs")
            }
        }
    }
    
    func scheduleNotification() {
        // Clear all pending notifications if the toggle is turned off
        if !isNotificationAllowed {
            UNUserNotificationCenter.current().removeAllPendingNotificationRequests()
            UNUserNotificationCenter.current().removeAllDeliveredNotifications()
            return
        }

        let actualDate = Date()
        
        for drug in drugs {
            let difference = Calendar.current.dateComponents([.day], from: actualDate, to: drug.expiration_date)
            print(difference)
            
            if let daysDifference = difference.day {
                if daysDifference > 0 && daysDifference <= 30 {
                    // Schedule notification for expiration in a month
                    scheduleReminderNotification(title: "Reminder", body: "Your medicine will expire soon: \(drug.name)")
                } else if daysDifference <= 0 {
                    // Schedule notification for expired medicine
                    scheduleReminderNotification(title: "Reminder", body: "Your medicine \(drug.name) has expired")
                }
            }
        }
    }

    func scheduleReminderNotification(title: String, body: String) {
        let content = UNMutableNotificationContent()
        content.title = title
        content.body = body
        
        // Set the time for the notification
        let trigger = UNTimeIntervalNotificationTrigger(timeInterval: TimeInterval(reminderFrequency), repeats: true)
        
        let request = UNNotificationRequest(identifier: UUID().uuidString, content: content, trigger: trigger)
        
        UNUserNotificationCenter.current().add(request) { error in
            if let error = error {
                print("Error scheduling notification: \(error.localizedDescription)")
            } else {
                print("Notification scheduled successfully!")
            }
        }
    }

    
    func performOnAction () {
        UNUserNotificationCenter.current().requestAuthorization(options: [.alert, .badge, .sound]) {
            success, error in
            if (success) {
                print("Success")
            } else if let error = error {
                print(error.localizedDescription)
            }
        }
    }

}


