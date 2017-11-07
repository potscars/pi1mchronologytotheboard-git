//
//  MySkoolDetailsTVCell.swift
//  dashboardv2
//
//  Created by Mohd Zulhilmi Mohd Zain on 23/01/2017.
//  Copyright © 2017 Ingeniworks Sdn Bhd. All rights reserved.
//

import UIKit

class MySkoolDetailsTVCell: UITableViewCell {
    
    @IBOutlet weak var uilMSDTVCSenderName: UILabel!
    @IBOutlet weak var uilMSDTVCArticleTitle: UILabel!
    @IBOutlet weak var uilMSDTVCArticleDate: UILabel!
    @IBOutlet weak var uilMSDTVCArticleDesc: UILabel!
    

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
        uilMSDTVCArticleTitle.text = data.value(forKey: "MESSAGE_TITLE") as? String ?? "Tiada Tajuk"
        uilMSDTVCArticleDate.text = ZDateTime.dateFormatConverter(valueInString: data.value(forKey: "MESSAGE_DATE") as? String ?? "Tiada Tarikh", dateTimeFormatFrom: nil, dateTimeFormatTo: ZDateTime.DateInLong)
    }
    
    func updateDescCell(data: NSDictionary)
    {
        uilMSDTVCArticleDesc.text = ZParsers.parseAllHTMLStrings(stringToParse: data.value(forKey: "MESSAGE_DESC") as? String) ?? "Tiada Huraian"
    }


    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
