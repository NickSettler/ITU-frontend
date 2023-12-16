//
//  NotificationsViewModel.swift
//  ITU
//
//  Created by Елена Марочкина on 30.11.2023.
//

import Foundation
import SwiftUI

/// `NotificationViewModel` provides methods and properties to manage drug notifications
@MainActor class NotificationViewModel : ObservableObject {
    // An array of drugs
    @Published var drugs: [Drug] = []
    // An array of expired drugs
    @Published var expiredDrugs: [Drug] = []
    
    // App storage for user preferences regarding notifications
    @AppStorage("isNotificationAllowed") var isNotificationAllowed: Bool = false
    @AppStorage("reminderFrequency") var reminderFrequency: Int = 24 * 60 * 60 // Default: 24 hours
    @AppStorage("selectedNumber") var selectedNumber: Int = 1 // Default: 30 days
    @AppStorage("selectedUnit") var selectedUnit: Int = 30 // Default: 1 month
    @AppStorage("daysBeforeExpired") var daysBeforeExpired: Int = 30 // Default: 30 days
    
    /// Query all drugs from server using the DrugsService.
    func getAllUserDrugs() {
        Task {
            if let res = await DrugsService.getAllUserDrugs() {
                await MainActor.run {
                    self.drugs = res.data
                }
            } else {
                print("Failed fetching drugs")
            }
        }
    }
    
    /// Remove all pending and delivered notifications
    func removeNotifications() {
        UNUserNotificationCenter.current().removeAllPendingNotificationRequests()
        UNUserNotificationCenter.current().removeAllDeliveredNotifications()
    }
    
    /// Schedule drug expiry notifications based on the user's selected days before expiry.
    func scheduleNotification() {
        
        let actualDate = Date()
        
        for drug in drugs {
            let difference = Calendar.current.dateComponents([.day], from: actualDate, to: drug.expiration_date)
            
            if selectedUnit == 1 {
                daysBeforeExpired = selectedNumber
            } else if selectedUnit == 30 {
                daysBeforeExpired = selectedNumber * 30
            }
            
            if let daysDifference = difference.day {
                if daysDifference > 0 && daysDifference <= daysBeforeExpired {
                    // Schedule notification for expiration in a month
                    scheduleReminderNotification(title: "Reminder", body: "Your medicine will expire soon: \(drug.name)")
                } else if daysDifference <= 0 {
                    // Schedule notification for expired medicine
                    scheduleReminderNotification(title: "Reminder", body: "Your medicine \(drug.name) has expired")
                }
            }
        }
    }
    
    /// Schedule a reminder type of notification.
    ///
    /// - Parameters:
    ///     - title: The title of the notification.
    ///     - body: The body of the notification.
    func scheduleReminderNotification(title: String, body: String) {
        let content = UNMutableNotificationContent()
        content.title = title
        content.body = body
        
        // Unique identifier for each notification
        let identifier = UUID().uuidString
        
        // Set the time for the first notification to appear almost immediately
        let initialTimeInterval: TimeInterval = 10
        let initialTrigger = UNTimeIntervalNotificationTrigger(timeInterval: initialTimeInterval, repeats: false)
        
        // Set the time for the subsequent notifications to repeat based on reminderFrequency
        let repeatingTrigger = UNTimeIntervalNotificationTrigger(timeInterval: TimeInterval(reminderFrequency), repeats: true)
        
        // Create requests for initial and repeating notifications
        let initialRequest = UNNotificationRequest(identifier: identifier, content: content, trigger: initialTrigger)
        let repeatingRequest = UNNotificationRequest(identifier: UUID().uuidString, content: content, trigger: repeatingTrigger)
        
        // Add the initial request
        UNUserNotificationCenter.current().add(initialRequest) { error in
            if let error = error {
                print("Error scheduling initial notification: \(error.localizedDescription)")
            } else {
                print("Initial notification scheduled successfully!")
            }
        }
        
        // Add the repeating request
        UNUserNotificationCenter.current().add(repeatingRequest) { error in
            if let error = error {
                print("Error scheduling repeating notification: \(error.localizedDescription)")
            } else {
                print("Repeating notification scheduled successfully!")
            }
        }
    }
    
    /// Request user permission for sending notifications.
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
