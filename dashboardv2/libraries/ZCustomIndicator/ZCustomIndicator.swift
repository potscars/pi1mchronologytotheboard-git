//
//  ZCustomIndicator.swift
//  dashboardv2
//
//  Created by Mohd Zulhilmi Mohd Zain on 27/11/2016.
//  Copyright © 2016 Ingeniworks Sdn Bhd. All rights reserved.
//

import UIKit

class ZCustomIndicator: UIView {

    @IBOutlet weak var uiaivZCIIndicator: UIActivityIndicatorView!
    @IBOutlet weak var uilZCILoadingText: UILabel!
    
    /*
    // Only override draw() if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func draw(_ rect: CGRect) {
        // Drawing code
    }
    */
    
    func initWithString(labelString:String) {
        
        uilZCILoadingText.text = labelString
        
    }

}
