//
//  CoreDataStack.swift
//  SelfAwareness
//
//  Created by Ethan Andersen on 6/3/21.
//

import CoreData
import CloudKit

enum CoreDataStack {
    // I changed teh NSPersistenceContainer to have the word CloudKit in the middle, that way it works nice (Thanks Apple)
    static let container: NSPersistentCloudKitContainer = {
        let container = NSPersistentCloudKitContainer(name: "EmotionManager")
        
        guard let description = container.persistentStoreDescriptions.first else { fatalError("No description found") }
        description.setOption(true as NSObject, forKey: NSPersistentStoreRemoteChangeNotificationPostOptionKey)
        
        container.loadPersistentStores { (storeDescription, error) in
            if let error = error {
                fatalError("Error loading persistent stores \(error.localizedDescription)")
            }
        }
        // This will make merges automatic, and work well
        container.viewContext.automaticallyMergesChangesFromParent = true
        // This makes teh Cloud the source of truth, and local is for saving local
        container.viewContext.mergePolicy = NSMergeByPropertyObjectTrumpMergePolicy
        
        return container
    }()
    static var context: NSManagedObjectContext { container.viewContext }
    
    // Saving things
    static func saveContext() {
        if context.hasChanges {
            do {
                try context.save()
            } catch {
                print("Error saving context \(error)")
            }
        }
    } // End of Function
            
} // End of Enum
