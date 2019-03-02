//
//  UpdateDB.swift
//  ehfirebase
//
//  Created by Kyle Hernandez on 2/13/19.
//  Copyright © 2019 Eric Hernandez. All rights reserved.
//

import UIKit
import Firebase
import Speech

class UpdateDB: UIViewController {

    @IBOutlet weak var categoryTxt: UITextField!
    @IBOutlet weak var timeTxt: UITextField!
    @IBOutlet weak var userNameTxt: UITextField!
    
    var timer = Timer()
    var counter = 0.0
    var averageTime = 0
    
    override func viewDidLoad() {

        super.viewDidLoad()
        observeUpdate()
        setImproperlyClosedToN()
        startTimer()
        // Do any additional setup after loading the view.
    }
    

    @IBAction func updateBtn(_ sender: Any) {
        let userName = Auth.auth().currentUser?.email as! String
        let modUserName1 = userName.replacingOccurrences(of: "@", with: "")
        let modUsername2 = modUserName1.replacingOccurrences(of: ".", with: "")
        let refUserNameDB = Database.database().reference().child("Users").child(modUsername2).child(categoryTxt.text!)
        let timeInSeconds = Int(timeTxt.text!)

        refUserNameDB.setValue(["AvgTime": timeInSeconds, "Date": getCurrentShortDate()]){
            (error,reference) in
            if error != nil{
                print(error!)
            } else {
                print("Message saved successfully!")

            }
        }
    }
    
    func getCurrentShortDate() -> String {
        let todaysDate = Date()
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd"
        let DateInFormat = dateFormatter.string(from: todaysDate)
        
        return DateInFormat
    }
    @IBAction func retrieveBtn(_ sender: Any) {
        let messageDB = Database.database().reference().child("Users").child("eands9yahoocom").child("1A1")
        
        messageDB.observe(DataEventType.value, with: {(snapshot) in
            self.averageTime = (snapshot.value as? Int)!
            //let snapshotValue = snapshot.value as? [String : AnyObject] ?? [:]
            //averageTime = snapshotValue["AvgTime"]
            
            
            //let averageTime = snapshotValue["AvgTime"]
            self.userNameTxt.text = "\(self.averageTime)"
            //self.readMe(myText: "Kate's average time is \(averageTime) seconds.")
        })
        
        print(averageTime)
    }
    func observeUpdate(){
        let messageDB = Database.database().reference().child("Users").child("eands9yahoocom").child("1A1")
        
        messageDB.observe(DataEventType.value, with: {(snapshot) in
            let snapshotValue = snapshot.value as? [String : AnyObject] ?? [:]
            let averageTime = snapshotValue["AvgTime"]!
            print(averageTime)
            self.userNameTxt.text = "\(averageTime)"
            self.readMe(myText: "Kate's average time is \(averageTime) seconds.")
        })
    }
        
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        let touchCount = touches.count
        let touch = touches.first
        let tapCount = touch!.tapCount
        
        categoryTxt.text = "touchesBegan"
        //timeTxt.text = "\(touchCount) touches"
        //userNameTxt.text = "\(tapCount) taps"
        print("start touching")
        stopTimer()
    }
    @objc func fireTimer() {
        counter += 1
        userNameTxt.text = "\(counter)"
        
        if counter == 5{
            readMe(myText: "Get back to work!")
        }
        
    }
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        let touchCount = touches.count
        let touch = touches.first
        let tapCount = touch!.tapCount
        
        categoryTxt.text = "touchesEnded";
        //timeTxt.text = "\(touchCount) touches"
        //userNameTxt.text = "\(tapCount) taps"
        print("stopped touching")
        
        startTimer()
    }
    func stopTimer(){
        timer.invalidate()
    }
    func startTimer(){
        counter = 0
        userNameTxt.text = "\(counter)"
        timer = Timer.scheduledTimer(timeInterval: 1.0, target: self, selector: #selector(fireTimer), userInfo: nil, repeats: true)
    }
    
    func readMe( myText: String) {
        let utterance = AVSpeechUtterance(string: myText )
        utterance.voice = AVSpeechSynthesisVoice(language: "en-US")
        utterance.rate = 0.5
        
        let synthesizer = AVSpeechSynthesizer()
        synthesizer.speak(utterance)
    }
    func setImproperlyClosedToN(){
        let userName1 = Auth.auth().currentUser?.email as! String
        let modUserName11 = userName1.replacingOccurrences(of: "@", with: "")
        let modUsername21 = modUserName11.replacingOccurrences(of: ".", with: "")
        let improperlyClosedDB = Database.database().reference().child("Users").child(modUsername21)
        
        improperlyClosedDB.updateChildValues(["ImproperlyClosed": "N"]){
            //improperlyClosedDB.setValue(["ImproperlyClosed": "Y"]){
            (error,reference) in
            if error != nil{
                print(error!)
            } else {
                print("Message saved successfully!")
                
            }
            
        }
    }
}
