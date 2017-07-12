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
import SwiftKeychainWrapper

class SignInVC: UIViewController {
    
    @IBOutlet weak var emailField: CustomTextField!
    @IBOutlet weak var passwordField: CustomTextField!
    
    
    

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
    }
    
    override func viewDidAppear(_ animated: Bool) {
        
        if let _ = KeychainWrapper.standard.string(forKey: KEY_UID) {
            
            performSegue(withIdentifier: "goToFeed", sender: nil)
            print("AllenData: successfully used keychain")
            
        }
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // TODO - Consider adding other sign up methods e.g. Twitter, Google, Pinterest(?), etc
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
                if let user = user {
                    self.completeSignIn(id: user.uid)
                }
            }
            
        })
        
    }
    // TODO: Read Firebase documentation and address the other possible fail cases e.g. password less than 6 characters
    @IBAction func signInBtnTapped(_ sender: Any) {
        
        if let email = emailField.text, let pwd = passwordField.text {
            Auth.auth().signIn(withEmail: email, password: pwd, completion: { (user, error) in
                if error == nil {
                    print("AllenSuccess: Yay user successfully authenticated with Firebase!")
                    if let user = user {
                        self.completeSignIn(id: user.uid)
                    }
                    
                } else {
                    Auth.auth().createUser(withEmail: email, password: pwd, completion: { (user, error) in
                    
                        if error != nil {
                            print("AllenError: Unable to authenticate with Firebase using email")
                        } else {
                            print("AllenSuccess: Successfully authenticated with Firebase")
                            if let user = user {
                                self.completeSignIn(id: user.uid)
                            }
                            
                        }
                    
                    })
                }
            })
        }
        
    }
    
    func completeSignIn(id: String) {
        
        let keychainResult = KeychainWrapper.standard.set(id, forKey: KEY_UID)
        self.performSegue(withIdentifier: GO_TO_FEED, sender: nil)
        print("AllenData: Data saved to keychain \(keychainResult)")
        
    }

}

