//
//  ZHealth.swift
//  dashboardv2
//
//  Created by Mohd Zulhilmi Mohd Zain on 26/01/2017.
//  Copyright © 2017 Ingeniworks Sdn Bhd. All rights reserved.
//

import UIKit

class ZHealth: NSObject {
    
    static func simpleBodyMassIndexForAsian(point: Double) -> NSArray
    {
        // reference from http://asianbariatrics.com/calculate-your-bmi/
        
        if(point <= 18.0) { return ["Underweight", 1] }
        else if(point >= 18.0 && point <= 25.0) { return ["Ideal", 2] }
        else if(point >= 25.0 && point <= 30.0) { return ["Overweight", 3] }
        else if(point >= 30.0 && point <= 35.0) { return ["Obese", 4] }
        else if(point >= 35.0 && point <= 40.0) { return ["Severe Obese", 5] }
        else if(point >= 40.0) { return ["Morbidly Obese", 6] }
        else { return ["Unknown", 0] }
        
    }
    
    static func detailedBodyMassIndexForAsian(point: Double) -> NSArray
    {
        // reference from https://aadi.joslin.org
        
        if(point <= 18.5) { return ["Underweight","Your weight is below healthy range. This can put you at risk for developing many health problems. Talk to your healthcare provider about your ideal body weight."] }
        else if(point >= 18.5 && point <= 22.9) { return ["Ideal","Your weight is within healthy range. Continue exercising and eating healthfully."] }
        else if(point >= 23 && point <= 26.9) { return ["Overweight","Your weight is above healthy range. Your risk for developing diabetes and other chronic disease and other chronic diseases are higher. Talk to your healthcare provider about your ideal body weight and how to make healthy lifestyle changes."] }
        else if(point >= 27 ) { return ["Obese","Your weight is further above healthy range. It increases the risk for developing many chronic diseases such as heart disease and diabetes, and decreases overall quality of life. Talk to your healthcare provider about your ideal body weight and how to make healthy lifestyle changes."] }
        else { return ["Ideal","Your weight is within healthy range. Continue exercising and eating healthfully."] }
        
    }

}
