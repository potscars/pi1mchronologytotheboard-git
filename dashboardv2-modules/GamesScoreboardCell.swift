//
//  GamesScoreboardCell.swift
//  dashboardv2
//
//  Created by Hainizam on 27/07/2017.
//  Copyright © 2017 Ingeniworks Sdn Bhd. All rights reserved.
//

import Foundation
import UIKit

class GamesScoreboardCell: UITableViewCell {
    
    @IBOutlet weak var topScorerNameLabel: UILabel!
    @IBOutlet weak var topScorerScoreLabel: UILabel!
    
    func updateScoreAndRank() {
        
        
    }
    
    func updateScoreboardList(_ topScorerName: String, topScorerScore: String) {
        
        self.topScorerNameLabel.text = topScorerName
        self.topScorerScoreLabel.text = topScorerScore
    }
}




























