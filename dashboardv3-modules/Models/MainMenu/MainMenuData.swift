//
//  MainMenuData.swift
//  dashboardv2
//
//  Created by Mohd Zulhilmi Mohd Zain on 09/11/2017.
//  Copyright © 2017 Ingeniworks Sdn Bhd. All rights reserved.
//

import UIKit

class MainMenuData: NSObject {

}

class MainMenuQuizRetrieved: NSObject {
    
    var data: String = "[AppResponse] Internal App Error. Contact administrator."
    var status: Int = 0
    
    override init() {}
    
}

class MainMenuQuizParams: NSObject {
    
    var dashboardToken: String = ""
    
    override init() {}
}
