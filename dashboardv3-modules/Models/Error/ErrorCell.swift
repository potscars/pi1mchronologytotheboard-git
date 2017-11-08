//
//  ErrorCell.swift
//  dashboardv2
//
//  Created by Hainizam on 08/11/2017.
//  Copyright © 2017 Ingeniworks Sdn Bhd. All rights reserved.
//

import UIKit

class ErrorCell: UITableViewCell {
    
    @IBOutlet weak var errorLabel: UILabel!
    
    var errorMessage: String! {
        didSet{
            self.updateUI()
        }
    }
    
    private func updateUI() {
        
        
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
