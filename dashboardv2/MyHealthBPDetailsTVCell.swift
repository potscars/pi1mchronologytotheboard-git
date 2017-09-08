//
//  MyHealthBPDetailsTVCell.swift
//  dashboardv2
//
//  Cell-id: MHBPDTVCDetailsTitleCellID, MHBPDTVCDetailsBPReadCellID,
//  MHBPDTVCDetailsHRReadCellID, MHBPDTVCDetailsBPLevelCellID,
//  MHBPDTVCDetailsBPDescCellID
//
//  Created by Mohd Zulhilmi Mohd Zain on 25/01/2017.
//  Copyright © 2017 Ingeniworks Sdn Bhd. All rights reserved.
//

import UIKit

class MyHealthBPDetailsTVCell: UITableViewCell {
    
    @IBOutlet weak var uilMHBPDTVCInfoTitle: UILabel!
    @IBOutlet weak var uilMHBPDTVCInfoDate: UILabel!
    @IBOutlet weak var uiivMHBPDTVCInfoIcon: UIImageView!
    
    @IBOutlet weak var uilMHBPDTVCBPTitle: UILabel!
    @IBOutlet weak var uilMHBPDTVCBPData: UILabel!
    
    @IBOutlet weak var uilMHBPDTVCHRTitle: UILabel!
    @IBOutlet weak var uilMHBPDTVCHRData: UILabel!
    
    @IBOutlet weak var uilMHBPDTVCBPStatusTitle: UILabel!
    @IBOutlet weak var uilMHBPDTVCBPStatusData: UILabel!
    
    @IBOutlet weak var uilMHBPDTVCBPDescTitle: UILabel!
    @IBOutlet weak var uilMHBPDTVCBPDescData: UILabel!
    

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    func setBPTitle(data: NSDictionary)
    {
        uilMHBPDTVCInfoDate.text = ZDateTime.dateFormatConverter(valueInString: data.value(forKey: "MYHEALTH_CHECKED_DATE") as? String ?? "Tidak Diketahui", dateTimeFormatFrom: nil, dateTimeFormatTo: ZDateTime.DateInLong)
    }
    
    func setBPDesc(statusInMS: String) -> String
    {
        if(statusInMS == DBStrings.DB_MODULE_MYHEALTH_BP_CONDITION_OPTIMAL_MS) {
            return DBStrings.DB_MODULE_MYHEALTH_BP_ADVICE_OPTIMAL_MS
        }
        else if(statusInMS == DBStrings.DB_MODULE_MYHEALTH_BP_CONDITION_NORMAL_MS) {
            return DBStrings.DB_MODULE_MYHEALTH_BP_ADVICE_NORMAL_MS
        }
        else if(statusInMS == DBStrings.DB_MODULE_MYHEALTH_BP_CONDITION_HINORMAL_MS) {
            return DBStrings.DB_MODULE_MYHEALTH_BP_ADVICE_HINORMAL_MS
        }
        else if(statusInMS == DBStrings.DB_MODULE_MYHEALTH_BP_CONDITION_HYPER_G1_MS) {
            return DBStrings.DB_MODULE_MYHEALTH_BP_ADVICE_HYPER_G1_MS
        }
        else if(statusInMS == DBStrings.DB_MODULE_MYHEALTH_BP_CONDITION_HYPER_G2_MS) {
            return DBStrings.DB_MODULE_MYHEALTH_BP_ADVICE_HYPER_G2_MS
        }
        else {
            return DBStrings.DB_MODULE_MYHEALTH_BP_ADVICE_UNKNOWN_MS
        }
    }
    
    func setBPData(data:NSDictionary)
    {
        uilMHBPDTVCBPData.text = data.value(forKey: "MYHEALTH_BLOOD_PRESSURE") as? String ?? "Tidak Diketahui"
    }
    
    func setHRData(data:NSDictionary)
    {
        uilMHBPDTVCHRData.text = data.value(forKey: "MYHEALTH_HEART_RATE") as? String ?? "Tidak Diketahui"
    }
    
    func setBPStatusData(data:NSDictionary)
    {
        let bpColorandClassification: NSArray = DBColorSet.setMyHealthBPIndicatorColor(hexColor: data.value(forKey: "MYHEALTH_COLOR_INDICATOR") as! String)
        
        uilMHBPDTVCBPStatusData.text = bpColorandClassification.object(at: 2) as? String ?? "Tidak Diketahui"
        uilMHBPDTVCBPStatusData.textColor = bpColorandClassification.object(at: 0) as? UIColor ?? UIColor.init(red: 0.0/255.0, green: 0.0/255.0, blue: 0.0/255.0, alpha: 1.0)
    }
    
    func setBPDescData(data:NSDictionary)
    {
         let bpColorandClassification: NSArray = DBColorSet.setMyHealthBPIndicatorColor(hexColor: data.value(forKey: "MYHEALTH_COLOR_INDICATOR") as! String)
        
        uilMHBPDTVCBPDescData.text = setBPDesc(statusInMS: bpColorandClassification.object(at: 2) as! String)
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
