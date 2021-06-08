//
//  DateFormat.swift
//  SelfAwareness
//
//  Created by Ethan Andersen on 6/3/21.
//

import Foundation

extension Date {
    func formatToString() -> String {
        let formatter = DateFormatter()
        formatter.dateStyle = .short
        formatter.timeStyle = .short
        return formatter.string(from: self)
    }
} // End of Extension
