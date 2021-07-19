//
//  HappyInterfaceController.swift
//  SelfAwareness WatchKit Extension
//
//  Created by Ethan Andersen on 6/8/21.
//

import WatchKit
import Foundation
import WatchConnectivity


class EmotionInterfaceController: WKInterfaceController, WCSessionDelegate {

    // MARK: - Watch Connectivity
    func session(_ session: WCSession, activationDidCompleteWith activationState: WCSessionActivationState, error: Error?) {
        switch activationState {
        case .activated:
            print("Watch WCSession activated")
        case .inactive:
            print("Watch WCSession inactive")
        case .notActivated:
            print("Watch WCSession not activated")
        default:
            print("Something went wrong on the WC Session activation!")
        } // End of Switch
    } // End of Function
    
    // Transfer User Information (Background send Message)
    func sendMessage() {
        if session.activationState == .activated {
            session.transferUserInfo(message)
        }
    } // End of Function
    var session = WCSession.default
    
     // End of Watch Connectivity
    
    
    // MARK: - Outlets
    @IBOutlet weak var firstBtn: WKInterfaceButton!
    @IBOutlet weak var secondBtn: WKInterfaceButton!
    @IBOutlet weak var thirdBtn: WKInterfaceButton!
    @IBOutlet weak var fourthBtn: WKInterfaceButton!
    @IBOutlet weak var fifthBtn: WKInterfaceButton!
    
    
    // MARK: - Lifecycle
    override func awake(withContext context: Any?) {
        super.awake(withContext: context)
        
        emotionName = context as! String
        print(emotionName)
        let session = WCSession.default
        session.delegate = self
        session.activate()
        
        updateView()
    }
    
    override func willActivate() {
        super.willActivate()
    }
    
    
    // MARK: - Properties
    var emotionName: String = ""
    var emotionLevel: Int = 0
    var message: [String: Any] = ["emotionName" : "", "emotionLevel" : 0, "timestamp" : Date()]
    
    // MARK: - Actions
    // These will work as the save button as on the EmotionDetail controller
    // Also present something saying saved or whatever
    @IBAction func firstBtnTap() {
        message = ["emotionName" : emotionName, "emotionLevel" : 0, "timestamp" : Date()]
        sendMessage()
        pushController(withName: "messageVC", context: nil)
    }
    @IBAction func secondBtnTap() {
        message = ["emotionName" : emotionName, "emotionLevel" : 1, "timestamp" : Date()]
        sendMessage()
        pushController(withName: "messageVC", context: nil)
    }
    @IBAction func thirdBtnTap() {
        message = ["emotionName" : emotionName, "emotionLevel" : 2, "timestamp" : Date()]
        sendMessage()
        pushController(withName: "messageVC", context: nil)
    }
    @IBAction func fourthBtnTap() {
        message = ["emotionName" : emotionName, "emotionLevel" : 3, "timestamp" : Date()]
        sendMessage()
        pushController(withName: "messageVC", context: nil)
    }
    @IBAction func fifthBtnTap() {
        message = ["emotionName" : emotionName, "emotionLevel" : 4, "timestamp" : Date()]
        sendMessage()
        pushController(withName: "messageVC", context: nil)
    }
    
    
    // MARK: - Functions
    func updateView() {
        let emojis = emojisGrabber()
        
        firstBtn.setTitle(emojis[0])
        secondBtn.setTitle(emojis[1])
        thirdBtn.setTitle(emojis[2])
        fourthBtn.setTitle(emojis[3])
        fifthBtn.setTitle(emojis[4])
        
    } // End of Function
    
    
    // Emoji Grabber
    func emojisGrabber() -> [String] {
        let emotion = emotionName
        var returnArray: [String] = []
        if emotion == "happy" {
            returnArray = ["🙂","😌","😃","😁","🥳"]
        } else if emotion == "mad" {
            returnArray = ["☹️","😤","😠","😡","🤬"]
        } else if emotion == "sad" {
            returnArray = ["😕","😞","😢","🥺","😭"]
        } else if emotion == "afraid" {
            returnArray = ["😶","😮","😥","😰","😱"]
        } else {
            returnArray = ["😐","","","",""]
        }
        return returnArray
    } // End of Emojis Grabber
    
} // End of Class
