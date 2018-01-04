//
//  Disease.swift
//  dashboardv2
//
//  Created by Hainizam on 02/01/2018.
//  Copyright © 2018 Ingeniworks Sdn Bhd. All rights reserved.
//

import UIKit

class Disease {
    
    var id: Int?
    var name: String?
    var slug: String?
    
    init() { }
    
    init(_ id: Int, name: String, slug: String) {
        
        self.id = id
        self.name = name
        self.slug = slug
    }
    
    func fetchDiseasesData(completion: @escaping ([Disease]?, String?)->()) {
        
        let urlString = DBSettings.kospenDiseaseListURL
        
        let np = NetworkProcessor.init(urlString)
        var diseases = [Disease]()
        
        np.postRequestJSONFromUrl { (result, response) in
            
            guard response == nil else {
                completion(nil, response ?? "ERROR")
                return
            }
            
            guard let result = result else { return }
            
            if let status = result["status"] as? Int, status == 1 {
                
                if let datas = result["data"] as? NSArray {
                    
                    var hID = 0
                    var hName = "Not Available"
                    var hSlug = "Not Available"
                    
                    for data in datas {
                        
                        if let id = (data as AnyObject).object(forKey: "id") as? Int {
                            hID = id
                        }
                        
                        if let name = (data as AnyObject).object(forKey: "name") as? String {
                            hName = name
                        }
                        
                        if let slug = (data as AnyObject).object(forKey: "slug") as? String {
                            hSlug = slug
                        }
                        
                        diseases.append(Disease.init(hID, name: hName, slug: hSlug))
                    }
                    
                    completion(diseases, nil)
                }
            } else {
                completion(nil, "Failed: Status 0")
            }
        }
    }
}
















