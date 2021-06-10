//
//  MessageInterfaceController.swift
//  SelfAwareness WatchKit Extension
//
//  Created by Ethan Andersen on 6/8/21.
//

import WatchKit
import Foundation


class MessageInterfaceController: WKInterfaceController {

    // MARK: - Outlets
    @IBOutlet weak var messageLabel: WKInterfaceLabel!
    
    
    // MARK: - Lifecycle
    override func awake(withContext context: Any?) {
        super.awake(withContext: context)
        
        updateView()
    }

    override func willActivate() {
        // This method is called when watch view controller is about to be visible to user
        super.willActivate()
    }

    override func didDeactivate() {
        // This method is called when watch view controller is no longer visible
        super.didDeactivate()
    }

    
    // MARK: - Functions
    func updateView() {
        messageLabel.setText("Emotion saved!")
    } // End of Function
    
    
} // End of Class
