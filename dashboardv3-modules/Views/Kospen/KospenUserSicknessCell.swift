//
//  KospenUserSicknessCell.swift
//  dashboardv2
//
//  Created by Hainizam on 28/12/2017.
//  Copyright © 2017 Ingeniworks Sdn Bhd. All rights reserved.
//

import UIKit

protocol KospenUserSicknessDelegate {
    func didTappedSicknessEditButton(_ isFamily: Bool)
}

class KospenUserSicknessCell: UITableViewCell {

    @IBOutlet weak var tagView: TagView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var iconImageView: UIImageView!
    @IBOutlet weak var editButton: UIButton!
    
    var isFamily: Bool!
    var sicknessDelegate: KospenUserSicknessDelegate?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        editButton.roundedCorners(5)
    }
    
    func updateUI(_ title: String, icon: UIImage, type: String) {
        
        titleLabel.text = title
        iconImageView.image = icon
        isFamily = type == "family" ? true : false
    }
    
    @IBAction func editTapped(_ sender: UIButton) {
        sicknessDelegate?.didTappedSicknessEditButton(isFamily)
    }
}














