//
//  SignInVC.swift
//  Social Practice
//
//  Created by Allen Czerwinski on 6/26/17.
//  Copyright © 2017 Allen Czerwinski. All rights reserved.
//

import UIKit
import FBSDKCoreKit
import FBSDKLoginKit
import Firebase

class SignInVC: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    @IBAction func facebookBtnTapped(_ sender: Any) {
        
        let facebookLogin = FBSDKLoginManager()
        
        /*facebookLogin.logIn(withReadPermissions: ["email"], from: self, handler: {(result, error) in
            
            if error != nil {
                print("AllenError: Login error \(error!)")
            } else if result?.isCancelled == true {
                print("AllenError: User canceled FB authentication")
            } else {
                print("AllenSuccess: successfully authenticated with FB")
                let credential = FacebookAuthProvider.credential(withAccessToken: FBSDKAccessToken.current().tokenString)
                
                self.firebaseAuth(credential)
            }
            
        })*/
        
        facebookLogin.logIn(withReadPermissions: ["email"], from: self) { (result, error) in
            
            if error != nil {
                print("AllenError: Login error \(error!)")
            } else if result?.isCancelled == true {
                print("AllenError: User canceled FB authentication")
            } else {
                print("AllenSuccess: successfully authenticated with FB")
                let credential = FacebookAuthProvider.credential(withAccessToken: FBSDKAccessToken.current().tokenString)
                self.firebaseAuth(credential)
            }
        
        }
        
    }
    
    func firebaseAuth(_ credential: AuthCredential) {
        
        Auth.auth().signIn(with: credential, completion: { (user, error) in
            
            if error != nil {
                print("AllenError: Unable to authenticate with Firebase \(error!)")
            } else {
                print("AllenSuccess: Successfully authenticated with Firebase")
            }
            
        })
        
    }

}

