//
//  MyKospenProfileCell.swift
//  dashboardv2
//
//  Created by Hainizam on 24/11/2017.
//  Copyright © 2017 Ingeniworks Sdn Bhd. All rights reserved.
//

import UIKit

class MyKospenProfileCell: UITableViewCell {

    @IBOutlet weak var imageFeatured: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var explainationLabel: UILabel!
    @IBOutlet weak var holderView: UIView!
    
    func updateUI(_ title: String, content: String) {
        
        titleLabel.text = title
        explainationLabel.text = content
    }
    
    func updateUIWithArray(_ title: String, contents: NSArray, keyPath: String) {
        
        var nameTemp = ""
        
        if contents.count > 0 {
            
            for content in contents {
                
                if let name = (content as AnyObject).object(forKey: "name") as? String {
                    nameTemp += "\(name), "
                }
            }
        } else {
            
            nameTemp = "Tiada data"
        }
        
        titleLabel.text = title
        explainationLabel.text = nameTemp
    }
}















