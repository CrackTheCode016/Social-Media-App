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

class SignInVC: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
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
    
    func firebaseAuth(_ cred: AuthCredential) {
        Auth.auth().signIn(with: cred, completion: {(user, error) in
            if error != nil {
                print("REPORT: UNABLE TO AUTH TO FIREBASE. \(error)")
            }
            
            else {
                print("REPORT: FIREBASE AUTH SUCESSFUL :D")
            }
            
        })
        
    }
    
}

