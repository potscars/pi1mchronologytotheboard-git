//
//  File.swift
//  dashboardv2
//
//  Created by Hainizam on 10/08/2017.
//  Copyright © 2017 Ingeniworks Sdn Bhd. All rights reserved.
//

import Foundation
import UIKit

class Catergory {
    
    var id: Int?
    var name: String?
    var nameInMalay: String?
    var tableVC: UITableViewController!
    
    init(id: Int?, name: String?, nameInMalay: String?) {
        
        self.id = id
        self.name = name
        self.nameInMalay = nameInMalay
    }
    
    init(_ tableVC: UITableViewController) {
        
        self.tableVC = tableVC
    }
    
    typealias catergoryHandler = ([Catergory]?) -> ()
    
    func fetchCategory(_ completion: @escaping catergoryHandler){
        
        var id: Int!
        var name: String!
        var nameInMalay: String!
        
        var categoryList = [Catergory]()
        
        let urlString = "http://myplace.myapp.my//api/type/lists"
        let networkProcessor = NetworkProcessor.init(urlString)
        
        networkProcessor.getRequestJSONFromUrl { (result, responses) in
            
            guard responses == nil else {
                
                completion(nil)
                return
            }
            
            if let data = result as? NSArray {
                
                for item in data {
                    
                    if let idResult = (item as AnyObject).value(forKey: "id") as? Int {
                        id = idResult
                    }
                    
                    if let nameResult = (item as AnyObject).value(forKey: "name") as? String {
                        name = nameResult
                    }
                    
                    if let nameInMalayResult = (item as AnyObject).value(forKey: "name_bm") as? String {
                        nameInMalay = nameInMalayResult
                    }
                    
                    categoryList.append(Catergory.init(id: id, name: name, nameInMalay: nameInMalay))
                }
                completion(categoryList)
            }
        }
    }
}






























