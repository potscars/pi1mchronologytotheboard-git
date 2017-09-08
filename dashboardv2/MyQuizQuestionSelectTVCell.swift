//
//  MyQuizQuestionSelectTVCell.swift
//  dashboardv2
//
//  Created by Mohd Zulhilmi Mohd Zain on 18/07/2017.
//  Copyright © 2017 Ingeniworks Sdn Bhd. All rights reserved.
//

import UIKit

class MyQuizQuestionSelectTVCell: UITableViewCell {
    
    @IBOutlet weak var uilMQQSTVCTitle: UILabel!
    @IBOutlet weak var uilMQQSTVCQuestion: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func setQuestionNumber(data: String) {
     
        uilMQQSTVCQuestion.text = String(describing: "Soalan \(data)")
        
    }

}
