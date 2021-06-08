//
//  EmotionViewController.swift
//  SelfAwareness
//
//  Created by Ethan Andersen on 6/4/21.
//

import UIKit
import WatchConnectivity

class EmotionViewController: UIViewController  {

    // MARK: - Outlets
    @IBOutlet weak var tableView: UITableView!
    
    
    // MARK: - Properties
    var emotions: [Emotion] = []
    var emotionEmojis: [String] = []
    var emotionName: String = ""
    var emotionLevel: Int = 0
    
    
    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.dataSource = self
        tableView.delegate = self
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
    
    
    // MARK: - Navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "toEmotionDetailVC" {
            guard let destinationVC = segue.destination as? EmotionDetailViewController,
                  let indexPath = tableView.indexPathForSelectedRow else { return }
            
            let emotion = EmotionController.sharedInstance.emotions[indexPath.row]
            destinationVC.emotion = emotion
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
