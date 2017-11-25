//
//  CustoTextField.swift
//  Social Media
//
//  Created by Santiago on 11/22/17.
//  Copyright © 2017 Santiago. All rights reserved.
//

import UIKit

class CustoTextField: UITextField {
    override func awakeFromNib() {
        super.awakeFromNib()
        borderRect(forBounds: CGRect(x: 1, y: 1, width: 1, height: 1))
    }
    
    @IBInspectable var placeholderString: String = "" {
        didSet {
            attributedPlaceholder = NSAttributedString(string: placeholderString, attributes: [NSAttributedStringKey.foregroundColor: TEXT_COLOR])
        }
    }
    
    @IBInspectable var fontSize: CGFloat = 0 {
        didSet {
            font = UIFont(name: "Menlo", size: fontSize)
        }
    }
}

