//
//  MySoalProcess.swift
//  dashboardv2
//
//  Created by Mohd Zulhilmi Mohd Zain on 08/11/2017.
//  Copyright © 2017 Ingeniworks Sdn Bhd. All rights reserved.
//

import UIKit

class MySoalProcess: NSObject {
    
    var retrievedURL: String = ""
    
    init(withURL: String) {
        self.retrievedURL = withURL
    }
    
    /// Due to MySoal is absurdly separate system, both require absurdly separate token.

    func processMySoalToken(parameters: MySoalDataParams) -> MySoalDataRetrieval {
        
        let np: NetworkProcessor = NetworkProcessor.init(self.retrievedURL)
        let dataGot: MySoalDataRetrieval = MySoalDataRetrieval.init()
        let dispatching: DispatchGroup = DispatchGroup.init()
        dispatching.enter()
        
        np.postRequestJSONFromUrl(["dash_token": parameters.dashboardToken], completion: { (mysoalResult, mysoalResponse) in
            
            DispatchQueue.global(qos: .default).async {
                
                if(mysoalResult!["token"] as? String != nil) {  dataGot.tokenMySoal = mysoalResult!["token"] as? String ?? "N/A" }
                else { dataGot.tokenErrorMessage = mysoalResult!["error"] as? String ?? "Unknown Error" }
                
                dispatching.leave()
                
            }
            
        })
        
        dispatching.wait()
        
        return dataGot
    }
    
}
