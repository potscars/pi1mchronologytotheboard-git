//
//  MyKomunitiProcess.swift
//  dashboardv2
//
//  Created by Mohd Zulhilmi Mohd Zain on 22/11/2017.
//  Copyright © 2017 Ingeniworks Sdn Bhd. All rights reserved.
//

import UIKit

class MyKomunitiProcess: NSObject {
    
    static let myKomunitiAdminURL: String = DBSettings.myKomunitiAdminURL
    static let myKomunitiPublicURL: String = DBSettings.myKomunitiPublicURL
    
    override init() {
        super.init()
    }
    
    static func getAnnoucement(page: Int) -> MyKomunitiKeys {
        
        var mkdStore: MyKomunitiKeys? = nil
        let ud: UserData = UserData.init()
        let restructURL: String = String.init(format: "%@%@?page=%i", myKomunitiPublicURL, ud.token, page)
        let np: NetworkProcessor = NetworkProcessor.init(restructURL)
        let dispatching: DispatchGroup = DispatchGroup.init()
        dispatching.enter()
        
        np.getRequestJSONFromUrl ({ (result, response) in
            
            if(result != nil) {
                DispatchQueue.global(qos: .default).async {
                    mkdStore = MyKomunitiKeys.init(dictData: result! as! NSDictionary)
                    
                    dispatching.leave()
                }
            }
            
        })
        
        dispatching.wait()
        
        return mkdStore!
    }
    
}
