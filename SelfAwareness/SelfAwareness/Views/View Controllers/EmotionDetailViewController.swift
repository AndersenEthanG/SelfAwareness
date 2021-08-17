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
    @IBOutlet weak var saveBtn: UIBarButtonItem!
    
    // MARK: - Properties
    var emotion: Emotion?
    var emotionLevel: Int = 0
    static var emotionName: String?
    var emotionNameCheck: String = ""
    var noteText = ""
    
    
    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        // Make the navigation bar reappear (Main page makes it dissapear)
        self.navigationController?.setNavigationBarHidden(false, animated: true)
        // This is for dismissing the keyboard on touching
        self.emotionNoteView.delegate = self
        
        saveBtn.isEnabled = false
        updateView()
        
        // Keyboard moving the screen up and down a little
        NotificationCenter.default.addObserver(self, selector: #selector(EmotionDetailViewController.keyboardWillShow), name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(EmotionDetailViewController.keyboardWillHide), name: UIResponder.keyboardWillHideNotification, object: nil)
    
        datePicker.addTarget(self, action: #selector(datePickerChanged(picker:)), for: .valueChanged)
    } // End of Function viewDidLoad
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        updateView()
    }  // End of Function viewWillAppear
    
    // This function runs when the keyboard is touched
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        if emotionNoteView.text.isEmpty {
            updateNoteText()
        }
        self.view.endEditing(true)
    } // End of Function
    
    func textViewDidBeginEditing(_ noteTextView: UITextView) {
        if emotionNoteView.textColor == UIColor.darkGray {
            emotionNoteView.text = nil
            emotionNoteView.textColor = UIColor.black
        }
        
        if emotionNoteView.textColor == UIColor.lightGray {
            emotionNoteView.textColor = UIColor.white
        }
    } // End of Func
    
    
    // MARK: - Functions
    func updateView() {
        if EmotionDetailViewController.emotionName == nil {
            emotionNameCheck = emotion?.emotionName ?? ""
        } else {
            emotionNameCheck = EmotionDetailViewController.emotionName!
        }
        
        emotionNameLabel.text = "How \(emotionNameCheck) do you feel?"
        datePicker.date = emotion?.startTime ?? Date()
        emotionNoteViewUpdate()
        updateColors()
        
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
        if emotion?.note != "" {
            emotionNoteView.text = emotion?.note            
        } else {
            updateNoteText()
        }
        
        darkModeUpdate()
        updateNoteText()
    } // End of Function

    // Update Note text
    func updateNoteText() {
        if emotionNoteView.text == "" {
            emotionNoteView.text = "What changed?"
            
            if traitCollection.userInterfaceStyle == .dark {
                emotionNoteView.textColor = UIColor.lightGray
            } else {
                emotionNoteView.textColor = UIColor.darkGray
            }
            
        } else {
            saveBtn.isEnabled = true
            emotionNoteView.text = emotion?.note
            
            if traitCollection.userInterfaceStyle == .dark {
                emotionNoteView.textColor = UIColor.lightGray
            } else {
                emotionNoteView.textColor = UIColor.darkGray
            }
        }
    } // End of Function
    
    // Keyboard scooting the screen stuff
    // Other Keyboard hide stuff
    @objc func keyboardWillShow(notification: NSNotification) {
        guard let keyboardSize = (notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue)?.cgRectValue else {
            return
        }
        self.view.frame.origin.y = 0 - (keyboardSize.height / 2)
        saveBtn.isEnabled = true
    } // End of Function keyboard will show
    
    @objc func keyboardWillHide(notification: NSNotification) {
        self.view.frame.origin.y = 0
        
        if emotionNoteView.text == emotion?.note {
            saveBtn.isEnabled = false
        }
    } // End of Keyboard will hide Function
    
    
    // MARK: - Actions
    // These will update the strength status of how the person feels
    // Also updates the emotion strength data
    // TODO - Hightlight the one that you selected in some way
    @IBAction func firstBtnTap(_ sender: Any) {
        saveBtn.isEnabled = true
        emotionLevel = 0
        emotionEmojiTintUpdate(emotionIndex: 0)
    }
    @IBAction func secondBtnTap(_ sender: Any) {
        saveBtn.isEnabled = true
        emotionLevel = 1
        emotionEmojiTintUpdate(emotionIndex: 1)
    }
    @IBAction func thirdBtnTap(_ sender: Any) {
        saveBtn.isEnabled = true
        emotionLevel = 2
        emotionEmojiTintUpdate(emotionIndex: 2)
    }
    @IBAction func fourthBtnTap(_ sender: Any) {
        saveBtn.isEnabled = true
        emotionLevel = 3
        emotionEmojiTintUpdate(emotionIndex: 3)
    }
    @IBAction func fifthBtnTap(_ sender: Any) {
        saveBtn.isEnabled = true
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
    } // End of Save Button
    
    @objc func datePickerChanged(picker: UIDatePicker) {
        if datePicker.date != emotion?.timestamp {
            saveBtn.isEnabled = true
        } else {
            saveBtn.isEnabled = false
        }
    }
    
    func emotionNoteViewUpdate() {
        emotionNoteView.layer.borderWidth = 2
        
        if self.traitCollection.userInterfaceStyle == .dark {
            emotionNoteView.layer.borderColor = UIColor.white.cgColor
        } else {
            emotionNoteView.layer.borderColor = UIColor.black.cgColor
        }
        
        emotionNoteView.layer.cornerRadius = 10
    } // End of Function
    
} // End of Class
