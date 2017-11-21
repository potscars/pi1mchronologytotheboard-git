//
//  MyHealthIntegratedTVCell.swift
//  dashboardv2
//
//  CellId-BP: MyHealthBPInfoCellID, MyHealthBPLoadingCellID, MyHealthBPLoadMoreCellID
//  CellId-BW: MyHealthBWInfoCellID, MyHealthBWLoadingCellID, MyHealthBWLoadMoreCellID
//
//  Created by Mohd Zulhilmi Mohd Zain on 24/01/2017.
//  Copyright © 2017 Ingeniworks Sdn Bhd. All rights reserved.
//

import UIKit

class MyHealthIntegratedTVCell: UITableViewCell {
    
    //MyHealthBPInfoCellID
    @IBOutlet weak var uilMHITVCBPPressure: UILabel!
    @IBOutlet weak var uilMHITVCBPHBeat: UILabel!
    @IBOutlet weak var uilMHITVCBPStatus: UILabel!
    @IBOutlet weak var uivMHITVCBPRedIndicator: UIView!
    @IBOutlet weak var uivMHITVCBPOrangeIndicator: UIView!
    @IBOutlet weak var uivMHITVCBPYellowIndicator: UIView!
    @IBOutlet weak var uivMHITVCBPClearGreenIndicator: UIView!
    @IBOutlet weak var uivMHITVCBPGreenIndicator: UIView!
    
    //MyHealthBPLoadingCellID
    @IBOutlet weak var uiaivMHITVCBPLoadIndicator: UIActivityIndicatorView!
    @IBOutlet weak var uilMHTVCBPLoadStatus: UILabel!

    //MyHealthBPLoadMoreCellID
    @IBOutlet weak var uilMHITVCLoadMore: UILabel!
    
    //MyHealthBWInfoCellID
    @IBOutlet weak var uilMHITVCBWWeight: UILabel!
    @IBOutlet weak var uilMHITVCBWBMI: UILabel!
    @IBOutlet weak var uilMHITVCBWStatus: UILabel!
    @IBOutlet weak var uivMHITVCBWVeryRedIndicator: UIView!
    @IBOutlet weak var uivMHITVCBWRedIndicator: UIView!
    @IBOutlet weak var uivMHITVCBWOrangeIndicator: UIView!
    @IBOutlet weak var uivMHITVCBWYellowIndicator: UIView!
    @IBOutlet weak var uivMHITVCBWClearGreenIndicator: UIView!
    @IBOutlet weak var uivMHITVCBWGreenIndicator: UIView!
    
    
    //MyHealthBWLoadingCellID
    @IBOutlet weak var uiaivMHITVCBWLoadIndicator: UIActivityIndicatorView!
    @IBOutlet weak var uilMHITVCBWLoadStatus: UILabel!
    
    //MyHealthBWLoadMoreCellID
    @IBOutlet weak var uilMHITVCBWLoadMore: UILabel!
    
    //MyHealthBPErrorCellID
    @IBOutlet weak var uilMHITVCBWErrorNotice: UILabel!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    ////////////========== BLOOD PRESSURE ==========////////////
    
    func setBPLevelIndicator(level: Int) {
        
        if(level == 1) {
            
            uivMHITVCBPRedIndicator.backgroundColor = UIColor.lightGray
            uivMHITVCBPOrangeIndicator.backgroundColor = UIColor.lightGray
            uivMHITVCBPYellowIndicator.backgroundColor = UIColor.lightGray
            uivMHITVCBPClearGreenIndicator.backgroundColor = UIColor.lightGray
            uivMHITVCBPGreenIndicator.backgroundColor = DBColorSet.myHealthConditionOptimalColor
            
        }
        else if(level == 2) {
            
            uivMHITVCBPRedIndicator.backgroundColor = UIColor.lightGray
            uivMHITVCBPOrangeIndicator.backgroundColor = UIColor.lightGray
            uivMHITVCBPYellowIndicator.backgroundColor = UIColor.lightGray
            uivMHITVCBPClearGreenIndicator.backgroundColor = DBColorSet.myHealthConditionNormalColor
            uivMHITVCBPGreenIndicator.backgroundColor = DBColorSet.myHealthConditionOptimalColor
            
        }
        else if(level == 3) {
            
            uivMHITVCBPRedIndicator.backgroundColor = UIColor.lightGray
            uivMHITVCBPOrangeIndicator.backgroundColor = UIColor.lightGray
            uivMHITVCBPYellowIndicator.backgroundColor = DBColorSet.myHealthConditionCautiousColor
            uivMHITVCBPClearGreenIndicator.backgroundColor = DBColorSet.myHealthConditionNormalColor
            uivMHITVCBPGreenIndicator.backgroundColor = DBColorSet.myHealthConditionOptimalColor
            
        }
        else if(level == 4) {
            
            uivMHITVCBPRedIndicator.backgroundColor = UIColor.lightGray
            uivMHITVCBPOrangeIndicator.backgroundColor = DBColorSet.myHealthConditionRiskColor
            uivMHITVCBPYellowIndicator.backgroundColor = DBColorSet.myHealthConditionCautiousColor
            uivMHITVCBPClearGreenIndicator.backgroundColor = DBColorSet.myHealthConditionNormalColor
            uivMHITVCBPGreenIndicator.backgroundColor = DBColorSet.myHealthConditionOptimalColor
            
        }
        else if(level == 5) {
            
            uivMHITVCBPRedIndicator.backgroundColor = DBColorSet.myHealthConditionSevereColor
            uivMHITVCBPOrangeIndicator.backgroundColor = DBColorSet.myHealthConditionRiskColor
            uivMHITVCBPYellowIndicator.backgroundColor = DBColorSet.myHealthConditionCautiousColor
            uivMHITVCBPClearGreenIndicator.backgroundColor = DBColorSet.myHealthConditionNormalColor
            uivMHITVCBPGreenIndicator.backgroundColor = DBColorSet.myHealthConditionOptimalColor
            
        }
        
    }
    
