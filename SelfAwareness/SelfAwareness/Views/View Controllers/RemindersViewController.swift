//
//  RemindersViewController.swift
//  SelfAwareness
//
//  Created by Ethan Andersen on 8/16/21.
//

import UIKit

class RemindersViewController: UIViewController {

    
    // MARK: - Outlets
    @IBOutlet weak var datePicker: UIDatePicker!
    
    
    // MARK: - Properties
    let notificationScheduler = NotificationScheduler()
    
    
    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
    } // End of View did load


    // MARK: - Actions
    @IBAction func addReminderBtn(_ sender: Any) {
        let alertTime = datePicker.date
        
        notificationScheduler.scheduleNotification(scheduledTime: alertTime)

        let alert = UIAlertController(title: "Added", message: "We will be sure to ping you!", preferredStyle: .alert)
        let okAction = UIAlertAction(title: "Okay", style: .default) { _ in
            self.dismiss(animated: true, completion: nil)
        }
        alert.addAction(okAction)
        
        present(alert, animated: true, completion: nil)
    } // End of Function

    @IBAction func clearNotificationsBtn(_ sender: Any) {
        notificationScheduler.clearNotifications()
        
        let alert = UIAlertController(title: "Clear All?", message: "This cannot be undone", preferredStyle: .alert)

        let cancelAction = UIAlertAction(title: "Cancel", style: .cancel, handler: nil)
        cancelAction.setValue(UIColor.red, forKey: "titleTextColor")
        
        let clearAction = UIAlertAction(title: "Clear All", style: .default) { _ in
            self.dismiss(animated: true, completion: nil)
            self.notificationScheduler.clearNotifications()
        }

        alert.addAction(cancelAction)
        alert.addAction(clearAction)
        
        present(alert, animated: true, completion: nil)
    } // End of Clear notifications
    
} // End of Class
