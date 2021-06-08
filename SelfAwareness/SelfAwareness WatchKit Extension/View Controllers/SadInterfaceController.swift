//
//  SadInterfaceController.swift
//  SelfAwareness WatchKit Extension
//
//  Created by Ethan Andersen on 6/8/21.
//

import WatchKit
import Foundation
import WatchConnectivity

class SadInterfaceController: WKInterfaceController, WCSessionDelegate {
    
    // MARK: - Watch Connectivity
    func session(_ session: WCSession, activationDidCompleteWith activationState: WCSessionActivationState, error: Error?) {
        if let 🛑 = error {
            print("Error in \(#function)\(#line) : \(🛑.localizedDescription) \n---\n \(🛑)")
        } else {
            print("Completed activation!")
        }
    } // End of Function
    
    func applicationDidFinishLaunching() {
        if WCSession.isSupported() {
            let session = WCSession.default
            session.delegate = self
            session.activate()
        }
    } // End of watch Setup stuff
    
    
    // MARK: - Outlets
    @IBOutlet weak var firstBtn: WKInterfaceButton!
    @IBOutlet weak var secondBtn: WKInterfaceButton!
    @IBOutlet weak var thirdBtn: WKInterfaceButton!
    @IBOutlet weak var fourthBtn: WKInterfaceButton!
    @IBOutlet weak var fifthBtn: WKInterfaceButton!
    
    
    // MARK: - Lifecycle
    override func awake(withContext context: Any?) {
        super.awake(withContext: context)
        updateView()
    }
    
    
    // MARK: - Properties
    var emotionName: String = "sad"
    
    
    // MARK: - Actions
    // These will work as the save button as on the EmotionDetail controller
    // Also present something saying saved or whatever
    @IBAction func firstBtnTap() {
        sendMessage(emotion: emotionName, emotionLevel: 0)
    }
    @IBAction func secondBtnTap() {
        sendMessage(emotion: emotionName, emotionLevel: 1)
    }
    @IBAction func thirdBtnTap() {
        sendMessage(emotion: emotionName, emotionLevel: 2)
    }
    @IBAction func fourthBtnTap() {
        sendMessage(emotion: emotionName, emotionLevel: 3)
    }
    @IBAction func fifthBtnTap() {
        sendMessage(emotion: emotionName, emotionLevel: 4)
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

    func sendMessage(emotion: String, emotionLevel: Int) {
        let message = ["emotionName" : emotion,
                       "emotionLevel" : emotionLevel] as [String : Any]
        
        guard WCSession.default.isReachable else { return }
        WCSession.default.sendMessage(message, replyHandler: nil)
        print(message)
    } // End of sendMessage Function
    

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
