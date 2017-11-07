//
//  MySoalDetailsTVCell.swift
//  dashboardv2
//
//  Cell-id: MySoalDetailsSenderCellID, MySoalDetailsTitleCellID, MySoalDetailsDescCellID
//
//  Created by Mohd Zulhilmi Mohd Zain on 23/01/2017.
//  Copyright © 2017 Ingeniworks Sdn Bhd. All rights reserved.
//

import UIKit

class MySoalDetailsTVCell: UITableViewCell {
    
    @IBOutlet weak var uilMSDTVCSenderName: UILabel!
    @IBOutlet weak var uilMSDTVCTitleArticle: UILabel!
    @IBOutlet weak var uilMSDTVCDateArticle: UILabel!
    @IBOutlet weak var uilMSDTVCDescArticle: UILabel!

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    func updateSenderCell(data: NSDictionary)
    {
        uilMSDTVCSenderName.text = data.value(forKey: "MESSAGE_SENDER") as? String ?? "Tiada Nama Penghantar"
    }
    
    func updateTitleCell(data: NSDictionary)
    {
        uilMSDTVCTitleArticle.text = data.value(forKey: "MESSAGE_TITLE") as? String ?? "Tiada Tajuk"
        uilMSDTVCDateArticle.text = data.object(forKey: "MESSAGE_DATE_LONG") as? String
    }
    
    func updateDescCell(data: NSDictionary)
    {
        uilMSDTVCDescArticle.text = ZParsers.parseAllHTMLStrings(stringToParse: data.value(forKey: "MESSAGE_DESC") as? String) ?? "Tiada Huraian"
    }


    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
