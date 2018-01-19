//
//  KospenUserCharacteristicCell.swift
//  dashboardv2
//
//  Created by Hainizam on 28/11/2017.
//  Copyright © 2017 Ingeniworks Sdn Bhd. All rights reserved.
//

import UIKit

protocol KospenUserMeasureCellDelegate {
    func didTappedMeasureEditButton(_ isHeight: Bool)
}

class KospenUserMeasureCell: UITableViewCell {

    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var valueLabel: UILabel!
    @IBOutlet weak var featuredImageView: UIImageView!
    @IBOutlet weak var editButton: UIButton!
    
    var measureDelegate: KospenUserMeasureCellDelegate?
    var isHeight: Bool!
    var unitValue: String! {
        didSet {
            valueLabel.text = unitValue
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        editButton.roundedCorners(3)
    }
    
    func updateUI(_ title: String, value: String, indicator: String, icon: UIImage) {
        
        titleLabel.text = title
        valueLabel.text = "\(value) \(indicator)"
        featuredImageView.image = icon
        isHeight = indicator == "m" ? true : false
    }
    
    @IBAction func editButtonTapped(_ sender: UIButton) {
        measureDelegate?.didTappedMeasureEditButton(isHeight)
    }
}










