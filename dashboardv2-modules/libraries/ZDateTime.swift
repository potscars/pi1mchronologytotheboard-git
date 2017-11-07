//
//  ZDateTime.swift
//  dashboardv2
//
//  Created by Mohd Zulhilmi Mohd Zain on 26/01/2017.
//  Copyright © 2017 Ingeniworks Sdn Bhd. All rights reserved.
//

import UIKit

class ZDateTime: NSObject {
    
    static let DateInLong: String = "dd MMMM yyyy, h:mm:ss a"
    static let DateInShort: String = "dd/MM/yy"
    
    static func dateFormatConverter(valueInString: String, dateTimeFormatFrom: String?, dateTimeFormatTo: String?) -> String {
        
        print("[ZDateTime] Value parsed is \(valueInString)")
        
        let originalDate: DateFormatter = DateFormatter()
        originalDate.timeZone = NSTimeZone(name: "GMT+08:00")! as TimeZone
        if(dateTimeFormatFrom != nil) { originalDate.dateFormat = dateTimeFormatFrom } else { originalDate.dateFormat = "yyyy-MM-dd HH:mm:ss" }
        let setDate: Date = originalDate.date(from: valueInString)!
        if(dateTimeFormatTo != nil) { originalDate.dateFormat = dateTimeFormatTo } else { originalDate.dateFormat = DateInLong }
        
        
        return String(utf8String: originalDate.string(from: setDate))!
    }

}
