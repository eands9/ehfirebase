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
            }
        }
    }
    
}

