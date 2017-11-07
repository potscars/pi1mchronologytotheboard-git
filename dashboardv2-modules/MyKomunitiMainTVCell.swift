//
//  MyKomunitiMainTVCell.swift
//  dashboardv2
//
//  Cell-id : MyKomunitiMainCellID
//
//  Created by Mohd Zulhilmi Mohd Zain on 04/01/2017.
//  Copyright © 2017 Ingeniworks Sdn Bhd. All rights reserved.
//

import UIKit

class MyKomunitiMainTVCell: UITableViewCell {

    @IBOutlet weak var uivMKMTVCIndicator: UIView!
    @IBOutlet weak var uilMKMTVCSender: UILabel!
    @IBOutlet weak var uilMKMTVCDate: UILabel!
    @IBOutlet weak var uilMKMTVCMsgTitle: UILabel!
    @IBOutlet weak var uilMKMTVCMsgSum: UILabel!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    func updateCell(data: NSDictionary)
    {
        let indicator: String = data.value(forKey: "MESSAGE_LEVEL") as! String
        
        if(indicator == "PENTADBIR") {
            uivMKMTVCIndicator.backgroundColor = DBColorSet.myKomunitiAdminIndicator
        }
        else if(indicator == "AWAM") {
            uivMKMTVCIndicator.backgroundColor = DBColorSet.myKomunitiPublicIndicator
        }
        
        uilMKMTVCSender.text = data.value(forKey: "MESSAGE_SENDER") as? String ?? ""
        uilMKMTVCMsgTitle.text = data.value(forKey: "MESSAGE_TITLE") as? String ?? ""
        uilMKMTVCMsgSum.text = ZParsers.parseAllHTMLStrings(stringToParse: data.value(forKey: "MESSAGE_SUMMARY") as? String) ?? "Tiada Huraian"
        uilMKMTVCDate.text = ZDateTime.dateFormatConverter(valueInString: data.value(forKey: "MESSAGE_DATE") as! String, dateTimeFormatFrom: nil, dateTimeFormatTo: ZDateTime.DateInShort)
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
