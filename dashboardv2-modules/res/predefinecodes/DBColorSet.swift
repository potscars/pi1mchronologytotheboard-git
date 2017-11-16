//
//  DBColorSet.swift
//  dashboardv2
//
//  NOTE: Please use sRGB IEC61966-2.1 color profile to get accurate color results.
//
//  Created by Mohd Zulhilmi Mohd Zain on 06/12/2016.
//  Copyright © 2016 Ingeniworks Sdn Bhd. All rights reserved.
//

import UIKit

class DBColorSet: NSObject {
    
    /******** DASHBOARD V3 **********/
    
    static let dashboardV3_MainColor: UIColor = UIColor.init(red: 0.246, green: 0.334, blue: 0.686, alpha: 1.0)
    static let dashboardV3_MinorColor: UIColor = UIColor.init(red: 0.319, green: 0.442, blue: 0.931, alpha: 1.0)
    
    /******** DASHBOARD V2 **********/
    
    // Color reference from Sip (macOS App). Color name is Bay of Many
    static let dashboardMainColor: UIColor = UIColor.init(red: 0.18, green: 0.21, blue: 0.55, alpha: 1.0)
    static let dashboardMinorColor: UIColor = UIColor.init(red: 0.089, green: 0.124, blue: 0.262, alpha: 1.0)
    
    // Color reference from Sip (macOS App). Color name is Radical Red
    static let dashboardAboutImportanceColor: UIColor =  UIColor.init(red: 1.00, green: 0.31, blue: 0.41, alpha: 1.0)
    
    // Color reference from Sip (macOS App). Color name is Mariner
    static let dashboardAboutHowToUseColor: UIColor =  UIColor.init(red: 0.15, green: 0.42, blue: 0.83, alpha: 1.0)
    
    static func loginColorSet() -> [Any] {
        
        // Color reference from http://www.flatuicolorpicker.com
        //
        // Color 1: Wisteria
        // Color 2: Chambray
        
        let color1 = UIColor(red: 155.0/255.0, green: 89.0/255.0, blue: 182.0/255.0, alpha: 1.0).cgColor
        let color2 = UIColor(red: 58.0/255.0, green: 83.0/255.0, blue: 155.0/255.0, alpha: 1.0).cgColor
        
        return [color1, color2]
        
    }
    
    static func dashboardColorSet() -> [Any] {
        
        // Color reference from http://www.flatuicolorpicker.com
        //
        // Color 1: Jacksons Purple (#1F3A93)
        // Color 2: Jelly Bean (#2574A9)
        
        let color1 = UIColor(red: 31.0/255.0, green: 58.0/255.0, blue: 147.0/255.0, alpha: 1.0).cgColor
        let color2 = UIColor(red: 37.0/255.0, green: 116.0/255.0, blue: 169.0/255.0, alpha: 1.0).cgColor
        
        return [color1, color2]
        
    }
    
    static func bannerColorGradient() -> [Any] {
        
        // Color reference from Sip (macOS App)
        //
        // Color 1: Royal Blue
        // Color 2: Violet Red
        
        let color1 = UIColor(red: 0.29, green: 0.44, blue: 0.90, alpha: 1.0).cgColor
        let color2 = UIColor(red: 0.96, green: 0.27, blue: 0.49, alpha: 1.0).cgColor
        
        return [color1, color2]
        
    }
    
