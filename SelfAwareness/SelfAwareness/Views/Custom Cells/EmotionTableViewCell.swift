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
        emotionColorPicker()
        updateCellBackground(emotionColor: emotionColor ?? UIColor.white)
        
        let startTime = emotion?.startTime?.formatToString()
        let emotionNote = emotion?.note
        
        emotionNoteLabel.text = emotionNote
        emotionTimeLabel.text = startTime
    } // End of Function
    
    func emotionGrab() {
        let emotionName = (emotion?.emotionName)!
        let emotionLevel = Int(emotion?.emotionLevel ?? 0)
        
        let emotionEmoji = Emotion.emojiGrabber(emotion: emotionName, emotionLevel: emotionLevel)
        
        emotionEmojiLabel.text = emotionEmoji
    } // End of Function

    
    func emotionColorPicker() {
        guard let emotionName = emotion?.emotionName else { return }
        
        switch emotionName {
        case "happy":
            emotionColor = UIColor.systemYellow
        case "mad":
            emotionColor = UIColor.systemRed
        case "sad":
            emotionColor = UIColor.systemBlue
        case "afraid":
            emotionColor = UIColor.systemPurple
        default:
            emotionColor = UIColor.white
        }
    } // End of Function
    
    
    func updateCellBackground(emotionColor: UIColor) {
        let gradient = CAGradientLayer()
        gradient.frame = self.contentView.bounds
        gradient.colors = [
            UIColor.white.cgColor,
            emotionColor.cgColor,
            UIColor.white.cgColor
        ]
        gradient.startPoint = CGPoint(x: 0.5, y: 1)
        gradient.endPoint = CGPoint(x: 0.5, y: 0)
        self.layer.insertSublayer(gradient, at: 1)
    } // End of Function
    
} // End of Class
