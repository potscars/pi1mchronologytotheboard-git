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
    @IBOutlet weak var dateMonthLabel: UILabel!
    @IBOutlet weak var dateDaysLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        featuredImageView.roundedCorners(featuredImageView.frame.height / 2)
    }

    func updateUI(_ data: GraphData) {
        
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd HH:mm:ss"
        let date = formatter.date(from: data.createdDate!)!
        let components = Calendar.current.dateComponents([.day], from: date)
        formatter.dateFormat = "MMM"
        let monthKeypath = formatter.string(from: date)
        
        dateDaysLabel.text = "\(components.day!)"
        dateMonthLabel.text = "\(monthKeypath)"
        
        if data.glucoseLevel != nil && data.glucoseLevel != 0.0 {
            valueLabel.text = "\(data.glucoseLevel!)"
        } else {
            valueLabel.text = "\(data.sys!)/\(data.dys!)"
        }
    }
    
}
