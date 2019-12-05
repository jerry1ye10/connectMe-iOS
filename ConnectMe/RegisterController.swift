//
//  RegisterController.swift
//  ConnectMe
//
//  Created by Jerry Ye on 12/4/19.
//  Copyright © 2019 Jerry Ye. All rights reserved.
//

import Foundation
import UIKit
import Firebase

class RegisterController: UIViewController{
   @IBOutlet weak var registerPass: UITextField!
   @IBOutlet weak var registerUser: UITextField!
    @IBOutlet weak var registerfName: UITextField!
    @IBOutlet weak var registerlName: UITextField!
    @IBOutlet weak var interest2: UITextField!
    @IBOutlet weak var interest3: UITextField!
    @IBOutlet weak var phone: UITextField!
    
    @IBOutlet weak var interests: UITextField!
    @IBAction func createUser(_ sender: Any) {
        let db = Firestore.firestore()
           Auth.auth().createUser(withEmail: registerUser.text!, password: registerPass.text!) { authResult, error in
               if error == nil {
                print("Sucessfully loged in!")
                print(Auth.auth().currentUser)
                db.collection("users").document(Auth.auth().currentUser!.uid).setData([
                    "email": self.registerUser.text!, "firstName": self.registerfName.text!, "lastName": self.registerlName.text!,"phone": self.phone.text!, "contacts": [String](), "requests":[String](), "interest1": self.interest2.text!, "interest2": self.interest3.text!, "connections": [String]()])
                self.performSegue(withIdentifier: "registerSegue", sender: ViewController.self)
               }
               else {
                   
                   print("Cannot log in the user")
               }
           }
       }
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
    }
}
