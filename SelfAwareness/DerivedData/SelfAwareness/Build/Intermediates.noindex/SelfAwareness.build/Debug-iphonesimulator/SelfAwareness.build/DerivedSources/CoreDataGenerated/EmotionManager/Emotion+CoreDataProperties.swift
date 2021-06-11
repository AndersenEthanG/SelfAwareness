//
//  Emotion+CoreDataProperties.swift
//  
//
//  Created by Ethan Andersen on 6/11/21.
//
//  This file was automatically generated and should not be edited.
//

import Foundation
import CoreData


extension Emotion {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Emotion> {
        return NSFetchRequest<Emotion>(entityName: "Emotion")
    }

    @NSManaged public var emotionLevel: Int16
    @NSManaged public var emotionName: String?
    @NSManaged public var note: String?
    @NSManaged public var startTime: Date?
    @NSManaged public var timestamp: Date?

}

extension Emotion : Identifiable {

}
