//
//  ButtonUpdateCell.swift
//  dashboardv2
//
//  Created by Hainizam on 09/01/2018.
//  Copyright © 2018 Ingeniworks Sdn Bhd. All rights reserved.
//

import UIKit

protocol ButtonUpdateDelegate {
    func didUpdateButtonTapped()
}

class ButtonUpdateCell: UITableViewCell {
    
    @IBOutlet weak var updateButton: UIButton!
    
    var updateButtonDelegate: ButtonUpdateDelegate?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        updateButton.roundedCorners(5)
        updateButton.backgroundColor = DBColorSet.myHealthColor
    }
    
    @IBAction func updateButtonTapped (_ sender: Any) {
        updateButtonDelegate?.didUpdateButtonTapped()
    }
}
