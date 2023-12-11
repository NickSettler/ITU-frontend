//
//  NotificationViewController.swift
//  ITU
//
//  Created by Елена Марочкина on 02.12.2023.
//

import UIKit
import UserNotifications
import SwiftUI

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate, UNUserNotificationCenterDelegate {

    var window: UIWindow?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        // Set the UNUserNotificationCenter delegate
        UNUserNotificationCenter.current().delegate = self

        // Other initialization code...

        return true
    }

    func userNotificationCenter(_ center: UNUserNotificationCenter, didReceive response: UNNotificationResponse, withCompletionHandler completionHandler: @escaping () -> Void) {
        // Handle the notification tap here
        // You can access the response.notification and response.actionIdentifier to determine which notification was tapped and what action was taken

        // Switch to the main view (ContentView)
        if let windowScene = UIApplication.shared.connectedScenes.first as? UIWindowScene,
           let window = windowScene.windows.first,
           let rootViewController = window.rootViewController as? UIHostingController<ContentView> {
            
            // Assuming ContentView is your actual main SwiftUI view
            let newContentView = ContentView().preferredColorScheme(.light)
            
            // Ensure that the newContentView has the same type as ContentView
            guard let newRootViewController = UIHostingController(rootView: newContentView as! ContentView) as? UIHostingController<ContentView> else {
                return
            }
            
            rootViewController.rootView = newRootViewController.rootView
        }

        completionHandler()
    }

}

