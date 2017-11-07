//
//  State.swift
//  dashboardv2
//
//  Created by Hainizam on 11/08/2017.
//  Copyright © 2017 Ingeniworks Sdn Bhd. All rights reserved.
//

import Foundation
import UIKit

class State {
    
    var id: Int?
    var name: String?
    var tableVC: UITableViewController!
    
    
    init(id: Int?, name: String?) {
        
        self.id = id
        self.name = name
    }
    
    init(_ tableVC: UITableViewController) {
        self.tableVC = tableVC
    }
    
    typealias stateHandler = ([State]?) -> ()
    
    func fetchState(_ completion: @escaping stateHandler){
        
        var id: Int!
        var name: String!
        
        var stateList = [State]()
        
        let urlString = "http://myplace.myapp.my//api/state/lists"
        let networkProcessor = NetworkProcessor.init(urlString)
        
        networkProcessor.downloadJSONFromUrl { (result, responses) in
            
            guard responses == nil else {
                
                completion(nil)
                return;
            }
            
            if let data = result as? NSArray {
                
                for item in data {
                    
                    if let idResult = (item as AnyObject).value(forKey: "id") as? Int {
                        id = idResult
                    }
                    
                    if let nameResult = (item as AnyObject).value(forKey: "name") as? String {
                        name = nameResult
                    }
                    
                    stateList.append(State.init(id: id, name: name))
                }
                
                completion(stateList)
            }
        }
    }
}














