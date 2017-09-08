//
//  ZParsers.swift
//  dashboardv2
//
//  Created by Mohd Zulhilmi Mohd Zain on 05/01/2017.
//  Copyright © 2017 Ingeniworks Sdn Bhd. All rights reserved.
//

import UIKit

class ZParsers: NSObject {
    
    static func parseAllHTMLStrings(stringToParse: String?) -> String? {
        
        var parsed = stringToParse?.replacingOccurrences(of: "<[^>]+>", with: "", options: String.CompareOptions.regularExpression, range: nil)
        
        parsed = parsed?.replacingOccurrences(of: "&nbsp", with: "", options: String.CompareOptions.regularExpression, range: nil)
        
        return parsed ?? ""
        
    }

}
