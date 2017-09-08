//
//  ZDeviceInfo.swift
//  dashboardv2
//
//  Created by Mohd Zulhilmi Mohd Zain on 07/12/2016.
//  Copyright © 2016 Ingeniworks Sdn Bhd. All rights reserved.
//

import UIKit

class ZDeviceInfo: NSObject {
    
    static func getDeviceVendorIdentifier(replaced:Bool) -> String {
        
        print("[ZDI] Attempt to get identifier...")
        
        let device: UIDevice = UIDevice.current
        let uniqueIdentifierRaw = device.identifierForVendor?.uuidString
        var identifierFormatting: String? = ""
        
        if (uniqueIdentifierRaw == nil) {
            
            identifierFormatting = "1234657890"
            
        }
        else {
            
            identifierFormatting = uniqueIdentifierRaw?.replacingOccurrences(of: "-", with: "")
            
        }
        
        print("[ZDI] Id for this device is \(identifierFormatting!)")
        
        if(replaced == true)
        {
            return identifierFormatting!
        }
        else
        {
            return uniqueIdentifierRaw!
        }
        
    }

}
