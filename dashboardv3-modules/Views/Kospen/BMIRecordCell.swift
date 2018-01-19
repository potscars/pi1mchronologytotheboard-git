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
    @IBOutlet weak var dateMonthLabel: UILabel!
    @IBOutlet weak var dateDaysLabel: UILabel!
    @IBOutlet weak var bmiValueLabel: UILabel!
    
    var height: String! {
        didSet {
            heightValueLabel.text = height
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        dateImageView.roundedCorners(dateImageView.frame.height / 2)
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func updateUI(_ data: GraphData) {
        
        let roundedBMI = Double(round(100 * Double(data.bmi!))/100)
        
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd HH:mm:ss"
        let date = formatter.date(from: data.createdDate!)!
        let components = Calendar.current.dateComponents([.day], from: date)
        formatter.dateFormat = "MMM"
        let monthKeypath = formatter.string(from: date)
        
        dateMonthLabel.text = "\(monthKeypath)"
        dateDaysLabel.text = "\(components.day!)"
        bmiValueLabel.text = "\(roundedBMI)"
        weightValueLabel.text = "\(data.weight!) kg"
    }
}









