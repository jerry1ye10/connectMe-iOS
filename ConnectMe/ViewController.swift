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

    @IBOutlet weak var createUser: UIButton!
    @IBOutlet weak var registerPass: UITextField!
    @IBOutlet weak var registerUser: UITextField!
    @IBOutlet weak var loginPass: UITextField!
    @IBOutlet weak var loginUser: UITextField!
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        let ref = Database.database().reference()
        ref.childByAutoId().setValue("Hello world")
    }

    @IBAction func createUser(_ sender: Any) {
        Auth.auth().createUser(withEmail: registerUser.text!, password: registerPass.text!) { authResult, error in
            if error == nil {
                print("Sucessfully loged in!")
            }
            else {
                
                print("Cannot log in the user")
            }
        }
    }
    
    @IBAction func loginUser(_ sender: Any) {
        Auth.auth().signIn(withEmail: "jerry1ye10@gmail.com", password: "abcdef") { [weak self] authResult, error in
            guard let strongSelf = self else { return }
            // ...
        }
    }
}

