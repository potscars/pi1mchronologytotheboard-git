//
//  AlertController.swift
//  dashboardv2
//
//  Created by Hainizam on 28/07/2017.
//  Copyright © 2017 Ingeniworks Sdn Bhd. All rights reserved.
//

import Foundation
import UIKit

class AlertController {
    
    func alertController(_ viewController: UIViewController, title: String, message: String) {
        
        let alertController = UIAlertController(title: title, message: message, preferredStyle: .alert)
        
        let okayButton = UIAlertAction(title: "Okay", style: .default, handler: nil)
        
        alertController.addAction(okayButton)
        
        viewController.present(alertController, animated: true, completion: nil)
    }
}
