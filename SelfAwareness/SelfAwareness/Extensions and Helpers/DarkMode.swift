//
//  DarkMode.swift
//  SelfAwareness
//
//  Created by Ethan Andersen on 8/16/21.
//

import UIKit


// MARK: - Emotion VC
extension EmotionViewController {
    func darkModeUpdate() {
        
        var textColor: UIColor = .black
        var backgroundColor: UIColor = .white
        
        // Dark mode
        if self.traitCollection.userInterfaceStyle == .dark {
            self.navigationController?.overrideUserInterfaceStyle = .dark
            textColor = .white
            backgroundColor = .black
        }
        
        self.view.backgroundColor = backgroundColor
        self.emotionPickerView.backgroundColor = backgroundColor
        
        // Buttons
        happyBtn.setTitleColor(textColor, for: .normal)
        madBtn.setTitleColor(textColor, for: .normal)
        sadBtn.setTitleColor(textColor, for: .normal)
        afraidBtn.setTitleColor(textColor, for: .normal)
        
    } // End of Function
    
} // End of Extension


// MARK: - Detial VC
extension EmotionDetailViewController {
    func darkModeUpdate() {
        var textColor: UIColor = .black
        
        if self.traitCollection.userInterfaceStyle == .dark {
            textColor = .white
        }
        
        emotionNameLabel.textColor = textColor
        emotionNoteView.textColor = textColor
        emotionNoteView.textColor = textColor
        
        
    } // End of Function
} // End of Extension


// MARK: - Cell
extension EmotionTableViewCell {
    func darkModeUpdate() {
        var textColor: UIColor = .black
        
        if self.traitCollection.userInterfaceStyle == .dark {
            textColor = .white
        }
        
        emotionNoteLabel.textColor = textColor
        emotionTimeLabel.textColor = textColor
        
    } // End of Function
    
} // End of Extension
