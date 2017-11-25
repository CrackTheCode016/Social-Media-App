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

class FeedVC: UIViewController, UITableViewDelegate, UITableViewDataSource {

    @IBOutlet weak var feedTableView: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()
        feedTableView.delegate = self
        feedTableView.dataSource = self

    }
    
    @IBAction func signOutBtnPress(_ sender: Any) {
        dismiss(animated: true, completion: nil)
        print("REPORT: User signed out \(KeychainWrapper.standard.data(forKey: KEY_UID))")
        KeychainWrapper.standard.removeObject(forKey: KEY_UID)
        try! Auth.auth().signOut()
    }
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let cell = feedTableView.dequeueReusableCell(withIdentifier: "PostCell", for: indexPath) as? PostCell {
            cell.setCellUI()
            
            return cell
        }
        
        return UITableViewCell()
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 10
    }

}
