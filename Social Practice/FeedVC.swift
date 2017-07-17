//
//  FeedVC.swift
//  Social Practice
//
//  Created by Allen Czerwinski on 7/11/17.
//  Copyright © 2017 Allen Czerwinski. All rights reserved.
//

import UIKit
import Firebase
import SwiftKeychainWrapper

class FeedVC: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    @IBOutlet weak var tableView: UITableView!

    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.delegate = self
        tableView.dataSource = self

        DataService.ds.REF_POSTS.observe(.value, with: { (snapshot) in
            
            print(snapshot.value)
            
        })
        
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 3
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        return tableView.dequeueReusableCell(withIdentifier: "PostCell") as! PostCell
    }
    
    @IBAction func signInTapped(_ sender: Any) {
        
        KeychainWrapper.standard.removeObject(forKey: KEY_UID)
        print("AllenData: ID removed from keychain")
        try! Auth.auth().signOut()
        performSegue(withIdentifier: GO_TO_SIGN_IN, sender: nil)
        
    }

}
