//
//  PostCell.swift
//  Social Media
//
//  Created by Santiago on 11/24/17.
//  Copyright © 2017 Santiago. All rights reserved.
//

import UIKit

class PostCell: UITableViewCell {

    @IBOutlet weak var postImg: PostImage!
    @IBOutlet weak var descLabel: UILabel!
    func setCellUI() {
        postImg.image = UIImage(named: "crackit")
        descLabel.text = "Sample desc, this should show in the right area in the post."
    }

}
