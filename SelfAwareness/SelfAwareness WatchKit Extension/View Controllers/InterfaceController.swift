//
//  InterfaceController.swift
//  SelfAwareness WatchKit Extension
//
//  Created by Ethan Andersen on 6/3/21.
//

import WatchKit
import Foundation
import WatchConnectivity


class InterfaceController: WKInterfaceController {
    
    // MARK: - Actions
    // These buttons simply pass over the information to the detail interface controller (Much like the normal Emotion Controller)
    @IBAction func happyBtnTap() {
        print("Pushing happy button along!")
        pushController(withName: "emotionDetailVC", context: "happy")
    }
    
    @IBAction func madBtnTap() {
        print("Pushing happy button along!")
        pushController(withName: "emotionDetailVC", context: "mad")
    }
    
    @IBAction func sadBtnTap() {
        print("Pushing happy button along!")
        pushController(withName: "emotionDetailVC", context: "sad")
    }
    
    @IBAction func afraidBtnTap() {
        print("Pushing happy button along!")
        pushController(withName: "emotionDetailVC", context: "afraid")
    }
    
} // End of Class
