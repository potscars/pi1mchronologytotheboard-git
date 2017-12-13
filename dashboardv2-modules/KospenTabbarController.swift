//
//  KospenTabbarController.swift
//  dashboardv2
//
//  Created by Hainizam on 23/11/2017.
//  Copyright © 2017 Ingeniworks Sdn Bhd. All rights reserved.
//

import UIKit

class KospenTabbarController: UITabBarController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationController?.navigationBar.backgroundColor = UIColor.rgb(130, green: 224, blue: 170)
        self.tabBar.tintColor = DBColorSet.myHealthColor
    }
}










