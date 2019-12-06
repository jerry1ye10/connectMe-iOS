//
//  DetailViewController.swift
//  ConnectMe
//
//  Created by Jerry Ye on 12/4/19.
//  Copyright © 2019 Jerry Ye. All rights reserved.
//

import Foundation
import UIKit
import Firebase

class DetailViewController: UIViewController{
    
    @IBOutlet weak var name: UILabel!
    var lastName = String()
    var firstName = String()
    var phone = String()
    var email = String()
    var ID = String()
    var interestA = String()
    var interestB = String()
    
    @IBOutlet weak var interests: UILabel!
    @IBAction func connect(_ sender: Any) {
        let db = Firestore.firestore()
        var doc = db.collection("users").document(Auth.auth().currentUser!.uid)
        doc.updateData(["requests": [self.ID]]){ err in
        if let err = err {
            print("Error updating document: \(err)")
        } else {
            print("Document successfully updated")
            db.collection("users").document(self.ID).getDocument { (document, error) in
            if let document = document, document.exists {
                let data = document.data()
                let requests = data!["requests"] as! Array<String>
                if requests.contains(Auth.auth().currentUser!.uid){
        db.collection("users").document(Auth.auth().currentUser!.uid).updateData(["contacts": [self.ID]])
            db.collection("contacts").document(self.ID).updateData(["contacts": [Auth.auth().currentUser!.uid]])
                }
            } else {
                print("Document does not exist")
            }
        }
    }
    }
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        name.text = firstName + " " + lastName
        interests.text = firstName + " " + lastName + "interests are: " + interestA + "," + interestB + ". " + firstName + "is very excited to connect with you as soon as possible!"
        
        
        
    }

}