    static func setMyHealthBPIndicatorColor(hexColor:String) -> NSArray {
        
        if(hexColor == "699A2D") {
            return [myHealthConditionOptimalColor, DBStrings.DB_MODULE_MYHEALTH_BP_CONDITION_OPTIMAL_EN, DBStrings.DB_MODULE_MYHEALTH_BP_CONDITION_OPTIMAL_MS, 1]
        }
        else if(hexColor == "98CE60") {
            return [myHealthConditionNormalColor, DBStrings.DB_MODULE_MYHEALTH_BP_CONDITION_NORMAL_EN, DBStrings.DB_MODULE_MYHEALTH_BP_CONDITION_NORMAL_MS, 2]
        }
        else if(hexColor == "FFCD00") {
            return [myHealthConditionCautiousColor,DBStrings.DB_MODULE_MYHEALTH_BP_CONDITION_HINORMAL_EN, DBStrings.DB_MODULE_MYHEALTH_BP_CONDITION_HINORMAL_MS, 3]
        }
        else if(hexColor == "FF8000") {
            return [myHealthConditionRiskColor,DBStrings.DB_MODULE_MYHEALTH_BP_CONDITION_HYPER_G1_EN, DBStrings.DB_MODULE_MYHEALTH_BP_CONDITION_HYPER_G1_MS, 4]
        }
        else if(hexColor == "E63E00") {
            return [myHealthConditionSevereColor,DBStrings.DB_MODULE_MYHEALTH_BP_CONDITION_HYPER_G2_EN, DBStrings.DB_MODULE_MYHEALTH_BP_CONDITION_HYPER_G2_MS, 5]
        }
        else {
            return [UIColor.init(red: 0.0/255.0, green: 0.0/255.0, blue: 0.0/255.0, alpha: 1.0),DBStrings.DB_MODULE_MYHEALTH_BP_CONDITION_UNKNOWN_EN, DBStrings.DB_MODULE_MYHEALTH_BP_CONDITION_UNKNOWN_MS, 0]
        }
        
    }
    
    static func setMyHealthBWIndicatorColor(bmiPoints: Int) -> NSArray {
        
        if(bmiPoints == 1) { return [myHealthConditionOptimalColor, DBStrings.DB_MODULE_MYHEALTH_BW_CONDITION_UNDERWEIGHT_EN, DBStrings.DB_MODULE_MYHEALTH_BW_CONDITION_UNDERWEIGHT_MS] }
        else if(bmiPoints == 2) { return [myHealthConditionNormalColor, DBStrings.DB_MODULE_MYHEALTH_BW_CONDITION_HEALTHYWEIGHT_EN, DBStrings.DB_MODULE_MYHEALTH_BW_CONDITION_HEALTHYWEIGHT_MS] }
        else if(bmiPoints == 3) { return [myHealthConditionCautiousColor, DBStrings.DB_MODULE_MYHEALTH_BW_CONDITION_OVERWEIGHT_EN, DBStrings.DB_MODULE_MYHEALTH_BW_CONDITION_OVERWEIGHT_MS] }
        else if(bmiPoints == 4) { return [myHealthConditionRiskColor, DBStrings.DB_MODULE_MYHEALTH_BW_CONDITION_OBESE_EN, DBStrings.DB_MODULE_MYHEALTH_BW_CONDITION_OBESE_MS] }
        else if(bmiPoints == 5) { return [myHealthConditionSevereColor, DBStrings.DB_MODULE_MYHEALTH_BW_CONDITION_SEVEREOBESE_EN, DBStrings.DB_MODULE_MYHEALTH_BW_CONDITION_SEVEREOBESE_MS] }
        else if(bmiPoints == 6) { return [myHealthConditionDeadlyColor, DBStrings.DB_MODULE_MYHEALTH_BW_CONDITION_MORBIDLYOBESE_EN, DBStrings.DB_MODULE_MYHEALTH_BW_CONDITION_MORBIDLYOBESE_MS] }
        else { return [UIColor.init(red: 0.0/255.0, green: 0.0/255.0, blue: 0.0/255.0, alpha: 1.0),DBStrings.DB_MODULE_MYHEALTH_BW_CONDITION_UNKNOWN_EN, DBStrings.DB_MODULE_MYHEALTH_BW_CONDITION_UNKNOWN_MS] }
        
    }
    
    // Color reference from Sip (macOS App). Color name is Purple Mountain's Majesty
    static let bannerColorFlat: UIColor = UIColor.init(red: 0.65, green: 0.49, blue: 0.76, alpha: 1.0)
    
    // Color reference from Sip (macOS App). Color name is Cadmium Orange
    static let myKomunitiColor: UIColor = UIColor.init(red: 0.95, green: 0.51, blue: 0.15, alpha: 1.0)
    
