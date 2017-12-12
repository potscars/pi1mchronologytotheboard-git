//
//  MyHealthGlucoseTVCell.swift
//  dashboardv2
//
//  Created by Mohd Zulhilmi Mohd Zain on 15/11/2017.
//  Copyright © 2017 Ingeniworks Sdn Bhd. All rights reserved.
//

import UIKit
import Charts

class MyKospenSummaryReviewCell: UITableViewCell {
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
}

class MyKospenStatusCell: UITableViewCell {
    
    @IBOutlet weak var featuredImageView: UIImageView!
    @IBOutlet weak var statusLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    func updateUI(_ status: String) {
        
        featuredImageView.roundedCorners(featuredImageView.frame.height / 2)
        ZGraphics().createImageWithWords("70", secondValue: "kg", imageView: featuredImageView, fontSize: 12)
        statusLabel.text = status
    }
}














