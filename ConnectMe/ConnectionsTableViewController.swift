//
//  ContactsTableViewController.swift
//  Contacts
//
//  Created by Jerry Ye on 10/13/19.
//  Copyright © 2019 Jerry Ye. All rights reserved.
//

import UIKit
import Firebase

class ConnectionsTableViewController: UITableViewController{
    var connections = [User]()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        print(10)
        print(connections)
        getData()
        self.tableView.reloadData()
        
    }
    
    func getData(){
        let db = Firestore.firestore()
        db.collection("users").document(Auth.auth().currentUser!.uid).getDocument { (document, error) in
            if let document = document, document.exists {
                let data = document.data()
                print(data)
                let contacts = data!["contacts"] as! Array<String>
                print(contacts)
                for x in contacts{
                    db.collection("users").document(x).getDocument(){ (querySnapshot, err) in
                    if let err = err {
                        print("Error getting documents: \(err)")
                    } else {
                            let data = document.data()
                        let user = User(firstName: data!["firstName"] as! String, lastName: data!["lastName"] as! String, email: data!["email"] as! String, phone: data!["phone"] as! String, id: "1", interest1: data!["interest1"] as! String, interest2: data!["interest2"] as! String
                        )
                            self.connections.insert(user, at: 0)
                        print(user.email)
                        self.tableView.reloadData()
                    }
                        
                    }
                    self.tableView.reloadData()
                }
            } else {
                print("Document does not exist")
            }
        }
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 100.0
    }
    override func numberOfSections(in tableView: UITableView) -> Int {
        // TODO: How many sections? (Hint: we have 1 section and x rows)
        return 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // TODO: How many rows in our section?
        return connections.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    let cell = tableView.dequeueReusableCell(withIdentifier: "Prototype", for: indexPath)
    if let label = cell.viewWithTag(1) as? UILabel {
        label.text = connections[indexPath.row].firstName + " " + connections[indexPath.row].lastName + ": " + connections[indexPath.row].email
    }
    return cell
    }
    
    

    
    

}