    // Color reference: https://flatuicolors.com. Color name: Midnight Blue
    static let myKomunitiPublicIndicator: UIColor = UIColor.init(red: 44.0/255.0, green: 62.0/255.0, blue: 80.0/255.0, alpha: 1.0)
    
    // Color reference: https://flatuicolors.com. Color name: Asbestos
    static let myKomunitiAdminIndicator: UIColor = UIColor.init(red: 127.0/255.0, green: 140.0/255.0, blue: 141.0/255.0, alpha: 1.0)
    
    // Color reference from Sip (macOS App). Color name is Carmine Pink
    static let mySoalColor: UIColor = UIColor.init(red: 0.92, green: 0.33, blue: 0.27, alpha: 1.0)
    
    // Color reference from Sip (macOS App). Color name is Tree Poppy
    static let mySkoolColor: UIColor = UIColor.init(red: 0.98, green: 0.63, blue: 0.08, alpha: 1.0)
    
    // Color reference from Sip (macOS App). Color name is Carribean Green
    static let myHealthColor: UIColor = UIColor.init(red: 0.11, green: 0.79, blue: 0.65, alpha: 1.0)
    
    // Color converted from Hex (#699A2D) to RGB via www.hexcolortool.com
    static let myHealthConditionOptimalColor: UIColor = UIColor.init(red: 105.0/255.0, green: 154.0/255.0, blue: 45.0/255.0, alpha: 1.0)
    
    // Color converted from Hex (#98CE60) to RGB via www.hexcolortool.com
    static let myHealthConditionNormalColor: UIColor = UIColor.init(red: 152.0/255.0, green: 206.0/255.0, blue: 96.0/255.0, alpha: 1.0)
    
    // Color converted from Hex (#FFCD00) to RGB via www.hexcolortool.com
    static let myHealthConditionCautiousColor: UIColor = UIColor.init(red: 255.0/255.0, green: 205.0/255.0, blue: 0.0/255.0, alpha: 1.0)
    
    // Color converted from Hex (#FF8000) to RGB via www.hexcolortool.com
    static let myHealthConditionRiskColor: UIColor = UIColor.init(red: 255.0/255.0, green: 128.0/255.0, blue: 0.0/255.0, alpha: 1.0)
    
    // Color converted from Hex (#E63E00) to RGB via www.hexcolortool.com
    static let myHealthConditionSevereColor: UIColor = UIColor.init(red: 230.0/255.0, green: 62.0/255.0, blue: 0.0/255.0, alpha: 1.0)
    
    // Color converted from Hex (#E63E00) to RGB via www.hexcolortool.com
    static let myHealthConditionDeadlyColor: UIColor = UIColor.init(red: 255.0/255.0, green: 0.0/255.0, blue: 0.0/255.0, alpha: 1.0)
    
    // Color reference from Sip (macOS App). Color name is Deep Lilac
    static let myShopColor: UIColor = UIColor.init(red: 0.62, green: 0.29, blue: 0.73, alpha: 1.0)
    
    // Color reference from http://flatuicolorpicker.com (macOS App). Color name is Wisteria
    static let myShopMenuEvenColor: UIColor = UIColor(red: 155.0/255.0, green: 89.0/255.0, blue: 182.0/255.0, alpha: 1.0)
    
    // Color reference from http://flatuicolorpicker.com (macOS App). Color name is Studio
    static let myShopMenuOddColor: UIColor = UIColor(red: 142.0/255.0, green: 68.0/255.0, blue: 173.0/255.0, alpha: 1.0)
    
    // Color reference from Sip (macOS App). Color name is Royal Purple
    static let aboutWhatDBBGColor: UIColor = UIColor.init(red: 0.43, green: 0.26, blue: 0.64, alpha: 1.0)
    
    //Background color.
    static let backgroundGray = UIColor.rgb(241, green: 241, blue: 241)
    static let myShopBackgroundColor = UIColor.rgb(244, green: 236, blue: 247)
}






