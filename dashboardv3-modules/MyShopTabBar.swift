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
        let homeButton = UIBarButtonItem(image: #imageLiteral(resourceName: "ic_home_white"), style: .done, target: self, action: #selector(homeButtonTapped(_:)))
        navigationItem.leftBarButtonItem = homeButton
    }
    
    @objc func homeButtonTapped(_ sender: UIBarButtonItem) {
        print("Tapped")
    }
}
