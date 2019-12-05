//
//  ContactsTableViewController.swift
//  Contacts
//
//  Created by Jerry Ye on 10/13/19.
//  Copyright © 2019 Jerry Ye. All rights reserved.
//

import UIKit
import Firebase



class ContactsTableViewController: UITableViewController{
    var connections = [User]()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        print(1)
        print(connections)
        if connections.count == 0{
           getData()
        }
        self.tableView.reloadData()
        
    }
    
    func getData(){
        let db = Firestore.firestore()
        db.collection("users").getDocuments(){ (querySnapshot, err) in
        if let err = err {
            print("Error getting documents: \(err)")
        } else {
            for doc in querySnapshot!.documents {
                let data = doc.data()
                let docRef = db.collection("users").document(Auth.auth().currentUser!.uid)

                docRef.getDocument { (document, error) in
                    if let document = document, document.exists {
                        let d = document.data()
                        print(d!["interest1"] as! String)
                        print(data["interest1"] as! String)
                        if data["interest1"] as! String == d!["interest1"] as! String || data["interest2"] as! String == d!["interest2"] as! String{
                            print(11)
                            let user = User(firstName: data["firstName"] as! String, lastName: data["lastName"] as! String, email: data["email"] as! String, phone: data["phone"] as! String, id: doc.documentID, interest1: data["interest1"] as! String, interest2: data["interest2"] as! String)
                            if user.id != Auth.auth().currentUser!.uid{
                            self.connections.insert(user, at: 0)
                                
                            }
                            self.tableView.reloadData()
                        }
                            
                    } else {
                        print("Document does not exist")
                    }
                }
            }
        }
            self.tableView.reloadData()
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
        label.text = connections[indexPath.row].firstName + " " + connections[indexPath.row].lastName
    }
    return cell
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if (segue.identifier == "details") {
            print(connections)
            let vc = segue.destination as! DetailViewController
            let index = tableView.indexPathForSelectedRow!.row
            let c = connections[index]
            vc.phone = c.phone
            vc.email = c.email
            vc.lastName = c.lastName
            vc.firstName = c.firstName
            vc.ID = c.id
            vc.interestA = c.interest1
            vc.interestB = c.interest2
            connections.remove(at: index)
            self.tableView.reloadData()
    }
        
    }

    
    

}
