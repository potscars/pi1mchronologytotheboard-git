//
//  MyKomunitiMainTabVC.swift
//  dashboardv2
//
//  Created by Mohd Zulhilmi Mohd Zain on 05/01/2017.
//  Copyright © 2017 Ingeniworks Sdn Bhd. All rights reserved.
//

import UIKit

class MyKomunitiMainTabVC: UITabBarController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        ZGraphics.applyNavigationBarColor(controller: self, setBarTintColor: DBColorSet.myKomunitiColor, setBackButtonFontColor: UIColor.init(red: 255.0/255.0, green: 255.0/255.0, blue: 255.0/255.0, alpha: 1.0), setBarFontColor: UIColor.init(red: 255.0/255.0, green: 255.0/255.0, blue: 255.0/255.0, alpha: 1.0), setBarFontFace: UIFont.init(name: "Arial-BoldMT", size: CGFloat(17.0))!)
        
        self.tabBar.barTintColor = UIColor.init(cgColor: DBColorSet.myKomunitiColor.cgColor)
        let firstTabBar: UITabBarItem = self.tabBar.items![0] as UITabBarItem
        let secondTabBar: UITabBarItem = self.tabBar.items![1] as UITabBarItem
        ZGraphics.adjustTextBarToTextOnly(tabBarItem: firstTabBar, normalStateDefinedAttributes: [NSFontAttributeName:UIFont.init(name: "RobotoCondensed-Regular", size: 18.0)!,NSForegroundColorAttributeName:UIColor.lightGray], selectedStateDefinedAttributes: [NSFontAttributeName:UIFont.init(name: "RobotoCondensed-Bold", size: 18.0)!,NSForegroundColorAttributeName:UIColor.white])
        ZGraphics.adjustTextBarToTextOnly(tabBarItem: secondTabBar, normalStateDefinedAttributes: [NSFontAttributeName:UIFont.init(name: "RobotoCondensed-Regular", size: 18.0)!,NSForegroundColorAttributeName:UIColor.lightGray], selectedStateDefinedAttributes: [NSFontAttributeName:UIFont.init(name: "RobotoCondensed-Bold", size: 18.0)!,NSForegroundColorAttributeName:UIColor.white])
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
