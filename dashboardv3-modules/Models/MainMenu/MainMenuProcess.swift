//
//  MainMenuProcess.swift
//  dashboardv2
//
//  Created by Mohd Zulhilmi Mohd Zain on 09/11/2017.
//  Copyright © 2017 Ingeniworks Sdn Bhd. All rights reserved.
//

import UIKit

class MainMenuProcess: NSObject {
    


}

class MainMenuQuizProcess: NSObject {
    
    var retrievedURL: String = ""
    
    init(withURL: String) {
        self.retrievedURL = withURL
    }
    
    // QUIZ
    
    func verifyUserIsEligible(dashboardToken: MainMenuQuizParams) -> MainMenuQuizRetrieved {
        
        let combinedUrl: String = String.init(format: "%@/%@", self.retrievedURL,dashboardToken.dashboardToken)
        let dispatching: DispatchGroup = DispatchGroup.init()
        dispatching.enter()
        
        let np: NetworkProcessor = NetworkProcessor.init(combinedUrl)
        let quizData: MainMenuQuizRetrieved = MainMenuQuizRetrieved.init()
        
        np.getRequestJSONFromUrl({(result, response) in
            
            let resultData: NSDictionary? = result as? NSDictionary ?? nil
            
            if resultData != nil {
                DispatchQueue.global(qos: .default).async {
                
                    quizData.status = resultData!.value(forKey: "status") as? Int ?? 0
                    quizData.data = resultData!.value(forKey: "data") as? String ?? "No data"
                    
                    dispatching.leave()
                }
            }
            
        })
        
        dispatching.wait()
        
        return quizData
    }
    
}