    func updateReloadCell(isLoading: Bool, forCellID: String) {
        
        if(forCellID == "MyHealthBPLoadMoreCellID" && isLoading == true) {
            
            uilMHITVCLoadMore.text = "Sila Tunggu..."
            
        }
        else if(forCellID == "MyHealthBPLoadMoreCellID" && isLoading == false) {
            
            uilMHITVCLoadMore.text = "Tekan untuk muatkan lagi."
            
        }
        else if(forCellID == "MyHealthBWLoadMoreCellID" && isLoading == true) {
            
            uilMHITVCBWLoadMore.text = "Sila Tunggu..."
            
        }
        else if(forCellID == "MyHealthBWLoadMoreCellID" && isLoading == false) {
            
            uilMHITVCBWLoadMore.text = "Tekan untuk muatkan lagi."
            
        }
        
    }
    
    func updateBloodPressureInfo(data:NSDictionary) {
        
        let bpColorandClassification: NSArray = DBColorSet.setMyHealthBPIndicatorColor(hexColor: data.value(forKey: "MYHEALTH_COLOR_INDICATOR") as! String)
        
        if data.value(forKey: "MYHEALTH_BLOOD_PRESSURE") != nil {
            uilMHITVCBPPressure.text = (data.value(forKey: "MYHEALTH_BLOOD_PRESSURE") as! String)
        }
        else {
            uilMHITVCBPPressure.text = "Tiada Maklumat"
        }
        
        if data.value(forKey: "MYHEALTH_HEART_RATE") != nil {
            uilMHITVCBPHBeat.text = (data.value(forKey: "MYHEALTH_HEART_RATE") as! String)
        }
        else {
            uilMHITVCBPHBeat.text = "Tiada Maklumat"
        }
       
        uilMHITVCBPStatus.text = bpColorandClassification.object(at: 2) as? String ?? "Tidak Diketahui"
        uilMHITVCBPStatus.textColor = bpColorandClassification.object(at: 0) as? UIColor ?? UIColor.init(red: 0.0/255.0, green: 0.0/255.0, blue: 0.0/255.0, alpha: 1.0)
        self.setBPLevelIndicator(level: bpColorandClassification.object(at: 3) as! Int)
        
    }
    
    
    ////////////========== BODY WEIGHT ==========////////////
    
