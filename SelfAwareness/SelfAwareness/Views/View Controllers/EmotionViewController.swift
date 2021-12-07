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
    
    
    // Landing pad for the watch message
    func session(_ session: WCSession, didReceiveUserInfo userInfo: [String : Any] = [:]) {
        print("Received user info from Watch!")
        watchToPhoneUpdate(message: userInfo)
    }
    
    // This is the function to create an emotion from the watch data
    func watchToPhoneUpdate(message: [String : Any]) {
        print(message)
        let watchEmotionName = message["emotionName"]
        let watchEmotionLevel = message["emotionLevel"]
        let watchNote = message["note"]
        let watchTimestamp = message["timestamp"]
        
        EmotionController.sharedInstance.createEmotion(emotionName: watchEmotionName as! String, emotionLevel: watchEmotionLevel as! Int, emotionNote: watchNote as? String ?? "", timestamp: watchTimestamp as? Date ?? Date())
        
        refreshApp()
    } // End of function watch to phone update
    
    
    // MARK: - Outlets
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var emotionPickerView: UIView!
    @IBOutlet weak var sortByButtonOutlet: UIButton!
    
    
    // Buttons
    @IBOutlet weak var happyBtn: UIButton!
    @IBOutlet weak var madBtn: UIButton!
    @IBOutlet weak var sadBtn: UIButton!
    @IBOutlet weak var afraidBtn: UIButton!
    
    
    // MARK: - Properties
    var filteredEmotions: [Emotion] = []
    var unfilteredEmotions: [Emotion] = []
    var emotionEmojis: [String] = []
    var emotionName: String = ""
    var emotionLevel: Int = 0
    var message: [String: Any] = ["emotionName" : "", "emotionLevel" : 0]
    
    // Filter by
    var showHappy = true
    var showMad = true
    var showSad = true
    var showAfraid = true
    var showChronological = true
    
    
    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        /*
        // This makes the navigation item on the main page go away
        self.navigationController?.overrideUserInterfaceStyle = .light
        self.navigationController?.setNavigationBarHidden(true, animated: true)
        */
        
        tableView.dataSource = self
        tableView.delegate = self
        
        darkModeUpdate()
        updateBtns()
        
        // Watch Connectivity support
        if WCSession.isSupported() {
            let session = WCSession.default
            session.delegate = self
            session.activate()
        }
        
        unfilteredEmotions = EmotionController.sharedInstance.fetchEmotion()
        filterEmotions()
        tableView.reloadData()
        
        // Refreshes app frequently
        refreshApp()
    } // End of View Did Load
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        // Depreciated
//        updateBackground()
        
        updateBtns()
        darkModeUpdate()
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

    @IBAction func sorByButton(_ sender: Any) {
        let alert = UIAlertController(title: "How would you like your logs displayed?", message: "Press a button to toggle visibility", preferredStyle: .actionSheet)
        
        // Buttons
        let happyAlertBtn = UIAlertAction(title: "Happy", style: .default) { _ in
            self.showHappy.toggle()
            self.filterEmotions()
            self.tableView.reloadData()
        } // End of Happy Button
        
        let madAlertBtn = UIAlertAction(title: "Mad", style: .default) { _ in
            self.showMad.toggle()
            self.filterEmotions()
            self.tableView.reloadData()
        } // End of Mad Button
        
        let sadAlertBtn = UIAlertAction(title: "Sad", style: .default) { _ in
            self.showSad.toggle()
            self.filterEmotions()
            self.tableView.reloadData()
        } // End of Sad button
        
        let afraidAlertBtn = UIAlertAction(title: "Afraid", style: .default) { _ in
            self.showAfraid.toggle()
            self.filterEmotions()
            self.tableView.reloadData()
        } // End of Afraid button
        
        let chronologicalAlertBtn = UIAlertAction(title: "Descending", style: .default) { _ in
            self.showChronological.toggle()
            self.filterEmotions()
            self.tableView.reloadData()
        } // End of Chronological button
        
        let doneAlertBtn  = UIAlertAction(title: "Close", style: .cancel) { _ in
            self.tableView.reloadData()
        } // End of Done button
        
        // Button changing based on whats happening
        if showHappy == true {
            happyAlertBtn.setValue("Happy ✓", forKey: "title")
        } else {
            happyAlertBtn.setValue("Happy 𐄂", forKey: "title")
        }
        
        if showMad == true {
            madAlertBtn.setValue("Mad ✓", forKey: "title")
        } else {
            madAlertBtn.setValue("Mad 𐄂", forKey: "title")
        }
        
        if showSad == true {
            sadAlertBtn.setValue("Sad ✓", forKey: "title")
        } else {
            sadAlertBtn.setValue("Sad 𐄂", forKey: "title")
        }
        
        if showAfraid == true {
            afraidAlertBtn.setValue("Afraid ✓", forKey: "title")
        } else {
            afraidAlertBtn.setValue("Afraid 𐄂", forKey: "title")
        }
        
        if showChronological == true {
            chronologicalAlertBtn.setValue("Date Descending", forKey: "title")
        } else {
            chronologicalAlertBtn.setValue("Date Ascending", forKey: "title")
        }
        
        // Alert finalization and creation
        alert.addAction(happyAlertBtn)
        alert.addAction(madAlertBtn)
        alert.addAction(sadAlertBtn)
        alert.addAction(afraidAlertBtn)
        alert.addAction(doneAlertBtn)
        
        present(alert, animated: true, completion: nil)
    } // End of Sort by button
    
    
    // MARK: - Functions
    func refreshApp() {
        tableView.reloadData()
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 3600) {
            self.refreshApp()
        }
    } // End of Refresh app
    
    func filterEmotions() {
        let unfilteredEmotions = self.unfilteredEmotions
        var finalFilteredEmotions: [Emotion] = []
        
        for emotion in unfilteredEmotions {
            let emotionName = emotion.emotionName
            
            switch emotionName {
            case "happy":
                if showHappy == true {
                    finalFilteredEmotions.append(emotion)
                }
            case "mad":
                if showMad == true {
                    finalFilteredEmotions.append(emotion)
                }
            case "sad":
                if showSad == true {
                    finalFilteredEmotions.append(emotion)
                }
            case "afraid":
                if showAfraid == true {
                    finalFilteredEmotions.append(emotion)
                }
            case .none:
                print("Is line \(#line) working?")
            case .some(_):
                print("Is line \(#line) working?")
            } // End of Switch
        } // End of For loop
        
        filteredEmotions = finalFilteredEmotions
    } // End of Filter Emotions
    
    
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
        let emotion = filteredEmotions[indexPath.row]
        
        if traitCollection.userInterfaceStyle == .light {
            cell?.backgroundColor = CellColors.getColor(emotionName: emotion.emotionName!)
        } else if traitCollection.userInterfaceStyle == .dark {
            let emotionNameDark = (emotion.emotionName! + "Dark")
            cell?.backgroundColor = CellColors.getColor(emotionName: emotionNameDark)
        }
        
        cell?.emotion = emotion
        
        return cell ?? UITableViewCell()
    }

    // Cell count
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return filteredEmotions.count
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
