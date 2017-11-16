//
//  ErrorCollectionCell.swift
//  dashboardv2
//
//  Created by Hainizam on 13/11/2017.
//  Copyright © 2017 Ingeniworks Sdn Bhd. All rights reserved.
//

import UIKit

class ErrorCollectionCell: UICollectionViewCell {

    @IBOutlet weak var errorLabel: UILabel!
    
    var message: String! {
        didSet{
            errorLabel.text = message
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

}