    func setBWLevelIndicator(level: Int) {
        
        if(level == 1) {
            
            uivMHITVCBWVeryRedIndicator.backgroundColor = UIColor.lightGray
            uivMHITVCBWRedIndicator.backgroundColor = UIColor.lightGray
            uivMHITVCBWOrangeIndicator.backgroundColor = UIColor.lightGray
            uivMHITVCBWYellowIndicator.backgroundColor = UIColor.lightGray
            uivMHITVCBWClearGreenIndicator.backgroundColor = UIColor.lightGray
            uivMHITVCBWGreenIndicator.backgroundColor = DBColorSet.myHealthConditionOptimalColor
            
        }
        else if(level == 2) {
            
            uivMHITVCBWVeryRedIndicator.backgroundColor = UIColor.lightGray
            uivMHITVCBWRedIndicator.backgroundColor = UIColor.lightGray
            uivMHITVCBWOrangeIndicator.backgroundColor = UIColor.lightGray
            uivMHITVCBWYellowIndicator.backgroundColor = UIColor.lightGray
            uivMHITVCBWClearGreenIndicator.backgroundColor = DBColorSet.myHealthConditionNormalColor
            uivMHITVCBWGreenIndicator.backgroundColor = DBColorSet.myHealthConditionOptimalColor
            
        }
        else if(level == 3) {
            
            uivMHITVCBWVeryRedIndicator.backgroundColor = UIColor.lightGray
            uivMHITVCBWRedIndicator.backgroundColor = UIColor.lightGray
            uivMHITVCBWOrangeIndicator.backgroundColor = UIColor.lightGray
            uivMHITVCBWYellowIndicator.backgroundColor = DBColorSet.myHealthConditionCautiousColor
            uivMHITVCBWClearGreenIndicator.backgroundColor = DBColorSet.myHealthConditionNormalColor
            uivMHITVCBWGreenIndicator.backgroundColor = DBColorSet.myHealthConditionOptimalColor
            
        }
        else if(level == 4) {
            
            uivMHITVCBWVeryRedIndicator.backgroundColor = UIColor.lightGray
            uivMHITVCBWRedIndicator.backgroundColor = UIColor.lightGray
            uivMHITVCBWOrangeIndicator.backgroundColor = DBColorSet.myHealthConditionRiskColor
            uivMHITVCBWYellowIndicator.backgroundColor = DBColorSet.myHealthConditionCautiousColor
            uivMHITVCBWClearGreenIndicator.backgroundColor = DBColorSet.myHealthConditionNormalColor
            uivMHITVCBWGreenIndicator.backgroundColor = DBColorSet.myHealthConditionOptimalColor
            
        }
        else if(level == 5) {
            
            uivMHITVCBWVeryRedIndicator.backgroundColor = UIColor.lightGray
            uivMHITVCBWRedIndicator.backgroundColor = DBColorSet.myHealthConditionSevereColor
            uivMHITVCBWOrangeIndicator.backgroundColor = DBColorSet.myHealthConditionRiskColor
            uivMHITVCBWYellowIndicator.backgroundColor = DBColorSet.myHealthConditionCautiousColor
            uivMHITVCBWClearGreenIndicator.backgroundColor = DBColorSet.myHealthConditionNormalColor
            uivMHITVCBWGreenIndicator.backgroundColor = DBColorSet.myHealthConditionOptimalColor
            
        }
        else if(level == 6) {
            
            uivMHITVCBWVeryRedIndicator.backgroundColor = DBColorSet.myHealthConditionDeadlyColor
            uivMHITVCBWRedIndicator.backgroundColor = DBColorSet.myHealthConditionSevereColor
            uivMHITVCBWOrangeIndicator.backgroundColor = DBColorSet.myHealthConditionRiskColor
            uivMHITVCBWYellowIndicator.backgroundColor = DBColorSet.myHealthConditionCautiousColor
            uivMHITVCBWClearGreenIndicator.backgroundColor = DBColorSet.myHealthConditionNormalColor
            uivMHITVCBWGreenIndicator.backgroundColor = DBColorSet.myHealthConditionOptimalColor
            
        }
        else {
            
            uivMHITVCBWVeryRedIndicator.backgroundColor = UIColor.lightGray
            uivMHITVCBWRedIndicator.backgroundColor = UIColor.lightGray
            uivMHITVCBWOrangeIndicator.backgroundColor = UIColor.lightGray
            uivMHITVCBWYellowIndicator.backgroundColor = UIColor.lightGray
            uivMHITVCBWClearGreenIndicator.backgroundColor = UIColor.lightGray
            uivMHITVCBWGreenIndicator.backgroundColor = UIColor.lightGray
            
        }
        
    }
    
    func updateBodyWeightInfo(data:NSDictionary) {
        
        //let bmiInDouble: Double = Double(data.value(forKey: "MYHEALTH_BW_BMI_RAW") as! String)!
        let bmiInDouble: Double = NumberFormatter().number(from: String.init(format: "%@", data.value(forKey: "MYHEALTH_BW_BMI_RAW") as! String))!.doubleValue
        print("bmiDouble: \(bmiInDouble)")
        let bmiStatus: NSArray = ZHealth.simpleBodyMassIndexForAsian(point: bmiInDouble)
        let bwColorandClassification: NSArray = DBColorSet.setMyHealthBWIndicatorColor(bmiPoints: bmiStatus.object(at: 1) as! Int)
        
        uilMHITVCBWWeight.text = data.value(forKey: "MYHEALTH_BW_WEIGHT") as? String ?? "Tiada Maklumat"
        uilMHITVCBWBMI.text = data.value(forKey: "MYHEALTH_BW_BMI") as? String ?? "Tiada Maklumat"
        uilMHITVCBWStatus.text = bwColorandClassification.object(at: 2) as? String ?? "Tidak Diketahui"
        uilMHITVCBWStatus.textColor = bwColorandClassification.object(at: 0) as? UIColor ?? UIColor.init(red: 0.0/255.0, green: 0.0/255.0, blue: 0.0/255.0, alpha: 1.0)
        self.setBWLevelIndicator(level: bmiStatus.object(at: 1) as! Int)
        
    }
    
    func updateErrorNotice() {
        
        uilMHITVCBWErrorNotice.text = "Tiada data"
        
    }


    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
