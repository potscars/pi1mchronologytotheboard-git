//
//  Location.swift
//  dashboardv2
//
//  Created by Hainizam on 16/08/2017.
//  Copyright © 2017 Ingeniworks Sdn Bhd. All rights reserved.
//

import Foundation

class Location {
    
    var title: String?
    var id: Int?
    
    init() { }
    
    init(_ id: Int, title: String) {
        
        self.id = id
        self.title = title
    }
    
    typealias locationTitleHandler = ([Location]?) -> ()
    
    func fetchAllLocationTitle(_ completion: @escaping locationTitleHandler) {
        
        var id: Int!
        var title: String!
        
        var locationList = [Location]()
        
        let urlString = "http://myplace.myapp.my/map/listAllLocation"
        let networkProcessor = NetworkProcessor.init(urlString)
        
        networkProcessor.downloadJSONFromUrl { (result, responses) in
            
            guard responses == nil else {
                completion(nil)
                return;
            }
            
            if let data = result as? NSArray {
                
                guard data.count > 0 else {
                    completion(nil)
                    return
                }
                
                for item in data {
                    
                    if let idResult = (item as AnyObject).value(forKey: "id") as? Int {
                        id = idResult
                    }
                    
                    if let titleResult = (item as AnyObject).value(forKey: "title") as? String {
                        title = titleResult
                    }
                    
                    locationList.append(Location.init(id, title: title))
                }
                
                completion(locationList)
            } else {
                completion(nil)
            }
        }

    }
}
