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

class FeedVC: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */
    @IBAction func signInTapped(_ sender: Any) {
        
        KeychainWrapper.standard.removeObject(forKey: KEY_UID)
        print("AllenData: ID removed from keychain")
        try! Auth.auth().signOut()
        performSegue(withIdentifier: GO_TO_SIGN_IN, sender: nil)
        
    }

}
