//
//  LoginData.swift
//  dashboardv2
//
//  Created by Mohd Zulhilmi Mohd Zain on 07/11/2017.
//  Copyright © 2017 Ingeniworks Sdn Bhd. All rights reserved.
//

import UIKit

class LoginDataParams: NSObject {
    
    var sendUserName: String = ""
    var sendPassword: String = ""
    var sendRegID: String = ""
    var sendIMEI: String = ""
    var sendOS: String = ""
    
    override init() { super.init() }
}

class LoginDataRetrieved: NSObject {
    
    var serverResponse: String = "N/A"
    var serverMessage: String = "Unknown Error"
    var status: Int = 0
    var userSiteID: Int = 0
    var userSiteName: String = "N/A"
    var userEmail: String = "N/A"
    var userEventID: Int = 0
    var userICNo: String = "N/A"
    var userFullName: String = "N/A"
    var userID: Int = 0
    var userSiteCode: String = "N/A"
    var userToken: String = "N/A"
    
    override init() { super.init() }
    
}

class MySoalDataParams: NSObject {
    
    var dashboardToken: String = "N/A"
    
    override init() { super.init() }
    
}

class MySoalDataRetrieval: NSObject {
    
    var tokenMySoal: String = "N/A"
    var tokenErrorMessage: String = "N/A"
    
    override init() { super.init() }
    
}

class MySkoolDataParams: NSObject {
    
    var dashboardToken: String = "N/A"
    
    override init() { super.init() }
    
}

class MySkoolDataRetrieval: NSObject {
    
    var tokenMySkool: String = "N/A"
    var tokenErrorMessage: String = "N/A"
    
    override init() { super.init() }
    
}
