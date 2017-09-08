//
//  MyHealthBWDetailsTVCell.swift
//  dashboardv2
//
//  Cell-id: MHBWDTVCDetailsTitleCellID, MHBWDTVCDetailsBWWeightCellID, 
//  MHBWDTVCDetailsBWBMICellID, MHBWDTVCDetailsBWFatCellID, 
//  MHBWDTVCDetailsBWBoneCellID, MHBWDTVCDetailsBWNettWeightCellID, 
//  MHBWDTVCDetailsBWMuscleCellID, MHBWDTVCDetailsBWStatusCellID, 
//  MHBWDTVCDetailsBWDescCellID
//
//  Created by Mohd Zulhilmi Mohd Zain on 27/01/2017.
//  Copyright © 2017 Ingeniworks Sdn Bhd. All rights reserved.
//

import UIKit

class MyHealthBWDetailsTVCell: UITableViewCell {

    @IBOutlet weak var uilMHBWDTVCBWTitle: UILabel!
    @IBOutlet weak var uilMHBWDTVCBWCheckDate: UILabel!
    
    @IBOutlet weak var uilMHBWDTVCBWWeightTitle: UILabel!
    @IBOutlet weak var uilMHBWDTVCBWWeightTotal: UILabel!
    
    @IBOutlet weak var uilMHBWDTVCBWBMITitle: UILabel!
    @IBOutlet weak var uilMHBWDTVCBWBMITotal: UILabel!
    
    @IBOutlet weak var uilMHBWDTVCBWFatTitle: UILabel!
    @IBOutlet weak var uilMHBWDTVCBWFatTotal: UILabel!
    
    @IBOutlet weak var uilMHBWDTVCBWBoneTitle: UILabel!
    @IBOutlet weak var uilMHBWDTVCBWBoneTotal: UILabel!
    
    @IBOutlet weak var uilMHBWDTVCBWMuscleTitle: UILabel!
    @IBOutlet weak var uilMHBWDTVCBWMuscleTotal: UILabel!
    
    @IBOutlet weak var uilMHBWDTVCBWWeightNettTitle: UILabel!
    @IBOutlet weak var uilMHBWDTVCBWWeightNettTotal: UILabel!
    
    @IBOutlet weak var uilMHBWDTVCBWStatusTitle: UILabel!
    @IBOutlet weak var uilMHBWDTVCBWStatusResult: UILabel!
    
    @IBOutlet weak var uilMHBWDTVCBWDescTitle: UILabel!
    @IBOutlet weak var uilMHBWDTVCBWDescDetails: UILabel!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func setBWTitle(data: NSDictionary)
    {
        uilMHBWDTVCBWCheckDate.text = ZDateTime.dateFormatConverter(valueInString: data.value(forKey: "MYHEALTH_BW_CHECKEDDATE") as? String ?? "Tidak Diketahui", dateTimeFormatFrom: nil, dateTimeFormatTo: ZDateTime.DateInLong)
    }
    
    func setBWDesc(statusInMS: String) -> String
    {
        if(statusInMS == DBStrings.DB_MODULE_MYHEALTH_BW_CONDITION_UNDERWEIGHT_MS) {
            return DBStrings.DB_MODULE_MYHEALTH_BW_ADVICE_UNDERWEIGHT_MS
        }
        else if(statusInMS == DBStrings.DB_MODULE_MYHEALTH_BW_CONDITION_HEALTHYWEIGHT_MS) {
            return DBStrings.DB_MODULE_MYHEALTH_BW_ADVICE_HEALTHYWEIGHT_MS
        }
        else if(statusInMS == DBStrings.DB_MODULE_MYHEALTH_BW_CONDITION_OVERWEIGHT_MS) {
            return DBStrings.DB_MODULE_MYHEALTH_BW_ADVICE_OVERWEIGHT_MS
        }
        else if(statusInMS == DBStrings.DB_MODULE_MYHEALTH_BW_CONDITION_OBESE_MS) {
            return DBStrings.DB_MODULE_MYHEALTH_BW_ADVICE_OBESE_MS
        }
        else if(statusInMS == DBStrings.DB_MODULE_MYHEALTH_BW_CONDITION_SEVEREOBESE_MS) {
            return DBStrings.DB_MODULE_MYHEALTH_BW_ADVICE_SEVEREOBESE_MS
        }
        else if(statusInMS == DBStrings.DB_MODULE_MYHEALTH_BW_CONDITION_MORBIDLYOBESE_MS) {
            return DBStrings.DB_MODULE_MYHEALTH_BW_ADVICE_MORBIDLYOBESE_MS
        }
        else {
            return DBStrings.DB_MODULE_MYHEALTH_BW_ADVICE_UNKNOWN_MS
        }
    }
    
