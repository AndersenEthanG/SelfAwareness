//
//  EmotionViewController.swift
//  SelfAwareness
//
//  Created by Ethan Andersen on 6/4/21.
//

import UIKit
import WatchConnectivity

class EmotionViewController: UIViewController, WCSessionDelegate {

    // MARK: - Watch Connectivity
    func session(_ session: WCSession, activationDidCompleteWith activationState: WCSessionActivationState, error: Error?) {
        switch activationState {
        case .activated:
            print("Phone WCSession activated")
        case .inactive:
            print("Phone WCSession inactive")
        case .notActivated:
            print("Phone WCSession not activated")
        default:
            print("Something went wrong on the Phone WC Session activation!")
        } // End of Switch
    }
    func sessionDidBecomeInactive(_ session: WCSession) { print("Phone session did become inactive") }
    func sessionDidDeactivate(_ session: WCSession) { print("Phone session did deactivate") }
    // End of Basic Watch Connectivity functions
    
    
    func session(_ session: WCSession, didReceiveUserInfo userInfo: [String : Any] = [:]) {
        print("Received user info from Watch!")
        watchToPhoneUpdate(message: userInfo)
    }
    
    func watchToPhoneUpdate(message: [String : Any]) {
        print(message)
        let watchEmotionName = message["emotionName"]
        let watchEmotionLevel = message["emotionLevel"]
        let watchTimestamp = message["timestamp"]
        
        EmotionController.sharedInstance.createEmotion(emotionName: watchEmotionName as! String, emotionLevel: watchEmotionLevel as! Int, timestamp: watchTimestamp as! Date)
    }
    
    
    // MARK: - Outlets
    @IBOutlet weak var tableView: UITableView!
    
    
    // MARK: - Properties
    var emotions: [Emotion] = []
    var emotionEmojis: [String] = []
    var emotionName: String = ""
    var emotionLevel: Int = 0
    var message: [String: Any] = ["emotionName" : "", "emotionLevel" : 0]
    
    
    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.dataSource = self
        tableView.delegate = self
        
        // Watch Connectivity support
        if WCSession.isSupported() {
            let session = WCSession.default
            session.delegate = self
            session.activate()
        }
        NotificationCenter.default.addObserver(self, selector: #selector(fetchEmotions), name: UIApplication.didBecomeActiveNotification, object: nil)
        EmotionController.sharedInstance.fetchEmotion()
        tableView.reloadData()
    } // End of View Did Load
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        tableView.reloadData()
    } // End of View Will Appear
    
    
    // MARK: - Actions
    @IBAction func happyBtnTap(_ sender: Any) {
        let emotion = "happy"
        emotionEmojis = Emotion.emojisGrabber(emotion: emotion)
        EmotionDetailViewController.emotionName = emotion
    }
    
    @IBAction func madBtnTap(_ sender: Any) {
        let emotion = "mad"
        emotionEmojis = Emotion.emojisGrabber(emotion: emotion)
        EmotionDetailViewController.emotionName = emotion
    }
    
    @IBAction func sadBtnTap(_ sender: Any) {
        let emotion = "sad"
        emotionEmojis = Emotion.emojisGrabber(emotion: emotion)
        EmotionDetailViewController.emotionName = emotion
    }
    
    @IBAction func afraidBtnTap(_ sender: Any) {
        let emotion = "afraid"
        emotionEmojis = Emotion.emojisGrabber(emotion: emotion)
        EmotionDetailViewController.emotionName = emotion
    }
    
    
    // MARK: - Functions
    @objc func fetchEmotions() {
        EmotionController.sharedInstance.fetchEmotion()
    } // End of Function
    
    
    // MARK: - Navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "toEmotionDetailVC" {
            guard let destinationVC = segue.destination as? EmotionDetailViewController,
                  let indexPath = tableView.indexPathForSelectedRow else { return }
            
            let emotion = EmotionController.sharedInstance.emotions[indexPath.row]
            destinationVC.emotion = emotion
            EmotionDetailViewController.emotionName = nil
        }
    } // End of Segue Function
    
} // End of Class

// MARK: - Extensions
extension EmotionViewController: UITableViewDelegate, UITableViewDataSource {
    
    // Cell content
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "emotionCell", for: indexPath) as? EmotionTableViewCell
        let emotion = EmotionController.sharedInstance.emotions[indexPath.row]
        cell?.emotion = emotion
        
        return cell ?? UITableViewCell()
    }
    
    // Cell count
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return EmotionController.sharedInstance.emotions.count
    }
    
    // Delete cell
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            let emotionToDelete = EmotionController.sharedInstance.emotions[indexPath.row]
            EmotionController.sharedInstance.deleteEmotion(emotion: emotionToDelete)
            tableView.deleteRows(at: [indexPath], with: .fade)
        }
    } // End of Function
    
} // End of Extension
