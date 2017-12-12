//
//  BMIRecordCell.swift
//  dashboardv2
//
//  Created by Hainizam on 23/11/2017.
//  Copyright © 2017 Ingeniworks Sdn Bhd. All rights reserved.
//

import UIKit

class BMIRecordCell: UITableViewCell {

    @IBOutlet weak var weightValueLabel: UILabel!
    @IBOutlet weak var heightValueLabel: UILabel!
    @IBOutlet weak var remarkValueLabel: UILabel!
    @IBOutlet weak var dateImageView: UIImageView!
    @IBOutlet weak var dateValueLabel: UILabel!
    @IBOutlet weak var bmiValueLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        dateImageView.roundedCorners(dateImageView.frame.height / 2)
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
}
