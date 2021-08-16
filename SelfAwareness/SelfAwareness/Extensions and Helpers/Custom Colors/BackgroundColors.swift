//
//  BackgroundColors.swift
//  SelfAwareness
//
//  Created by Ethan Andersen on 6/11/21.
//

import UIKit

/*
// Depreciated
extension EmotionViewController {
    
    func updateBackground() {
        let pickerGradient = CAGradientLayer()
        pickerGradient.frame = emotionPickerView.bounds
        pickerGradient.colors = [
            UIColor.white.cgColor,
            UIColor.white.cgColor,
            UIColor.systemYellow.cgColor,
            UIColor.systemRed.cgColor,
            UIColor.systemBlue.cgColor,
            UIColor.systemPurple.cgColor,
            UIColor.white.cgColor
        ]
        emotionPickerView.layer.insertSublayer(pickerGradient, at: 0)
        
        overrideUserInterfaceStyle = .light
    } // End of Function updateBackground
    
} // End of Extension
*/

extension EmotionDetailViewController {
    
    func updateColors() {
        let gradient = CAGradientLayer()
        gradient.frame = view.frame
        let emotionColor = emotionNameCheck
        var firstColor = UIColor.white.cgColor
        
        if self.traitCollection.userInterfaceStyle == .dark {
            firstColor = UIColor.black.cgColor
        }
        
        if emotionColor == "happy" {
            gradient.colors = [
                firstColor,
                UIColor.systemYellow.cgColor
            ]
        } else if emotionColor == "mad" {
            gradient.colors = [
                firstColor,
                UIColor.systemRed.cgColor
            ]
        } else if emotionColor == "sad" {
            gradient.colors = [
                firstColor,
                UIColor.systemBlue.cgColor
            ]
        } else if emotionColor == "afraid" {
            gradient.colors = [
                firstColor,
                UIColor.systemPurple.cgColor
            ]
        } else {
            gradient.colors = [
                firstColor,
                UIColor.gray.cgColor
            ]
        }
        
        gradient.startPoint = CGPoint(x: 0.5, y: 0)
        gradient.endPoint = CGPoint(x: 1, y: 1)
        
        self.view.layer.insertSublayer(gradient, at: 0)
    } // End of Function
    
    // This looks pretty bad, but I'm feeling lazy, and running out of time
    func emotionEmojiTintUpdate(emotionIndex: Int16 = 5) {
        
        // Clearing the background colors
        firstBtn.backgroundColor = .clear
        secondBtn.backgroundColor = .clear
        thirdBtn.backgroundColor = .clear
        fourthBtn.backgroundColor = .clear
        fifthBtn.backgroundColor = .clear
        
        // Clearing the border
        firstBtn.layer.borderWidth = 0
        secondBtn.layer.borderWidth = 0
        thirdBtn.layer.borderWidth = 0
        fourthBtn.layer.borderWidth = 0
        fifthBtn.layer.borderWidth = 0
        
        // Updating the appropriate one
        switch emotionIndex {
        case 0:
            firstBtn.layer.borderWidth = 1
            firstBtn.layer.borderColor = UIColor.black.cgColor
            firstBtn.backgroundColor = .lightGray
            firstBtn.layer.cornerRadius = 20
        case 1:
            secondBtn.layer.borderWidth = 1
            secondBtn.layer.borderColor = UIColor.black.cgColor
            secondBtn.backgroundColor = .lightGray
            secondBtn.layer.cornerRadius = 20
        case 2:
            thirdBtn.layer.borderWidth = 1
            thirdBtn.layer.borderColor = UIColor.black.cgColor
            thirdBtn.backgroundColor = .lightGray
            thirdBtn.layer.cornerRadius = 20
        case 3:
            fourthBtn.layer.borderWidth = 1
            fourthBtn.layer.borderColor = UIColor.black.cgColor
            fourthBtn.backgroundColor = .lightGray
            fourthBtn.layer.cornerRadius = 20
        case 4:
            fifthBtn.layer.borderWidth = 1
            fifthBtn.layer.borderColor = UIColor.black.cgColor
            fifthBtn.backgroundColor = .lightGray
            fifthBtn.layer.cornerRadius = 20
        default:
            print("Error in setting background colors")
        }
    } // End of Function
    
} // End of Extension
