//
//  KospenQuestionaireCell.swift
//  dashboardv2
//
//  Created by Hainizam on 23/11/2017.
//  Copyright © 2017 Ingeniworks Sdn Bhd. All rights reserved.
//

import UIKit

protocol KospenQuestionaireDelegate {
    func didTappedOnTheSwitch(_ value: Int, type: KospenEtc.Question)
}

class KospenQuestionaireCell: UITableViewCell {

    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var answerSwitch: UISwitch!
    @IBOutlet weak var explainationLabel: UILabel!
    @IBOutlet weak var expandedColorView: UIView!
    @IBOutlet weak var iconImageView: UIImageView!
    @IBOutlet weak var editButton: UIButton!
    
    var type: KospenEtc.Question!
    var questionDelegate: KospenQuestionaireDelegate?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        expandedColorView.roundedCorners(expandedColorView.frame.height / 2)
        answerSwitch.addTarget(self, action: #selector(switchTapped(_:)), for: .valueChanged)
    }
    
    func updateUI(_ title: String, message: String, icon: UIImage, agreement: Int, type: KospenEtc.Question) {
        
        self.type = type
        titleLabel.text = title
        explainationLabel.text = message
        iconImageView.image = icon
        answerSwitch.isOn = agreement == 1 ? true : false
    }
    /*
     
     1 mean agree or yes
     2 mean disagree or not
 
     */
    @objc func switchTapped(_ sender: UISwitch) {
        
        let decidedSwitchValue = answerSwitch.isOn ? 1 : 2
        questionDelegate?.didTappedOnTheSwitch(decidedSwitchValue, type: self.type)
    }
}










