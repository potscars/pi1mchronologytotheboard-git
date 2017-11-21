//
//  CustomString.swift
//  dashboardv2
//
//  Created by Mohd Zulhilmi Mohd Zain on 17/11/2017.
//  Copyright © 2017 Ingeniworks Sdn Bhd. All rights reserved.
//

import UIKit

extension String {
    
    var length: Int {
        //Deprecated: return self.characters.count
        return self.count
    }
    
    subscript (i: Int) -> String {
        return self[i ..< i + 1]
    }
    
    func substring(fromIndex: Int) -> String {
        return self[min(fromIndex, length) ..< length]
    }
    
    func substring(toIndex: Int) -> String {
        return self[0 ..< max(0, toIndex)]
    }
    
    subscript (r: Range<Int>) -> String {
        let range = Range(uncheckedBounds: (lower: max(0, min(length, r.lowerBound)),
                                            upper: min(length, max(0, r.upperBound))))
        let start = index(startIndex, offsetBy: range.lowerBound)
        let end = index(start, offsetBy: range.upperBound - range.lowerBound)
        return String(self[start ..< end])
    }
    
    static func checkStringValidity(data: Any?, defaultValue: String) -> String {
        
        if data is String {
            
            return data as! String
            
        }
        else {
            
            return defaultValue
            
        }
        
    }

}
