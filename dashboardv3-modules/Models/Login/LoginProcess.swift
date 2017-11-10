//
//  LoginProcess.swift
//  dashboardv2
//
//  Created by Mohd Zulhilmi Mohd Zain on 07/11/2017.
//  Copyright © 2017 Ingeniworks Sdn Bhd. All rights reserved.
//

import UIKit

class LoginProcess: NSObject {
    
    var retrievedURL: String = ""
    
    init(withURL: String) {
        self.retrievedURL = withURL
    }
    
    /**
     
     Perform dashboard login
     
     - Parameters dashboardToken: Token From dashboard.
     - Returns: User Data
     
     */
    
    func processLoginData(parameters: LoginDataParams) -> LoginDataRetrieved {
        
        let np: NetworkProcessor = NetworkProcessor.init(self.retrievedURL)
        let dataGot: LoginDataRetrieved = LoginDataRetrieved.init()
        let dispatching: DispatchGroup = DispatchGroup.init()
        dispatching.enter()
        
        let dataToDict: [String: Any] = ["username": parameters.sendUserName,
                                         "password": parameters.sendPassword,
                                         "regid": parameters.sendRegID,
                                         "imei": parameters.sendIMEI,
                                         "os": parameters.sendOS]
        
        np.postRequestJSONFromUrl(dataToDict, completion: { (result, response) in
            
            if(result!["success"] as! Int != 0) {
                
                DispatchQueue.global(qos: .default).async {
                    dataGot.status = result!["success"] as? Int ?? 0
                    dataGot.serverMessage = result!["message"] as? String ?? "N/A"
                    dataGot.userID = result!["user_id"] as? Int ?? 0
                    dataGot.userFullName = result!["full_name"] as? String ?? "N/A"
                    dataGot.userSiteID = result!["site_id"] as? Int ?? 0
                    dataGot.userSiteName = result!["site_name"] as? String ?? "N/A"
                    dataGot.userSiteCode = result!["sitecode"] as? String ?? "N/A"
                    dataGot.userEmail = result!["email"] as? String ?? "N/A"
                    dataGot.userEventID = result!["event_id"] as? Int ?? 0
                    dataGot.userToken = result!["token"] as? String ?? "N/A"

                    dispatching.leave()
                }
            }
            else {
                DispatchQueue.global(qos: .default).async {
                    dataGot.status = result!["success"] as? Int ?? 0
                    dataGot.serverMessage = result!["message"] as? String ?? "Unknown Error"
                    dispatching.leave()
                }
            }
            
            
        })
        
        dispatching.wait()
        
        return dataGot
        
    }
    
}

class UserData: NSObject {
    
    /// Check if user already logged in. Return as Boolean
    var loggedIn: Bool = false
    
    /// User Email. Return as String
    var email: String = ""
    
    /// User Full Name. Return as String
    var fullName: String = ""
    
    /// User IC No. Return as String
    var icNo: String = ""
    
    /// Server message. Return as String
    var message: String = ""
    
    /// User Site ID. Return as Integer
    var siteID: Int = 0
    
    /// User Site Name. Return as String
    var siteName: String = ""
    
    /// Return as String
    var siteCode: String = ""
    
    /// Return as Integer
    var loginStatus: Int = 0
    
    /// Return as String
    var token: String = ""
    
    override init() {
        
        self.loggedIn = UserDefaults.standard.object(forKey: "SuccessLoggerIsLogin") as? Bool ?? false
        self.email =  UserDefaults.standard.object(forKey: "SuccessLoggerEmail") as? String ?? "N/A"
        self.fullName = UserDefaults.standard.object(forKey: "SuccessLoggerFullName") as? String ?? "N/A"
        self.icNo = UserDefaults.standard.object(forKey: "SuccessLoggerICNo") as? String ?? "N/A"
        self.message = UserDefaults.standard.object(forKey: "SuccessLoggerMessage") as? String ?? "N/A"
        self.siteID = UserDefaults.standard.object(forKey: "SuccessLoggerSiteID") as? Int ?? 0
        self.siteName = UserDefaults.standard.object(forKey: "SuccessLoggerSiteName") as? String ?? "N/A"
        self.siteCode = UserDefaults.standard.object(forKey: "SuccessLoggerSiteCode") as? String ?? "N/A"
        self.loginStatus = UserDefaults.standard.object(forKey: "SuccessLoggerLoginStatus") as? Int ?? 0
        self.token = UserDefaults.standard.object(forKey: "SuccessLoggerDashboardToken") as? String ?? "N/A"
        
    }
    
}

class ChangeSettingsValue: NSObject {
    
    /// Read or set the Remember Me value.
   static var rememberMe: Bool {
        get {
            return UserDefaults.standard.object(forKey: "RememberLogger") as? Bool ?? true
        } set (setNewRememberMe) {
            UserDefaults.standard.set(setNewRememberMe, forKey: "RememberLogger")
        }
    }
    
    static var loggedIn: Bool {
        get {
            return UserDefaults.standard.object(forKey: "SuccessLoggerIsLogin") as? Bool ?? false
        } set (setNewLoggedIn) {
            UserDefaults.standard.set(setNewLoggedIn, forKey: "SuccessLoggerIsLogin")
        }
    }
    
    static func clearAllUserData() {
        
        UserDefaults.standard.set(false, forKey: "SuccessLoggerIsLogin")
        UserDefaults.standard.set("N/A", forKey: "SuccessLoggerEmail")
        UserDefaults.standard.set("N/A", forKey: "SuccessLoggerFullName")
        UserDefaults.standard.set("N/A", forKey: "SuccessLoggerICNo")
        UserDefaults.standard.set("N/A", forKey: "SuccessLoggerMessage")
        UserDefaults.standard.set(0, forKey: "SuccessLoggerSiteID")
        UserDefaults.standard.set("N/A", forKey: "SuccessLoggerSiteName")
        UserDefaults.standard.set("N/A", forKey: "SuccessLoggerSiteCode")
        UserDefaults.standard.set(0, forKey: "SuccessLoggerLoginStatus")
        UserDefaults.standard.set("N/A", forKey: "SuccessLoggerDashboardToken")
        
    }
    
}
