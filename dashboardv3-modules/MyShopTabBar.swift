//
//  MyShopTabBar.swift
//  dashboardv2
//
//  Created by Hainizam on 07/11/2017.
//  Copyright © 2017 Ingeniworks Sdn Bhd. All rights reserved.
//

import UIKit

class MyShopTabBar: UITabBarController {

    override func viewDidLoad() {
        super.viewDidLoad()

        configureTabbar()
    }
    
    func configureTabbar() {
        UITabBar.appearance().tintColor = DBColorSet.myShopColor
    }
}
