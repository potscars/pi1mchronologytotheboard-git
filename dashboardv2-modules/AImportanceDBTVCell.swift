//
//  AImportanceDBTVCell.swift
//  dashboardv2
//
//  Created by Mohd Zulhilmi Mohd Zain on 13/02/2017.
//  Copyright © 2017 Ingeniworks Sdn Bhd. All rights reserved.
//

import UIKit

class AImportanceDBTVCell: UITableViewCell {
    
    @IBOutlet weak var uilAIDBTVCTitle: UILabel!
    @IBOutlet weak var uilAIDBTVCDesc: UILabel!
    
    @IBOutlet weak var uivADBTVCPosOneBg: UIView!
    @IBOutlet weak var uiivAIDBTVCPosOneIcon: UIImageView!
    @IBOutlet weak var uilADBTVCPosOneDesc: UILabel!
    
    @IBOutlet weak var uivADBTVCPosTwoBg: UIView!
    @IBOutlet weak var uiivADBTVCPosTwoIcon: UIImageView!
    @IBOutlet weak var uilADBTVCPosTwoDesc: UILabel!
    
    @IBOutlet weak var uivADBTVCPosThreeBg: UIView!
    @IBOutlet weak var uiivADBTVCPosThreeIcon: UIImageView!
    @IBOutlet weak var uilADBTVCPosThreeDesc: UILabel!

    @IBOutlet weak var uivADBTVCPosFourBg: UIView!
    @IBOutlet weak var uiivADBTVCPosFourIcon: UIImageView!
    @IBOutlet weak var uilADBTVCPosFourDesc: UILabel!
    
    @IBOutlet weak var uivADBTVCPosFiveBg: UIView!
    @IBOutlet weak var uiivADBTVCPosFiveIcon: UIImageView!
    @IBOutlet weak var uilADBTVCPosFiveDesc: UILabel!
    
    @IBOutlet weak var uivADBTVCPosSixBg: UIView!
    @IBOutlet weak var uiivADBTVCPosSixIcon: UIImageView!
    @IBOutlet weak var uilADBTVCPosSixDesc: UILabel!
    

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func updateImportanceDB(data: NSDictionary){
        
        self.backgroundColor = DBColorSet.dashboardAboutImportanceColor
        uilAIDBTVCTitle.textColor = UIColor.white
        uilAIDBTVCDesc.textColor = UIColor.white
        uivADBTVCPosOneBg.backgroundColor = UIColor.clear
        uilADBTVCPosOneDesc.textColor = UIColor.white
        uivADBTVCPosTwoBg.backgroundColor = UIColor.clear
        uilADBTVCPosTwoDesc.textColor = UIColor.white
        uivADBTVCPosThreeBg.backgroundColor = UIColor.clear
        uilADBTVCPosThreeDesc.textColor = UIColor.white
        uivADBTVCPosFourBg.backgroundColor = UIColor.clear
        uilADBTVCPosFourDesc.textColor = UIColor.white
        uivADBTVCPosFiveBg.backgroundColor = UIColor.clear
        uilADBTVCPosFiveDesc.textColor = UIColor.white
        uivADBTVCPosSixBg.backgroundColor = UIColor.clear
        uilADBTVCPosSixDesc.textColor = UIColor.white
    }

}
