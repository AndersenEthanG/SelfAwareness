//
//  UpdateTopBackground.swift
//  SelfAwareness
//
//  Created by Ethan Andersen on 8/16/21.
//

import UIKit

extension EmotionViewController {
    
    func updateBtns() {
        if self.traitCollection.userInterfaceStyle == .light {
            happyBtn.backgroundColor = CellColors.getColor(emotionName: "happy")
            madBtn.backgroundColor = CellColors.getColor(emotionName: "mad")
            sadBtn.backgroundColor = CellColors.getColor(emotionName: "sad")
            afraidBtn.backgroundColor = CellColors.getColor(emotionName: "afraid")
            
        } else if self.traitCollection.userInterfaceStyle == .dark {
            happyBtn.backgroundColor = CellColors.getColor(emotionName: "happyDark")
            madBtn.backgroundColor = CellColors.getColor(emotionName: "madDark")
            sadBtn.backgroundColor = CellColors.getColor(emotionName: "sadDark")
            afraidBtn.backgroundColor = CellColors.getColor(emotionName: "afraidDark")
        }
    } // End of Function updateBackground
    
} // End of Extension
