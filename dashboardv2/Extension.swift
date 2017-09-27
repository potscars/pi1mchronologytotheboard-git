//
//  Extension.swift
//  DBPrototype
//
//  Created by Hainizam on 20/09/2017.
//  Copyright © 2017 com.ingeniworks. All rights reserved.
//

import UIKit

extension UIView {
    
    func addShadow() {
        layer.masksToBounds = false
        layer.shadowPath = UIBezierPath(roundedRect: bounds, cornerRadius: 10).cgPath
        layer.shadowRadius = 2.5
        layer.shadowOffset = CGSize(width: -1, height: -1)
        layer.shadowOpacity = 0.7
        layer.shadowColor = UIColor.black.cgColor
    }
    
    func roundedCorners(_ roundedValue: CGFloat) {
        
        layer.cornerRadius = roundedValue
        layer.masksToBounds = true
        clipsToBounds = true
    }
}
