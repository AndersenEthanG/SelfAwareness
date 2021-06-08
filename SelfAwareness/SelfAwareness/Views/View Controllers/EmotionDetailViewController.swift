//
//  EmotionDetailViewController.swift
//  SelfAwareness
//
//  Created by Ethan Andersen on 6/3/21.
//

import UIKit
import WatchConnectivity

class EmotionDetailViewController: UIViewController, WCSessionDelegate {
    
    // MARK: - Watch Connectivity
    func session(_ session: WCSession, activationDidCompleteWith activationState: WCSessionActivationState, error: Error?) {
        if let 🛑 = error {
            print("Error in \(#function)\(#line) : \(🛑.localizedDescription) \n---\n \(🛑)")
        } else {
            print("Phone Watch Connectivity activation completed!")
        }
    }
    func sessionDidBecomeInactive(_ session: WCSession) {
        print("Session did become inactive")
    }
    func sessionDidDeactivate(_ session: WCSession) {
        print("Session did deactivate")
    } // End of Basic Watch Connectivity functions
    
    
    // Watch message landing pad
    public func session(_: WCSession, didReceiveMessage message: [String: Any], replyHandler: @escaping ([String: Any]) -> Void) {
        print("message received! - \(message)")
        guard let message = message as? [String: String] else { return }
        
        let emotionName: String = message["emotionName"]!
        let emotionLevel: Int = Int(message["emotionLevel"]!)!
        // Do something cool here? Create a thing
        EmotionController.sharedInstance.createEmotion(emotionName: emotionName, emotionLevel: emotionLevel)
        
    } // End of Function
    
    
    // MARK: - Outlets
    @IBOutlet weak var firstBtn: UIButton!
    @IBOutlet weak var secondBtn: UIButton!
    @IBOutlet weak var thirdBtn: UIButton!
    @IBOutlet weak var fourthBtn: UIButton!
    @IBOutlet weak var fifthBtn: UIButton!
    
    // TODO - Editing the date picker breaks the app
    @IBOutlet weak var emotionNameLabel: UILabel!
    @IBOutlet weak var datePicker: UIDatePicker!
    @IBOutlet weak var emotionNoteView: UITextView!
    
    
    
    // MARK: - Properties
    var emotion: Emotion?
    var emotionLevel: Int = 0
    static var emotionName: String?
    var emotionNameCheck: String = ""

    
    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Watch Connectivity
        if WCSession.isSupported() {
            let session = WCSession.default
            session.delegate = self
            session.activate()
        }
        
        updateView()
    } // End of Function viewDidLoad
    
    
    // MARK: - Functions
    func updateView() {
        emotionCheck()
        
        emotionNameLabel.text = "How \(emotionNameCheck) do you feel?"
        datePicker.date = emotion?.startTime ?? Date()
        emotionNoteView.text = emotion?.note
        
        // Emoji Buttons
        let emotionEmojis = Emotion.emojisGrabber(emotion: emotionNameCheck)
        
        firstBtn.setTitle("\(emotionEmojis[0])", for: .normal)
        secondBtn.setTitle("\(emotionEmojis[1])", for: .normal)
        thirdBtn.setTitle("\(emotionEmojis[2])", for: .normal)
        fourthBtn.setTitle("\(emotionEmojis[3])", for: .normal)
        fifthBtn.setTitle("\(emotionEmojis[4])", for: .normal)
        
        // Checking the emoji level for tints
        let emotionLevel = emotion?.emotionLevel
        emotionEmojiTintUpdate(emotionIndex: emotionLevel ?? 0)
        
    } // End of Function
    
    func emotionCheck() {
        var emotionName = EmotionDetailViewController.emotionName
        if emotionName != EmotionDetailViewController.emotionName {
            emotionName = (emotion?.emotionName)!
        }
        self.emotionNameCheck = emotionName ?? ""
    }
    
    // This looks pretty bad, but I'm feeling lazy, and running out of time
    func emotionEmojiTintUpdate(emotionIndex: Int16 = 5) {
        switch emotionIndex {
        case 0:
            firstBtn.backgroundColor = .gray
            secondBtn.backgroundColor = .white
            thirdBtn.backgroundColor = .white
            fourthBtn.backgroundColor = .white
            fifthBtn.backgroundColor = .white
        case 1:
            firstBtn.backgroundColor = .white
            secondBtn.backgroundColor = .gray
            thirdBtn.backgroundColor = .white
            fourthBtn.backgroundColor = .white
            fifthBtn.backgroundColor = .white
        case 2:
            firstBtn.backgroundColor = .white
            secondBtn.backgroundColor = .white
            thirdBtn.backgroundColor = .gray
            fourthBtn.backgroundColor = .white
            fifthBtn.backgroundColor = .white
        case 3:
            firstBtn.backgroundColor = .white
            secondBtn.backgroundColor = .white
            thirdBtn.backgroundColor = .white
            fourthBtn.backgroundColor = .gray
            fifthBtn.backgroundColor = .white
        case 4:
            firstBtn.backgroundColor = .white
            secondBtn.backgroundColor = .white
            thirdBtn.backgroundColor = .white
            fourthBtn.backgroundColor = .white
            fifthBtn.backgroundColor = .gray
        default:
            firstBtn.backgroundColor = .white
            secondBtn.backgroundColor = .white
            thirdBtn.backgroundColor = .white
            fourthBtn.backgroundColor = .white
            fifthBtn.backgroundColor = .white
        }
    } // End of Function
    
    
    // MARK: - Actions
    // These will update the strength status of how the person feels
    // Also updates the emotion strength data
    // TODO - Hightlight the one that you selected in some way
    @IBAction func firstBtnTap(_ sender: Any) {
        emotionLevel = 0
        emotionEmojiTintUpdate(emotionIndex: 0)
        
    }
    @IBAction func secondBtnTap(_ sender: Any) {
        emotionLevel = 1
        emotionEmojiTintUpdate(emotionIndex: 1)
        
    }
    @IBAction func thirdBtnTap(_ sender: Any) {
        emotionLevel = 2
        emotionEmojiTintUpdate(emotionIndex: 2)
        
    }
    @IBAction func fourthBtnTap(_ sender: Any) {
        emotionLevel = 3
        emotionEmojiTintUpdate(emotionIndex: 3)
        
    }
    @IBAction func fifthBtnTap(_ sender: Any) {
        emotionLevel = 4
        emotionEmojiTintUpdate(emotionIndex: 4)
        
    }
    
    @IBAction func saveBtnTap(_ sender: Any) {
        // Grab all of the data
        let emotionName = emotionNameCheck
        let emotionLevel = emotionLevel
        let startTime = datePicker.date
        let note = emotionNoteView.text ?? ""
        
        if let emotion = emotion {
            // Update the Emotion
            emotion.emotionName = emotionName
            emotion.emotionLevel = Int16(emotionLevel)
            emotion.startTime = startTime
            emotion.note = note
            EmotionController.sharedInstance.updateEmotion(emotion: emotion)
        } else {
            // Create new emotion
            EmotionController.sharedInstance.createEmotion(emotionName: emotionNameCheck, emotionLevel: emotionLevel, emotionNote: note, startTime: startTime)
        }
        // Pop View controller
        navigationController?.popViewController(animated: true)
    }
    
} // End of Class
