//
//  AWhatDBTVC.swift
//  dashboardv2
//
//  CELL-ID: AWhatDBCellID
//
//  Created by Mohd Zulhilmi Mohd Zain on 30/12/2016.
//  Copyright © 2016 Ingeniworks Sdn Bhd. All rights reserved.
//

import UIKit

class AWhatDBTVCell: UITableViewCell {

    @IBOutlet weak var uilAWDBTVCTitle: UILabel!
    @IBOutlet weak var uilAWDBTVCDesc: UILabel!
    
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
        self.backgroundColor = DBColorSet.aboutWhatDBBGColor
        uilAWDBTVCTitle.text = data.value(forKey: "ABOUT_INFO_TITLE") as? String
        uilAWDBTVCTitle.textColor = UIColor.white
        uilAWDBTVCDesc.text = data.value(forKey: "ABOUT_INFO_DESC") as? String
        uilAWDBTVCDesc.textColor = UIColor.white
    }

}
