//
//  ZCustomIndicatorVC.swift
//  dashboardv2
//
//  Created by Mohd Zulhilmi Mohd Zain on 27/11/2016.
//  Copyright © 2016 Ingeniworks Sdn Bhd. All rights reserved.
//

import UIKit

class ZCustomIndicatorVC: UIViewController {
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
    }
    
    static func displayProgress(mainView: UIViewController, labelString:String, animateProgress:Bool) {
        
        let zci = ZCustomIndicator()
        zci.initWithString(labelString: labelString)
        mainView.view.addSubview(zci)
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
