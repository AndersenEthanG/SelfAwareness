//
//  File.swift
//  SelfAwareness
//
//  Created by Ethan Andersen on 6/3/21.
//

import UIKit

extension Emotion {
    static func emojisGrabber(emotion: String) -> [String] {
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
    }
    
    static func emojiGrabber(emotion: String, emotionLevel: Int) -> String {
        let emojiArray = Emotion.emojisGrabber(emotion: emotion)
        let returnEmoji = emojiArray[emotionLevel]
        
        return returnEmoji
    }
}
