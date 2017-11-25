//
//  Constants.swift
//  Social Media
//
//  Created by Santiago on 11/10/17.
//  Copyright © 2017 Santiago. All rights reserved.
//

import Foundation
import UIKit
import SwiftKeychainWrapper
import Firebase
import FirebaseAuth

let SHADOW_GRAY: CGFloat = 120.0 / 255.0
let TEXT_COLOR = UIColor(red: 239, green: 239, blue: 244, alpha: 0.5)
let KEY_UID = "uid"


func completeSignIn(id: String) {
    KeychainWrapper.standard.set(id, forKey: KEY_UID)
    print("REPORT: Data saved to keychain.")
}


func firebaseAuth(_ cred: AuthCredential) {
    Auth.auth().signIn(with: cred, completion: {(user, error) in
        if error != nil {
            print("REPORT: UNABLE TO AUTH TO FIREBASE: \(error.debugDescription)")
        }
            
        else {
            print("REPORT: FIREBASE AUTH SUCESSFUL :D")
            if let user = user {
                completeSignIn(id: user.uid)
            }
        }
        
    })
    
}
