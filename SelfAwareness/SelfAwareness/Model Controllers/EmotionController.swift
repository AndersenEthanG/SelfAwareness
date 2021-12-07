//
//  EmotionController.swift
//  SelfAwareness
//
//  Created by Ethan Andersen on 6/3/21.
//

import CoreData

class EmotionController {
    
    // MARK: - Properties
    // Shared Instance
    static let sharedInstance = EmotionController()
    
    // Source of Truth
    var emotions: [Emotion] = []
    
    // Fetch request
    private lazy var fetchRequest: NSFetchRequest<Emotion> = {
        let request = NSFetchRequest<Emotion>(entityName: "Emotion")
        request.predicate = NSPredicate(value: true)
        return request
    }() // End of Fetch Request
    
    
    // MARK: - Functionss
    func createEmotion(emotionName: String, emotionLevel: Int, emotionNote: String = "", startTime: Date = Date(), timestamp: Date = Date()) {
        // Enter in the new data, save the data
        let emotion = Emotion(emotionName: emotionName, emotionLevel: emotionLevel, note: emotionNote, timestamp: timestamp, startTime: startTime)
        
        emotions.append(emotion)
        updateDB()
    } // End of Create function
    
    func updateEmotion(emotion: Emotion) {
        emotion.emotionName = emotion.emotionName
        emotion.emotionLevel = emotion.emotionLevel
        if emotion.note == "" {
            emotion.note = emotion.emotionName?.capitalizingFirstLetter()
        } else {
            emotion.note = emotion.note
        }
        emotion.startTime = emotion.startTime
        
        updateDB()
    } // End of Update emotion
    
    func fetchEmotion() -> [Emotion] {
        var fetchedEmotions = (try? CoreDataStack.context.fetch(fetchRequest)) ?? []
        
        fetchedEmotions.sort(by: {$0.startTime!.timeIntervalSinceNow > $1.startTime!.timeIntervalSinceNow})
        
        emotions = fetchedEmotions
        
        return fetchedEmotions
    } // End of Fetch emotion
    
    func deleteEmotion(emotion: Emotion) {
        if let index = emotions.firstIndex(of: emotion) {
            emotions.remove(at: index)
        }
        
        CoreDataStack.context.delete(emotion)
        updateDB()
    } // End of Delete emotion
    
    func updateDB() {
        CoreDataStack.saveContext()
    } // End of Function update database
    
} // End of Class Emotion Controller
