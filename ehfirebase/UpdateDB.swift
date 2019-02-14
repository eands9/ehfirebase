//
//  UpdateDB.swift
//  ehfirebase
//
//  Created by Kyle Hernandez on 2/13/19.
//  Copyright © 2019 Eric Hernandez. All rights reserved.
//

import UIKit
import Firebase

class UpdateDB: UIViewController {

    @IBOutlet weak var categoryTxt: UITextField!
    @IBOutlet weak var timeTxt: UITextField!
    @IBOutlet weak var userNameTxt: UITextField!
    
    override func viewDidLoad() {

        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    

    @IBAction func updateBtn(_ sender: Any) {
        let userName = Auth.auth().currentUser?.email as! String
        let modUserName1 = userName.replacingOccurrences(of: "@", with: "")
        let modUsername2 = modUserName1.replacingOccurrences(of: ".", with: "")
        let refUserNameDB = Database.database().reference().child("Users").child(modUsername2).child(categoryTxt.text!)
        let refDictionary = ["AvgTime": timeTxt.text!, "Date": getCurrentShortDate()]

        
        refUserNameDB.setValue(refDictionary){
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
    
}