    func setBWData(data:NSDictionary)
    {
        let weightInString = "\(data.value(forKey: "MYHEALTH_BW_WEIGHT_RAW") as? String ?? "Tidak Diketahui") \(DBStrings.DB_MODULE_MYHEALTH_BW_WEIGHT_UNIT_MS)"
        
        uilMHBWDTVCBWWeightTotal.text = weightInString
    }
    
    func setBMIData(data:NSDictionary)
    {
        let bmiInString = "\(data.value(forKey: "MYHEALTH_BW_BMI_RAW") as? String ?? "Tidak Diketahui") \(DBStrings.DB_MODULE_MYHEALTH_BW_BMI_POINT_MS)"
        
        uilMHBWDTVCBWBMITotal.text = bmiInString
    }
    
    func setFatData(data:NSDictionary)
    {
        uilMHBWDTVCBWFatTotal.text = "\(data.value(forKey: "MYHEALTH_BW_FATWEIGHT") as? String ?? "Tidak Diketahui") %"
    }
    
    func setBoneData(data:NSDictionary)
    {
        uilMHBWDTVCBWBoneTotal.text = data.value(forKey: "MYHEALTH_BW_BONEMASS") as? String ?? "Tidak Diketahui"
    }
    
    func setLeanWeightData(data:NSDictionary)
    {
        uilMHBWDTVCBWWeightNettTotal.text = data.value(forKey: "MYHEALTH_BW_LEANWEIGHT") as? String ?? "Tidak Diketahui"
    }
    
    func setMuscleData(data:NSDictionary)
    {
        uilMHBWDTVCBWMuscleTotal.text = data.value(forKey: "MYHEALTH_BW_MUSCLEMASS") as? String ?? "Tidak Diketahui"
    }
    
    func setBWStatusData(data:NSDictionary)
    {
        print("Converting \(data.value(forKey: "MYHEALTH_BW_BMI_RAW") as! String)")
        
        let bmiInDouble: Double = Double(data.value(forKey: "MYHEALTH_BW_BMI_RAW") as! String)!
        let bmiStatus: NSArray = ZHealth.simpleBodyMassIndexForAsian(point: bmiInDouble)
        let bwColorandClassification: NSArray = DBColorSet.setMyHealthBWIndicatorColor(bmiPoints: bmiStatus.object(at: 1) as! Int)
        
        uilMHBWDTVCBWStatusResult.text = bwColorandClassification.object(at: 2) as? String ?? "Tidak Diketahui"
        uilMHBWDTVCBWStatusResult.textColor = bwColorandClassification.object(at: 0) as? UIColor ?? UIColor.init(red: 0.0/255.0, green: 0.0/255.0, blue: 0.0/255.0, alpha: 1.0)
    }
    
    func setBWDescData(data:NSDictionary)
    {
        print("Converting \(data.value(forKey: "MYHEALTH_BW_BMI_RAW") as! String)")
        
        let bmiInDouble: Double = Double(data.value(forKey: "MYHEALTH_BW_BMI_RAW") as! String)!
        let bmiStatus: NSArray = ZHealth.simpleBodyMassIndexForAsian(point: bmiInDouble)
        let bwColorandClassification: NSArray = DBColorSet.setMyHealthBWIndicatorColor(bmiPoints: bmiStatus.object(at: 1) as! Int)
        
        uilMHBWDTVCBWDescDetails.text = setBWDesc(statusInMS: bwColorandClassification.object(at: 2) as! String)
    }

}
