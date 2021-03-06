//
//  ButtonUpdateCell.swift
//  dashboardv2
//
//  Created by Hainizam on 09/01/2018.
//  Copyright © 2018 Ingeniworks Sdn Bhd. All rights reserved.
//

import UIKit

protocol ButtonUpdateDelegate {
    func didUpdateButtonTapped(_ type: String, button: UIButton)
}

class ButtonUpdateCell: UITableViewCell {
    
    @IBOutlet weak var updateButton: UIButton!
    
    var updateButtonDelegate: ButtonUpdateDelegate?
    var buttonType: String!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        updateButton.roundedCorners(5)
        
    }
    
    func updateUI(buttonName: String, buttonColor: UIColor) {
        
        buttonType = buttonName
        updateButton.setTitle(buttonName, for: .normal)
        updateButton.backgroundColor = buttonColor
    }
    
    @IBAction func updateButtonTapped (_ sender: Any) {
        updateButtonDelegate?.didUpdateButtonTapped(buttonType, button: updateButton)
    }
}




