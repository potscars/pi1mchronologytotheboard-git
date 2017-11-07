//
//  ABuildInfoTVCell.swift
//  dashboardv2
//
//  CELL-ID: ABuildInfoCellID
//
//  Created by Mohd Zulhilmi Mohd Zain on 29/12/2016.
//  Copyright © 2016 Ingeniworks Sdn Bhd. All rights reserved.
//

import UIKit

class ABuildInfoTVCell: UITableViewCell {

    @IBOutlet weak var uilABITVCAppTitle: UILabel!
    @IBOutlet weak var uilABITVCCopyright: UILabel!
    @IBOutlet weak var uilABITVCBuilder: UILabel!
    @IBOutlet weak var uilABITVCVersion: UILabel!
    @IBOutlet weak var uilABITVCBuildNo: UILabel!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func updateCell(data: NSDictionary)
    {
        self.backgroundColor = DBColorSet.dashboardMainColor
        
        uilABITVCAppTitle.text = data.value(forKey: "ABOUT_APPNAME") as? String
        uilABITVCAppTitle.textColor = UIColor.white
        uilABITVCCopyright.text = data.value(forKey: "ABOUT_COPYRIGHT") as? String
        uilABITVCCopyright.textColor = UIColor.white
        uilABITVCBuilder.text = data.value(forKey: "ABOUT_BUILDER") as? String
        uilABITVCBuilder.textColor = UIColor.white
        uilABITVCVersion.text = data.value(forKey: "ABOUT_VERSION") as? String
        uilABITVCVersion.textColor = UIColor.white
        uilABITVCBuildNo.text = data.value(forKey: "ABOUT_BUILDNO") as? String
        uilABITVCBuildNo.textColor = UIColor.white
    }

}
