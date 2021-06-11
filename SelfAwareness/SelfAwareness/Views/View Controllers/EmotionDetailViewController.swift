//
//  EmotionDetailViewController.swift
//  SelfAwareness
//
//  Created by Ethan Andersen on 6/3/21.
//

import UIKit

class EmotionDetailViewController: UIViewController, UITextViewDelegate {
    
    
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
        // Make the navigation bar reappear (Main page makes it dissapear)
        self.navigationController?.setNavigationBarHidden(false, animated: true)
        updateColors()
        
        // This is for dismissing the keyboard on touching
        self.emotionNoteView.delegate = self
    } // End of Function viewDidLoad
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        updateView()
        updateColors()
    }  // End of Function viewWillAppear
    
    // This function makes the keyboard go away when typing around
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
    } // End of Function
    
    
    // MARK: - Functions
    func updateView() {
        if EmotionDetailViewController.emotionName == nil {
            emotionNameCheck = emotion?.emotionName ?? ""
        } else {
            emotionNameCheck = EmotionDetailViewController.emotionName!
        }
        
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
    
    // This will update the background color based on the emotion
    func updateColors() {
        let color: String = emotionNameCheck
        switch color {
        case "happy":
            self.view.backgroundColor = UIColor.yellow
        case "mad":
            self.view.backgroundColor = UIColor.red
        case "sad":
            self.view.backgroundColor = UIColor.blue
        case "afraid":
            self.view.backgroundColor = UIColor.purple
        default:
            self.view.backgroundColor = UIColor.white
        }
    } // End of Function
    
    
    // MARK: - Actions
    // These will update the strength status of how the person feels
    // Also updates the emotion strength data
    // TODO - Hightlight the one that you selected in some way
    @IBAction func firstBtnTap(_ sender: Any) {
        print("First Phone button tapped")
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
