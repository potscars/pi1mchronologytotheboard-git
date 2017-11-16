//
//  MySkoolProcess.swift
//  dashboardv2
//
//  Created by Mohd Zulhilmi Mohd Zain on 08/11/2017.
//  Copyright © 2017 Ingeniworks Sdn Bhd. All rights reserved.
//

import UIKit

class MySkoolProcess: NSObject {
    
    var retrievedURL: String = ""
    
    init(withURL: String) {
        self.retrievedURL = withURL
    }

    /// Due to MySkool is absurdly separate system, both require absurdly separate token.
    
    func processMySkoolToken(parameters: MySkoolDataParams) -> MySkoolDataRetrieval {
        
        let np: NetworkProcessor = NetworkProcessor.init(self.retrievedURL)
        let dataGot: MySkoolDataRetrieval = MySkoolDataRetrieval.init()
        let dispatching: DispatchGroup = DispatchGroup.init()
        dispatching.enter()
        
        
        np.postRequestJSONFromUrl(["dash_token": parameters.dashboardToken], completion: { (myskoolResult, myskoolResponse) in
            
            DispatchQueue.global(qos: .default).async {
                
                if(myskoolResult!["token"] as? String != nil) { dataGot.tokenMySkool = myskoolResult!["token"] as? String ?? "N/A" }
                else { dataGot.tokenErrorMessage = myskoolResult!["error"] as? String ?? "Unknown Error" }
                
                dispatching.leave()
                
            }
            
        })
        
        dispatching.wait()
        
        return dataGot
        
    }
}
