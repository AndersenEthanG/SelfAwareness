//
//  Emotion+Convenience.swift
//  SelfAwareness
//
//  Created by Ethan Andersen on 6/3/21.
//

import CoreData
import CloudKit

extension Emotion {
    
    @discardableResult convenience init(emotionName: String,
                                        emotionLevel: Int,
                                        note: String,
                                        timestamp: Date = Date(),
                                        startTime: Date = Date(),
                                        context: NSManagedObjectContext = CoreDataStack.context) {
        self.init(context: context)
        self.emotionName = emotionName
        self.emotionLevel = Int16(emotionLevel)
        self.note = note
        self.startTime = startTime
    }
    
} // End of Extension Emotion
