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
    var diseasesArrayTemp: [String]! {
        didSet {
            tagView.titles = diseasesArrayTemp
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        editButton.roundedCorners(5)
    }
    
    func updateUI(_ title: String, icon: UIImage, type: String, diseases: NSArray) {
        
        var diseasesAffected = [String]()
        
        for disease in diseases {
            if let newDisease = (disease as AnyObject).object(forKey: "name") as? String {
                diseasesAffected.append(newDisease)
            }
        }
        
        titleLabel.text = title
        iconImageView.image = icon
        tagView.titles = diseasesAffected
        isFamily = type == "family" ? true : false
    }
    
    @IBAction func editTapped(_ sender: UIButton) {
        sicknessDelegate?.didTappedSicknessEditButton(isFamily)
    }
}














