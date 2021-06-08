//
//  StringCapitalizing.swift
//  SelfAwareness
//
//  Created by Ethan Andersen on 6/7/21.
//

import Foundation

extension String {
    func capitalizingFirstLetter() -> String {
        return prefix(1).capitalized + dropFirst()
    }

    mutating func capitalizeFirstLetter() {
        self = self.capitalizingFirstLetter()
    }
}
