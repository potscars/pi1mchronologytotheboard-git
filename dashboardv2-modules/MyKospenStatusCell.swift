//
//  MyHealthGlucoseTVCell.swift
//  dashboardv2
//
//  Created by Mohd Zulhilmi Mohd Zain on 15/11/2017.
//  Copyright © 2017 Ingeniworks Sdn Bhd. All rights reserved.
//

import UIKit
import Charts

class MyKospenStatusCell: UITableViewCell {
    
    @IBOutlet weak var featuredImageView: UIImageView!
    @IBOutlet weak var statusLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    func updateUIWithString(_ status: String, value: String, fontSize: CGFloat = 12) {
        
        featuredImageView.roundedCorners(featuredImageView.frame.height / 2)
        ZGraphics().createImageWithWords(value, imageView: featuredImageView, fontSize: fontSize)
        statusLabel.text = status
    }
    
    func updateUIWithIntValue(_ status: String, value: Int, indicator: String, fontSize: CGFloat = 12) {
        
        featuredImageView.roundedCorners(featuredImageView.frame.height / 2)
        ZGraphics().createImageWithWords("\(value)", secondValue: indicator, imageView: featuredImageView, fontSize: fontSize)
        statusLabel.text = status
    }
    
    func updateUIWithCGFloatValue(_ status: String, value: CGFloat, indicator: String, fontSize: CGFloat = 12) {
        
        featuredImageView.roundedCorners(featuredImageView.frame.height / 2)
        ZGraphics().createImageWithWords("\(value)", secondValue: indicator, imageView: featuredImageView, fontSize: fontSize)
        statusLabel.text = status
    }
    
    func updateStatusMerokokCell(_ status: String, value: Int, fontSize: CGFloat = 12) {
        
        featuredImageView.roundedCorners(featuredImageView.frame.height / 2)
        let decision = value == 1 ? "Ya" : "Tidak"
        ZGraphics().createImageWithWords(decision, imageView: featuredImageView, fontSize: fontSize)
        statusLabel.text = status
    }
}














