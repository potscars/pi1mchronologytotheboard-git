//
//  MyKomunitiPostCell.swift
//  dashboardv2
//
//  Created by Hainizam on 13/07/2017.
//  Copyright © 2017 Ingeniworks Sdn Bhd. All rights reserved.
//

import UIKit

class MyKomunitiPostTitleCell: UITableViewCell {
    
    @IBOutlet weak var titleTextView: UITextView!
    
    override func awakeFromNib() {
        
        self.titleTextView.text = "What's on your mind?"
        self.titleTextView.textColor = .lightGray
        self.titleTextView.tag = 1
    }
}

class MyKomunitiPostContentCell: UITableViewCell {
    
    @IBOutlet weak var contentTextView: UITextView!
    
    override func awakeFromNib() {
        
        self.contentTextView.text = "What's about it?"
        self.contentTextView.textColor = UIColor.lightGray
        self.contentTextView.tag = 2
    }
}
