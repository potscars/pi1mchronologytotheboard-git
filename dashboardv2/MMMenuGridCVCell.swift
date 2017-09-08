//
//  MMMenuGridCVCell.swift
//  dashboardv2
//
//  Created by Mohd Zulhilmi Mohd Zain on 27/12/2016.
//  Copyright © 2016 Ingeniworks Sdn Bhd. All rights reserved.
//

import UIKit

class MMMenuGridCVCell: UICollectionViewCell {
    
    @IBOutlet weak var uiivMMMGCIcon: UIImageView!
    @IBOutlet weak var uilMMMGCLabel: UILabel!
    
    
    func updateGrid(data: NSDictionary)
    {
        uilMMMGCLabel.text = data.value(forKey: "MenuString") as? String
    }
}
