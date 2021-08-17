//
//  HappyInterfaceController.swift
//  SelfAwareness WatchKit Extension
//
//  Created by Ethan Andersen on 6/8/21.
//

import WatchKit
import Foundation


class EmotionInterfaceController: WKInterfaceController {
    
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
        updateView()
    }
    
    override func willActivate() {
        super.willActivate()
    }
    
    
    // MARK: - Properties
    var emotionName: String = ""
    var emotionLevel: Int = 0
    
    // MARK: - Actions
    // These will work as the save button as on the EmotionDetail controller
    // Also present something saying saved or whatever
    @IBAction func firstBtnTap() {
        let message = Message(emotionName: emotionName, emotionLevel: 0, timestamp: Date(), note: "")
        AddTextInterfaceController.message = message
        pushController(withName: "textVC", context: nil)
    }
    @IBAction func secondBtnTap() {
        let message = Message(emotionName: emotionName, emotionLevel: 1, timestamp: Date(), note: "")
        AddTextInterfaceController.message = message
        pushController(withName: "textVC", context: nil)
    }
    @IBAction func thirdBtnTap() {
        let message = Message(emotionName: emotionName, emotionLevel: 2, timestamp: Date(), note: "")
        AddTextInterfaceController.message = message
        pushController(withName: "textVC", context: nil)
    }
    @IBAction func fourthBtnTap() {
        let message = Message(emotionName: emotionName, emotionLevel: 3, timestamp: Date(), note: "")
        AddTextInterfaceController.message = message
        pushController(withName: "textVC", context: nil)
    }
    @IBAction func fifthBtnTap() {
        let message = Message(emotionName: emotionName, emotionLevel: 4, timestamp: Date(), note: "")
        AddTextInterfaceController.message = message
        pushController(withName: "textVC", context: nil)
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
