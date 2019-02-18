//
//  ViewController.swift
//  ehfirebase
//
//  Created by Eric Hernandez on 2/12/19.
//  Copyright © 2019 Eric Hernandez. All rights reserved.
//

import UIKit
import Firebase
import SVProgressHUD

class ViewController: UIViewController {

    @IBOutlet weak var userNameTxt: UITextField!
    @IBOutlet weak var passwordTxt: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    @IBAction func loginBtn(_ sender: Any) {
        SVProgressHUD.show()
        
        Auth.auth().signIn(withEmail: userNameTxt.text!, password: passwordTxt.text!) { (user, error) in
            
            if error != nil {
                print(error!)
                print(error!._code)
                SVProgressHUD.dismiss()
            } else {
                print("Log in successful!")
                
                SVProgressHUD.dismiss()
                
                self.performSegue(withIdentifier: "goToUpdateDB", sender: self)
                
            }
            
        }
    }
    @IBAction func registerBtn(_ sender: Any) {
        Auth.auth().createUser(withEmail: userNameTxt.text!, password: passwordTxt.text!){ (user, error) in
            
            if error != nil {
                print(error!)
            } else {
                //success
                print("Registration Successful!")
                SVProgressHUD.dismiss()
                self.performSegue(withIdentifier: "goToUpdateDB", sender: self)
                
                let modUserName1 = self.userNameTxt.text!
                let modUserName2 = modUserName1.replacingOccurrences(of: "@", with: "")
                let modUsername3 = modUserName2.replacingOccurrences(of: ".", with: "")
                let refUserNameDB = Database.database().reference().child("Users").child(modUsername3)
                let refDictionary = ["Email": modUserName1]
                refUserNameDB.setValue(refDictionary){
                    (error,reference) in
                    if error != nil{
                        print(error!)
                    } else {
                        print("Message saved successfully!")
                        
                    }
                }
            }
        }
    }

}

