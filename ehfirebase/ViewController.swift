//
//  ViewController.swift
//  ehfirebase
//
//  Created by Eric Hernandez on 2/12/19.
//  Copyright © 2019 Eric Hernandez. All rights reserved.
//

import UIKit
import Firebase

class ViewController: UIViewController {

    @IBOutlet weak var userNameTxt: UITextField!
    @IBOutlet weak var passwordTxt: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    @IBAction func loginBtn(_ sender: Any) {
        
    }
    @IBAction func registerBtn(_ sender: Any) {
        Auth.auth().createUser(withEmail: <#T##String#>, password: <#T##String#>, completion: <#T##AuthDataResultCallback?##AuthDataResultCallback?##(AuthDataResult?, Error?) -> Void#>)
    }
    
}

