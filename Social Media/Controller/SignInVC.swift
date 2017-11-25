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
import GoogleSignIn

class SignInVC: UIViewController, GIDSignInUIDelegate  {
 
    

    @IBOutlet weak var signInStackView: UIStackView!
    @IBOutlet weak var emailField: UITextField!
    @IBOutlet weak var passField: UITextField!
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        passField.isSecureTextEntry = true
        emailField.keyboardType = .emailAddress
        emailField.clearButtonMode = .whileEditing
        passField.clearButtonMode = .whileEditing
        GIDSignIn.sharedInstance().uiDelegate = self
    }
    
    override func viewDidAppear(_ animated: Bool) {
        if let _ = KeychainWrapper.standard.string(forKey: KEY_UID) {
            segueToFeed()
        }
    }
    
    func segueToFeed() {performSegue(withIdentifier: "toFeedVC", sender: nil)}
    
     
    @IBAction func googleSignInTap(_ sender: Any) {
        GIDSignIn.sharedInstance().signIn()
        segueToFeed()
    }
    
    @IBAction func fbBtnTapped(_ sender: Any) {
        let facebookLogin = FBSDKLoginManager()
        facebookLogin.logIn(withReadPermissions: ["email"], from: self, handler: {result, error in
            if error != nil {
                print("REPORT: NOT ABLE TO SIGN IN. FATAL ERROR: \(error.debugDescription)")
            }
            
            else if result?.isCancelled == true {
                print("REPORT: USER CANCELLED FB AUTH")
            }
            
            else {
                print("REPORT: SUCCESS.  USER AUTH WITH FACEBOOK.")
                let cred = FacebookAuthProvider.credential(withAccessToken: FBSDKAccessToken.current().tokenString)
                    firebaseAuth(cred)
                    self.segueToFeed()
            }
        })
    }
    
    @IBAction func emailSignInTapped(_ sender: Any) {
        if let email = emailField.text, let pass = passField.text {
            Auth.auth().signIn(withEmail: email, password: pass, completion: {(user, error) in
                
            
                if error == nil {
                    print("REPORT: User signed in.")
                    if let user = user {
                        completeSignIn(id: user.uid)
                        self.segueToFeed()
                    }
                }
                else {
                    Auth.auth().createUser(withEmail: email, password: pass, completion: {(user, error) in
                        if error != nil {
                            print("REPORT: Failed to auth to firebase using email")
                        }
                        
                        else {
                            print("REPORT: User signed up")
                            if let user = user {
                                completeSignIn(id: user.uid)
                                self.segueToFeed()
                            }
                        }
                        
                    })
                }
            })
        }
        
    }
    
   
    
}

