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
            returnArray = ["đ","đ","đ","đ","đĨŗ"]
        } else if emotion == "mad" {
            returnArray = ["âšī¸","đ¤","đ ","đĄ","đ¤Ŧ"]
        } else if emotion == "sad" {
            returnArray = ["đ","đ","đĸ","đĨē","đ­"]
        } else if emotion == "afraid" {
            returnArray = ["đļ","đŽ","đĨ","đ°","đą"]
        } else {
            returnArray = ["đ","","","",""]
        }
        
        return returnArray
    }
    
    static func emojiGrabber(emotion: String, emotionLevel: Int) -> String {
        let emojiArray = Emotion.emojisGrabber(emotion: emotion)
        let returnEmoji = emojiArray[emotionLevel]
        
        return returnEmoji
    }
}
