//
//  ZGraphics.swift
//  dashboardv2
//
//  Created by Mohd Zulhilmi Mohd Zain on 27/11/2016.
//  Copyright © 2016 Ingeniworks Sdn Bhd. All rights reserved.
//

import UIKit

class ZGraphics: NSObject {
    
    static func labelLayerFadeAnimation(labelView:UILabel, labelTextToAnimate:String) {
        
        let animation: CATransition = CATransition.init()
        animation.timingFunction = CAMediaTimingFunction.init(name: kCAMediaTimingFunctionEaseInEaseOut)
        animation.type = kCATransitionFade
        animation.duration = CFTimeInterval(0.5)
        labelView.layer.add(animation, forKey: "kCATransitionFade")
        
        labelView.text = labelTextToAnimate
        
    }
    
    static func buttonLabelFadeAnimation(button:UIButton, animType:UIViewAnimationOptions, labelTextToAnimate:String) {
        
        UIView.transition(with: button, duration: 1, options: animType, animations: {
        
            button.setTitle(labelTextToAnimate, for: UIControlState.normal)
            
        }, completion: { (action) in })
        
    }
    
    static func moveViewYPosition(view:UIView, yPosition:CGFloat, animationDuration:TimeInterval, moveToUp:Bool) {
        
        UIView.beginAnimations("MoveView", context: nil)
        UIView.setAnimationCurve(UIViewAnimationCurve.easeIn)
        UIView.setAnimationDuration(animationDuration)
        
        if(moveToUp == true) {
            
            view.frame = CGRect(x: view.frame.origin.x, y: view.frame.origin.y-yPosition, width: view.frame.size.width, height: view.frame.size.height)
            
        }
        else {
            
            view.frame = CGRect(x: view.frame.origin.x, y: view.frame.origin.y+yPosition, width: view.frame.size.width, height: view.frame.size.height)
            
        }
        
        UIView.commitAnimations()
    }
    
    static func applyGradientColorAtView(mainView:UIView, colorSet: [Any]) {
                
        let gradient = CAGradientLayer()
        gradient.frame = mainView.frame
        gradient.bounds = mainView.bounds
        gradient.colors = colorSet
        gradient.startPoint = CGPoint.zero
        gradient.endPoint = CGPoint(x: 1, y: 1)
        mainView.layer.insertSublayer(gradient, at: 0)
        
    }
    
    static func whiteStatusBar(apply: Bool)
    {
        if (apply == true) {
            UIApplication.shared.statusBarStyle = UIStatusBarStyle.lightContent
        }
        else {
            UIApplication.shared.statusBarStyle = UIStatusBarStyle.default
        }
    }
    
    static func applyNavigationBarColor(controller: UIViewController, setBarTintColor: UIColor, setBackButtonFontColor:UIColor, setBarFontColor: UIColor, setBarFontFace: UIFont)
    {
        controller.navigationController?.navigationBar.barTintColor = setBarTintColor
        controller.navigationController?.navigationBar.tintColor = setBackButtonFontColor
        controller.navigationController?.navigationBar.titleTextAttributes = [NSForegroundColorAttributeName: setBarFontColor,NSFontAttributeName:setBarFontFace]
    }
    
    static func adjustTextBarToTextOnly(tabBarItem: UITabBarItem, normalStateDefinedAttributes: [String : Any]?, selectedStateDefinedAttributes: [String : Any]?)
    {
        tabBarItem.titlePositionAdjustment = UIOffset.init(horizontal: 0, vertical: -13)
        
        if(selectedStateDefinedAttributes != nil)
        {
            tabBarItem.setTitleTextAttributes(selectedStateDefinedAttributes, for: UIControlState.selected)
        }
        
        if(normalStateDefinedAttributes != nil)
        {
            tabBarItem.setTitleTextAttributes(normalStateDefinedAttributes, for: UIControlState.normal)
        }
    }
    
    static func hideTableSeparatorAfterLastCell(tableView: UITableView)
    {
        tableView.tableFooterView = UIView.init(frame: CGRect.init(x: 0, y: 0, width: tableView.frame.size.width, height: 1))
    }

}
