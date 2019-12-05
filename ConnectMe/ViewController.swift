//
//  ViewController.swift
//  ConnectMe
//
//  Created by Jerry Ye on 11/18/19.
//  Copyright © 2019 Jerry Ye. All rights reserved.
//

import UIKit
import Firebase

class ViewController: UIViewController {

    @IBOutlet weak var loginPass: UITextField!
    @IBOutlet weak var loginUser: UITextField!
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
    }
    
    @IBAction func loginUser(_ sender: Any) {
        print(loginUser.text)
        Auth.auth().signIn(withEmail: loginUser.text!, password: loginPass.text!) { [weak self] authResult, error in
            if error == nil {
                self!.performSegue(withIdentifier: "loginSegue", sender: ViewController.self)
            }
            else {
                print("error")
            }
            
            
        }
    }
}

