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
