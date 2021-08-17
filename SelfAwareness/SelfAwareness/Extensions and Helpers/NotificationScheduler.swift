//
//  NotificationScheduler.swift
//  SelfAwareness
//
//  Created by Ethan Andersen on 8/17/21.
//

import UserNotifications

class NotificationScheduler {
    
    func scheduleNotification(scheduledTime: Date) {
        let time = scheduledTime
        let identifier = "default"
        
        let content = UNMutableNotificationContent()
        content.title = "It's time to take log your emotion!"
        content.body = "Take a deep breath, close your eyes and try to focus!"
        content.sound = .default
        
        let fireDateComponents = Calendar.current.dateComponents([.hour, .minute], from: time)
        let trigger = UNCalendarNotificationTrigger(dateMatching: fireDateComponents, repeats: true)
        let request = UNNotificationRequest(identifier: identifier, content: content, trigger: trigger)
        
        UNUserNotificationCenter.current().add(request) { error in
            if let error = error {
                print("Unable to add notification request\nError in \(#function) : \(error.localizedDescription) \n---\n \(error)")
                print("Error in \(#function) : \(error.localizedDescription) \n---\n \(error)")
            }
        }
    } // End of Func schedule notification
    
    func clearNotifications() {
        UNUserNotificationCenter.current().removeAllPendingNotificationRequests()
    } // End of Clear notifications
    
} // End of Class
