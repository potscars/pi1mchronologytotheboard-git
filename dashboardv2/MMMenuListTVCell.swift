//
//  MMMenuListTVCell.swift
//  dashboardv2
//
//  Created by Mohd Zulhilmi Mohd Zain on 27/12/2016.
//  Copyright © 2016 Ingeniworks Sdn Bhd. All rights reserved.
//

import UIKit

class MMMenuListTVCell: UITableViewCell {

    @IBOutlet weak var uiivMMLTVCIcon: UIImageView!
    @IBOutlet weak var uilMMLTVCLabel: UILabel!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    func updateCell(data: NSDictionary)
    {
        uilMMLTVCLabel.text = data.value(forKey: "MenuString") as? String
        uilMMLTVCLabel.font = UIFont(name: "RobotoCondensed-Light", size: 22.0)
        uiivMMLTVCIcon.image = data.value(forKey: "IconString") as? UIImage
        self.backgroundColor = data.value(forKey: "ColorObject") as? UIColor
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
