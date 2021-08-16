//
//  UpdateTopBackground.swift
//  SelfAwareness
//
//  Created by Ethan Andersen on 8/16/21.
//

import UIKit

extension EmotionViewController {
    
    func updateBtns() {
        happyBtn.backgroundColor = CellColors.getCellColorGradient(emotionName: "happy")
        madBtn.backgroundColor = CellColors.getCellColorGradient(emotionName: "mad")
        sadBtn.backgroundColor = CellColors.getCellColorGradient(emotionName: "sad")
        afraidBtn.backgroundColor = CellColors.getCellColorGradient(emotionName: "afraid")
        
        overrideUserInterfaceStyle = .light
    } // End of Function updateBackground
    
} // End of Extension
