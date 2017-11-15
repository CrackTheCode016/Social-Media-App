//
//  FeedVC.swift
//  Social Media
//
//  Created by Santiago on 11/15/17.
//  Copyright © 2017 Santiago. All rights reserved.
//

import UIKit
import Firebase
import FirebaseAuth
import SwiftKeychainWrapper

class FeedVC: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

    }
    
    @IBAction func signOutBtnPress(_ sender: Any) {
        
        dismiss(animated: true, completion: nil)
        KeychainWrapper.standard.removeObject(forKey: KEY_UID)
        try! Auth.auth().signOut()
        
        
        
       
    }
    

}
