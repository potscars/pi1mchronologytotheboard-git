//
//  RecordCell.swift
//  dashboardv2
//
//  Created by Hainizam on 22/11/2017.
//  Copyright © 2017 Ingeniworks Sdn Bhd. All rights reserved.
//

import UIKit

class RecordCell: UITableViewCell {

    @IBOutlet weak var featuredImageView: UIImageView!
    @IBOutlet weak var remarkDetailsLabel: UILabel!
    @IBOutlet weak var valueLabel: UILabel!
    @IBOutlet weak var dateLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        featuredImageView.roundedCorners(featuredImageView.frame.height / 2)
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
