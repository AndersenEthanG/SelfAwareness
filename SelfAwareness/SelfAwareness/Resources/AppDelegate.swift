//
//  AppDelegate.swift
//  SelfAwareness
//
//  Created by Ethan Andersen on 6/3/21.
//

import UIKit
import CoreData
import UserNotifications

@main
class AppDelegate: UIResponder, UIApplicationDelegate, UNUserNotificationCenterDelegate {

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        
        // Notifications
        UNUserNotificationCenter.current().requestAuthorization(options: [.alert, .badge, .sound]) { authorized, error in
            if let error = error {
                print("There was an error requesting authorization to use notifications. Error: \(error)")
            }
            if authorized {
                UNUserNotificationCenter.current().delegate = self
                self.setNotificationCategories()
                print("Authorized notifications")
            } else {
                print("Declined notifications")
            }
        } // End of Notification Center
        
        
        return true
    } // End of Did finish launching with options

    // MARK: - Notification Center
    private func setNotificationCategories() {
        let setReminder = UNNotificationAction(identifier: Strings.setReminder, title: "Set Reminder", options: UNNotificationActionOptions(rawValue: 0))
        
        let meetingInviteCategory = UNNotificationCategory(identifier: Strings.notificationCategoryIdentifier, actions: [setReminder], intentIdentifiers: [], hiddenPreviewsBodyPlaceholder: "", options: .customDismissAction)
        
        UNUserNotificationCenter.current().setNotificationCategories([meetingInviteCategory])
    } // End of Set Notification Categories
    
    
    // MARK: UISceneSession Lifecycle

    func application(_ application: UIApplication, configurationForConnecting connectingSceneSession: UISceneSession, options: UIScene.ConnectionOptions) -> UISceneConfiguration {
        // Called when a new scene session is being created.
        // Use this method to select a configuration to create the new scene with.
        return UISceneConfiguration(name: "Default Configuration", sessionRole: connectingSceneSession.role)
    }

    func application(_ application: UIApplication, didDiscardSceneSessions sceneSessions: Set<UISceneSession>) {
        // Called when the user discards a scene session.
        // If any sessions were discarded while the application was not running, this will be called shortly after application:didFinishLaunchingWithOptions.
        // Use this method to release any resources that were specific to the discarded scenes, as they will not return.
    }

    
    // MARK: - Core Data stack
    lazy var persistentContainer: NSPersistentContainer = {
        let container = NSPersistentContainer(name: "EmotionManager")
        container.loadPersistentStores(completionHandler: { (storeDescription, error) in
            if let error = error as NSError? {
                fatalError("Unresolved error \(error), \(error.userInfo)")
            }
        })
        return container
    }()  // End of Variable
    
    
    // MARK: - Core Data Saving support
    func saveContext () {
        let context = persistentContainer.viewContext
        if context.hasChanges {
            do {
                try context.save()
            } catch {
                let nserror = error as NSError
                fatalError("Unresolved error \(nserror), \(nserror.userInfo)")
            }
        }
    } // End of Function

    
    // Homescreen shortcut stuff
    func application(_ application: UIApplication, performActionFor shortcutItem: UIApplicationShortcutItem, completionHandler: @escaping (Bool) -> Void) {
        <#code#>
    } // End of Function
    
} // End of Class
