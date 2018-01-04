//
//  TagView.swift
//  UUIDAPP
//
//  Created by Hainizam on 28/12/2017.
//  Copyright © 2017 com.ingeniworks. All rights reserved.
//

import UIKit

class TagView: UIView {
    
    var titles: [String]! {
        didSet {
            self.updateUI()
        }
    }
    
    var fontSize: CGFloat = 14.0
    
    var viewCollection = [UIView]()
    
    func updateUI() {
        
        if viewCollection.count > 0 {
            viewCollection.removeAll()
            for hView in viewCollection {
                hView.removeFromSuperview()
            }
        }
        
        for title in titles {
            viewCollection.append(createViewWithLabelTitle(title))
        }
        
        createTagView(withViews: viewCollection)
    }
    
    func createTagView(withViews views: [UIView]) {
        
        let offset = 5.0
        var x = 0.0, y = 5.0, row = 0.0
        
        let viewFrame = self.frame
        
        for (index, hView) in views.enumerated() {
            
            let tempView = hView
            
            row += Double(tempView.frame.width) + offset
            
            if row < Double(viewFrame.width)
            {
                x = index == 0 ? offset : row - Double(tempView.frame.width)
            }
            else
            {
                x = offset
                row = Double(tempView.frame.width) + offset
                y += Double(tempView.frame.height) + offset
            }
            
            let frame = CGRect(x:CGFloat(x), y:CGFloat(y), width:tempView.frame.width, height:tempView.frame.height)
            tempView.frame = frame
            
            self.addSubview(tempView)
        }
    }
    
    func createViewWithLabelTitle(_ title: String) -> UIView {
        
        let hView = UIView()
        hView.backgroundColor = .darkGray
        hView.sizeToFit()
        
        let hLabel = UILabel()
        hLabel.font = UIFont.systemFont(ofSize: fontSize)
        hLabel.text = title
        hLabel.textColor = .white
        hLabel.textAlignment = .center
        hLabel.frame = CGRect(x: 6.0, y: 0, width: 0, height: 0)
        hLabel.sizeToFit()
        
//        let hButton = UIButton()
//        hButton.setTitle("X", for: .normal)
//        hButton.titleLabel?.font = UIFont.systemFont(ofSize: fontSize - 2.0)
//        hButton.titleLabel?.textAlignment = .center
//        hButton.frame = CGRect(x: hLabel.frame.width + 8.0, y: (hLabel.frame.size.height / 2.0) - (7.5), width: fontSize + 1, height: fontSize + 1)
        
//        hButton.backgroundColor = .lightGray
//        hButton.layer.cornerRadius = hButton.frame.height / 2
//        hButton.clipsToBounds = true
        
        let labelSize = hLabel.frame.size
        //let buttonSize = hButton.frame.size
        hView.frame = CGRect(x: 0.0, y: 0.0, width: labelSize.width + 10.0, height: labelSize.height)
        
        hView.layer.cornerRadius = hLabel.frame.height / 2
        hView.clipsToBounds = true
        
        hView.addSubview(hLabel)
        //hView.addSubview(hButton)
        
        return hView
    }
}










