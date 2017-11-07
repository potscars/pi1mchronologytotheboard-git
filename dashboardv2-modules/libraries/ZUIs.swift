//
//  ZUIs.swift
//  dashboardv2
//
//  Created by Mohd Zulhilmi Mohd Zain on 06/12/2016.
//  Copyright © 2016 Ingeniworks Sdn Bhd. All rights reserved.
//

import UIKit

class ZUIs: NSObject {
    
    static func showOKDialogBox(viewController:UIViewController, dialogTitle:String, dialogMessage:String, afterDialogDismissed:String?)
    {
        let alertView: UIAlertController = UIAlertController.init(title: dialogTitle, message: dialogMessage, preferredStyle: UIAlertControllerStyle.alert)
        
        let alertOKAction: UIAlertAction = UIAlertAction.init(title: "OK", style: UIAlertActionStyle.default, handler: { (action) in
            
            if(afterDialogDismissed == "BACK_TO_PREVIOUS_VIEWCONTROLLER") {
                
                print("[ZUIs] showOKDialogBox: Back to prev controller.")
                
                _ = viewController.navigationController?.popToRootViewController(animated: false)
                
            }
            else if(afterDialogDismissed != nil) {
                
                print("[ZUIs] showOKDialogBox: Invalid afterDialogDismissed.")
                
            }
            
            alertView.dismiss(animated: true, completion: {
                
            })
        
        })
        
        alertView.addAction(alertOKAction)
        
        viewController.present(alertView, animated: true, completion: nil)
    }

}
