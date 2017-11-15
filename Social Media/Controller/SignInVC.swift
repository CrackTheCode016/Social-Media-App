//
//  ViewController.swift
//  Social Media
//
//  Created by Santiago on 11/9/17.
//  Copyright © 2017 Santiago. All rights reserved.
//

import UIKit
import FBSDKCoreKit
import FBSDKLoginKit
import Firebase
import FirebaseAuth
import SwiftKeychainWrapper

class SignInVC: UIViewController {

    @IBOutlet weak var signInStackView: UIStackView!
    @IBOutlet weak var emailField: UITextField!
    @IBOutlet weak var passField: UITextField!
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        emailField.keyboardType = .emailAddress
        emailField.clearButtonMode = .whileEditing
        passField.isSecureTextEntry = true
        passField.clearButtonMode = .whileEditing
    }
    
    override func viewDidAppear(_ animated: Bool) {
        if let _ = KeychainWrapper.standard.string(forKey: KEY_UID) {
            performSegue(withIdentifier: "toFeedVC", sender: nil)
        }
    }
  
    @IBAction func fbBtnTapped(_ sender: Any) {
        let facebookLogin = FBSDKLoginManager()
        facebookLogin.logIn(withReadPermissions: ["email"], from: self, handler: {result, error in
            if error != nil {
                print("REPORT: NOT ABLE TO SIGN IN. FATAL ERROR. \(error)")
            }
            
            else if result?.isCancelled == true {
                print("REPORT: USER CANCELLED FB AUTH")
            }
            
            else {
                print("REPORT: SUCCESS.  USER AUTH WITH FACEBOOK.")
                let cred = FacebookAuthProvider.credential(withAccessToken: FBSDKAccessToken.current().tokenString)
                    self.firebaseAuth(cred)
            }
            
            
        })
        
    }
    
    @IBAction func emailSignInTapped(_ sender: Any) {
        if let email = emailField.text, let pass = passField.text {
            Auth.auth().signIn(withEmail: email, password: pass, completion: {(user, error) in
                
            
                if error == nil {
                    print("REPORT: User is hunkey-dory!")
                    if let user = user {
                        self.completeSignIn(id: user.uid)
                    }
                }
                else {
                    Auth.auth().createUser(withEmail: email, password: pass, completion: {(user, error) in
                        if error != nil {
                            print("REPORT: Failed to auth to firebase using email")
                        }
                        
                        else {
                            print("REPORT: Success! Authed with Firebase")
                            if let user = user {
                                self.completeSignIn(id: user.uid)
                            }
                        }
                        
                    })
                }
            })
        }
        
    }
    
    
    func firebaseAuth(_ cred: AuthCredential) {
        Auth.auth().signIn(with: cred, completion: {(user, error) in
            if error != nil {
                print("REPORT: UNABLE TO AUTH TO FIREBASE. \(error)")
            }
            
            else {
                print("REPORT: FIREBASE AUTH SUCESSFUL :D")
                if let user = user {
                    self.completeSignIn(id: user.uid)
                }
            }
            
        })
        
    }
    
    func completeSignIn(id: String) {
        KeychainWrapper.standard.set(id, forKey: KEY_UID)
        print("REPORT: Data saved to keychain.")
        performSegue(withIdentifier: "toFeedVC", sender: nil)

    }
}

