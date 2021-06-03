//
//  Emotion+Convenience.swift
//  SelfAwareness
//
//  Created by Ethan Andersen on 6/3/21.
//

import CoreData
import CloudKit

extension Emotion {
    
    @discardableResult convenience init(happy: Bool = false,
                                        mad: Bool = false,
                                        sad: Bool = false,
                                        afraid: Bool = false,
                                        emotionLevel: Int16,
                                        timestamp: Date = Date(),
                                        context: NSManagedObjectContext = CoreDataStack.context) {
        self.init(context: context)
        self.emotionLevel = emotionLevel
    }
    
} // End of Extension Emotion
