//
//  CellColors.swift
//  SelfAwareness
//
//  Created by Ethan Andersen on 8/16/21.
//

import UIKit

class CellColors {
    static func getColor(emotionName: String) -> UIColor {
        var returnColorHex: String
        
        switch emotionName {
        case "happy":
            returnColorHex = "ffffaa"
        case "mad":
            returnColorHex = "ff8888"
        case "sad":
            returnColorHex = "93bcf8 "
        case "afraid":
            returnColorHex = "b88ee0"
        case "happyDark":
            returnColorHex = "C4B300"
        case "madDark":
            returnColorHex = "D6150C"
        case "sadDark":
            returnColorHex = "0053e2"
        case "afraidDark":
            returnColorHex = "7d1cc3"
        default:
            return .white
        }
        
        let returnColor: UIColor = hexStringToUIColor(hex: returnColorHex)
        
        return returnColor
    } // End of Function

    
    static func hexStringToUIColor(hex: String) -> UIColor {
        var cString:String = hex.trimmingCharacters(in: .whitespacesAndNewlines).uppercased()

        if (cString.hasPrefix("#")) {
            cString.remove(at: cString.startIndex)
        }

        if ((cString.count) != 6) {
            return UIColor.gray
        }

        var rgbValue:UInt64 = 0
        Scanner(string: cString).scanHexInt64(&rgbValue)

        return UIColor(
            red: CGFloat((rgbValue & 0xFF0000) >> 16) / 255.0,
            green: CGFloat((rgbValue & 0x00FF00) >> 8) / 255.0,
            blue: CGFloat(rgbValue & 0x0000FF) / 255.0,
            alpha: CGFloat(1.0)
        )
    } // End of Function
    
} // End of Class
