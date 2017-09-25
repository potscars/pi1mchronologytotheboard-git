//
//  DBMenus.swift
//  dashboardv2
//
//  Created by Mohd Zulhilmi Mohd Zain on 28/12/2016.
//  Copyright © 2016 Ingeniworks Sdn Bhd. All rights reserved.
//

import UIKit

class DBMenus: NSObject {
    
    static func dashboardHeader() -> NSArray {
        
        return []
        
    }
    
    static func dashboardFrontMenu() -> NSArray {
        
        var dictionaryAdd: NSDictionary = ["MenuString":"NULL","ColorObject":"NULL"]
        let compiledArrays: NSMutableArray = []
        
        dictionaryAdd = ["MenuString":DBStrings.DB_MENU_MYKOMUNITI_MS, "IconString":DBImages.DB_ICON_MYKOMUNITI, "ColorObject": DBColorSet.myKomunitiColor]
        compiledArrays.add(dictionaryAdd)
        dictionaryAdd = ["MenuString":DBStrings.DB_MENU_MYSOAL_MS, "IconString":DBImages.DB_ICON_MYSOAL, "ColorObject": DBColorSet.mySoalColor]
        compiledArrays.add(dictionaryAdd)
        dictionaryAdd = ["MenuString":DBStrings.DB_MENU_MYSKOOL_MS, "IconString":DBImages.DB_ICON_MYSKOOL, "ColorObject": DBColorSet.mySkoolColor]
        compiledArrays.add(dictionaryAdd)
        dictionaryAdd = ["MenuString":DBStrings.DB_MENU_MYHEALTH_MS, "IconString":DBImages.DB_ICON_MYHEALTH, "ColorObject": DBColorSet.myHealthColor]
        compiledArrays.add(dictionaryAdd)
        dictionaryAdd = ["MenuString":DBStrings.DB_MENU_MYSHOP_MS, "IconString":DBImages.DB_ICON_MYSHOP, "ColorObject": DBColorSet.myShopColor]
        compiledArrays.add(dictionaryAdd)
        dictionaryAdd = ["MenuString":DBStrings.DB_MENU_MYPLACES, "IconString":DBImages.DB_ICON_MYPLACES, "ColorObject": DBColorSet.mySoalColor]
        compiledArrays.add(dictionaryAdd)
        dictionaryAdd = ["MenuString":DBStrings.DB_MENU_MYGAMES, "IconString":DBImages.DB_ICON_MYGAMES, "ColorObject": DBColorSet.myKomunitiColor]
        compiledArrays.add(dictionaryAdd)
        
        return compiledArrays
    }
    
    static func dashboardSettingsMenu() -> NSArray {
        
        var dictionaryAdd: NSDictionary = [:]
        let compiledArrays: NSMutableArray = []
        
        dictionaryAdd = ["MenuTitle":"NULL","MenuDescription":"NULL","PredefinedSelector":"DB_SETTINGS_REMEMBERME"]
        compiledArrays.add(dictionaryAdd)
        
        return compiledArrays
        
    }

}
