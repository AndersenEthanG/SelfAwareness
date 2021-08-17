//
//  AddTextInterfaceController.swift
//  SelfAwareness WatchKit Extension
//
//  Created by Ethan Andersen on 8/16/21.
//

import WatchKit
import Foundation
import WatchConnectivity


class AddTextInterfaceController: WKInterfaceController, WCSessionDelegate {

    // MARK: - Watch Connectivity
    func session(_ session: WCSession, activationDidCompleteWith activationState: WCSessionActivationState, error: Error?) {
        switch activationState {
        case .activated:
            print("Watch WCSession activated")
        case .inactive:
            print("Watch WCSession inactive")
        case .notActivated:
            print("Watch WCSession not activated")
        default:
            print("Something went wrong on the WC Session activation!")
        } // End of Switch
    } // End of Function
    
    // Transfer User Information (Background send Message)
    func sendMessage(message: Message) {
        if session.activationState == .activated {
            let formatedMessage: [String : Any] = ["emotionName" : message.emotionName, "emotionLevel" : message.emotionLevel, "note" : message.note, "timestamp" : Date()]
            
            session.transferUserInfo(formatedMessage)
        }
    } // End of Function
    var session = WCSession.default
    
    
    func setupWatchDelegate() {
        let session = WCSession.default
        session.delegate = self
        session.activate()
    }
     // End of Watch Connectivity

    
    // MARK: - Outlets
    @IBOutlet weak var noteLabel: WKInterfaceLabel!
    @IBOutlet weak var yesBtn: WKInterfaceButton!
    @IBOutlet weak var saveBtn: WKInterfaceButton!
    
    
    // MARK: - Properties
    static var message: Message?

    
    // MARK: - Lifecycle
    override func awake(withContext context: Any?) {
        super.awake(withContext: context)
        
        setupWatchDelegate()
        // Configure interface objects here.
    } // End of awake

    
    // MARK: - Functions
    @IBAction func addNoteBtn() {
        self.presentTextInputController(withSuggestions: nil, allowedInputMode: .allowEmoji) { note in
            guard let note = note?[0] as? String else { return }
            
            OperationQueue.main.addOperation {
                self.dismissTextInputController()
                
                // Send message
                var noteMessage = AddTextInterfaceController.message
                noteMessage?.note = note
                AddTextInterfaceController.message = noteMessage
                
                // Update view
                self.noteLabel.setText(note)
                self.yesBtn.setTitle("Edit")
                self.saveBtn.setTitle("All done - Save")
            }
        }
    } // End of Function
    
    @IBAction func saveBtnTapped() {
        guard let finalMessage = AddTextInterfaceController.message else { return }
        sendMessage(message: finalMessage)
        pushController(withName: "messageVC", context: nil)
    } // End of Function
    
} // End of Class
