//
//  KospenQuestionaireCell.swift
//  dashboardv2
//
//  Created by Hainizam on 23/11/2017.
//  Copyright © 2017 Ingeniworks Sdn Bhd. All rights reserved.
//

import UIKit

class KospenQuestionaireCell: UITableViewCell {

    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var answerSwitch: UISwitch!
    @IBOutlet weak var explainationLabel: UILabel!
    @IBOutlet weak var expandedColorView: UIView!
    @IBOutlet weak var iconImageView: UIImageView!
    @IBOutlet weak var editButton: UIButton!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        expandedColorView.roundedCorners(expandedColorView.frame.height / 2)
        answerSwitch.addTarget(self, action: #selector(switchTapped(_:)), for: .valueChanged)
    }
    
    func updateUI(_ title: String, message: String, icon: UIImage) {
        
        titleLabel.text = title
        explainationLabel.text = message
        iconImageView.image = icon
    }
    
    @objc func switchTapped(_ sender: UISwitch) {
        
        if answerSwitch.isOn {
            
            UIView.animate(withDuration: 1.0, animations: {
                self.expandedColorView.backgroundColor = DBColorSet.myShopColor
                self.expandedColorView.transform = CGAffineTransform(scaleX: 20, y: 20)
                self.toggleColor()
            }, completion: { (true) in
                
            })
        } else {
            
            UIView.animate(withDuration: 1.0, animations: {
                
                self.expandedColorView.backgroundColor = .clear
                self.expandedColorView.transform = .identity
                self.toggleColor()
            })
        }
    }
    
    //toggle the view background color.
    func toggleColor() {
        
        let color: UIColor = titleLabel.textColor == .white ? .black : .white
        self.titleLabel.textColor = color
        self.explainationLabel.textColor = color
        self.iconImageView.tintColor = color
    }
    
}





