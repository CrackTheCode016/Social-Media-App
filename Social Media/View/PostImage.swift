//
//  PostImage.swift
//  Social Media
//
//  Created by Santiago on 11/24/17.
//  Copyright © 2017 Santiago. All rights reserved.
//

import UIKit

class PostImage: UIImageView {

    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        layer.shadowColor = UIColor(red: SHADOW_GRAY, green: SHADOW_GRAY, blue: SHADOW_GRAY, alpha: 0.6).cgColor
        layer.shadowOpacity = 0.8
        layer.shadowRadius = 5.0
        layer.shadowOffset = CGSize(width: 1.0, height: 1.0)
    }
}
