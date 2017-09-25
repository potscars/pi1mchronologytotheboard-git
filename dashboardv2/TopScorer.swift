//
//  TopScorer.swift
//  dashboardv2
//
//  Created by Hainizam on 24/08/2017.
//  Copyright © 2017 Ingeniworks Sdn Bhd. All rights reserved.
//

import Foundation

class TopScorer {
    
    var id: String?
    var score: String?
    var fullname: String?
    var icnumber: String?
    
    init(_ id: String, score: String, fullname: String, icnumber: String) {
        
        self.id = id
        self.score = score
        self.fullname = fullname
        self.icnumber = icnumber
    }
    
    init() { }
    
    typealias TopScorerHandler = ([TopScorer]?, String?) -> ()
    
    func fetchTopScorer(_ gamesID: Int, eventID: Int, completion: @escaping TopScorerHandler) {
        
        var idTemp: String = "0000x000a23000"
        var scoreTemp: String = "0"
        var fullnameTemp: String = "Not Available"
        var icnumberTemp: String = "0"
        
        var topScorer = [TopScorer]()
        
        let dbToken = UserDefaults.standard.object(forKey: "SuccessLoggerDashboardToken") as! String
        
        let urlString = "\(DBSettings.myGamesTopScorerByRegionURL)\(dbToken)/\(gamesID)/\(eventID)"
        print("GAMES SCORE : \(urlString)")
        let networkProcessor = NetworkProcessor.init(urlString)
        
        networkProcessor.downloadJSONFromUrl { (result, responses) in
            
            guard responses == nil else { completion(nil, responses); return }
            
            if let dataResult = result as? NSDictionary {
                
                if let status = dataResult["status"] as? Int, status == 1 {
                    
                    print("Status: \(status)")
                    
                    if let dataArray = dataResult["data"] as? NSArray, dataArray.count > 0 {
                        
                        for data in dataArray {
                            
                            guard let user = (data as AnyObject).value(forKey: "user") as? NSDictionary else { return }
                            
                            if let idResult = user["id"] as? String {
                                idTemp = idResult
                            }
                            
                            if let scoreResult = (data as AnyObject).value(forKey: "score") as? String {
                                scoreTemp = scoreResult
                            }
                            
                            if let icnumberResult = user["ic_no"] as? String {
                                icnumberTemp = icnumberResult
                            }
                            
                            if let fullnameResult = user["full_name"] as? String {
                                fullnameTemp = fullnameResult
                            }
                            
                            topScorer.append(TopScorer.init(idTemp, score: scoreTemp, fullname: fullnameTemp, icnumber: icnumberTemp))
                        }
                        
                        completion(topScorer, nil)
                        
                    } else {
                        
                        completion(nil, "There is no data available")
                    }
                    
                    
                } else {
                    
                    completion(nil, "Something wrong with data provided")
                }
            } else {
                completion(nil, "Failed to retrieved data")
            }
        }
    }
}

//"status": 1,
//"data": [
//{
//"user_id": "63649",
//"score": "42300",
//"user": {
//"id": "63649",
//"fb_id": null,
//"fb_token": null,
//"ic_no": "050417030770",
//"dob": "2005-04-17",
//"gender_id": "2",
//"occupation_id": "113",
//"email": "",
//"full_name": "PUTERI AYU NURAIN SAIPUL BAHRI",
//"verified": "1",
//"email_verified": "1",
//"event_verified": "0",
//"phone": "0",
//"app_name": "1",
//"is_admin": "0",
//"is_volunteer": "0",
//"site_id": "116",
//"poster_group_id": null,
//"poster_group_ownership": "member",
//"remember_token": "yHyzg5BIrIri2vY6knN2jBQu5r4gfxm0pvKitLVTwfQgNKrWC6EKS1iuxcqE",
//"created_at": "2015-11-30 09:43:43",
//"updated_at": "2017-07-09 15:27:19",
//"site": {
//"id": "116",
//"region_id": "3",
//"address": "Mengkebang"
//}
//}
//}





















