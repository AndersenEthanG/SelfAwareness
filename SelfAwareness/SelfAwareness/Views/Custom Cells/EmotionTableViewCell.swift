//
//  EmotionTableViewCell.swift
//  SelfAwareness
//
//  Created by Ethan Andersen on 6/3/21.
//

import UIKit

class EmotionTableViewCell: UITableViewCell {

    // MARK: - Outlets
    @IBOutlet weak var emotionNoteLabel: UILabel!
    @IBOutlet weak var emotionTimeLabel: UILabel!
    @IBOutlet weak var emotionEmojiLabel: UILabel!

    
    // MARK: - Properties
    var emotionColor: UIColor?

    var emotion: Emotion? {
        didSet {
            updateView()
        }
    }
    
    
    // MARK: - Functions
    func updateView() {
        emotionGrab()
        
        let startTime = emotion?.startTime?.formatToString()
        let emotionNote = emotion?.note
        
        darkModeUpdate()
        
        emotionNoteLabel.text = emotionNote
        emotionTimeLabel.text = startTime
    } // End of Function
    
    func emotionGrab() {
        let emotionName = (emotion?.emotionName)!
        let emotionLevel = Int(emotion?.emotionLevel ?? 0)
        
        let emotionEmoji = Emotion.emojiGrabber(emotion: emotionName, emotionLevel: emotionLevel)
        
        emotionEmojiLabel.text = emotionEmoji
    } // End of Function
    
} // End of Class
