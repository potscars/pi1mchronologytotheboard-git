//
//  LocationLatLong.swift
//  dashboardv2
//
//  Created by Hainizam on 08/02/2018.
//  Copyright © 2018 Ingeniworks Sdn Bhd. All rights reserved.
//

import Foundation
import UIKit

struct LocateLatLong: Codable {
    
    let status: Int
    let data: [LocateData]
}

struct LocateData: Codable {
    
    let id: Int
    let title: String
    let content: String?
    let lat: String
    let lng: String
    let types: [LocateType]
}

struct LocateType: Codable {
    
    let name: String
    let icon_path: String
}

class LocationLatLong {
    
    typealias LatLongCompletion = (LocateLatLong?, String?) -> ()
    
    static func fetchData(withLat lat: Double, withLong long: Double, completion: @escaping LatLongCompletion) {
        
        let urlString = "\(DBSettings.myPlaceSearchLocationLatLongURL)\(lat)/\(long)"
        guard let url = URL(string: urlString) else { return }
        
        let session = URLSession.shared
        var request = URLRequest(url: url)
        request.httpMethod = "GET"
        
        session.dataTask(with: request) { (data, response, error) in
            
            guard error == nil else {
                completion(nil, error?.localizedDescription)
                return
            }
            guard let data = data else { return }
            
            do {
                
                let jsonData = try JSONDecoder().decode(LocateLatLong.self, from: data)
                
                if jsonData.status == 1 {
                    completion(jsonData, nil)
                } else {
                    completion(nil, "Failed to get data.")
                }
                
            } catch let err {
                print(err)
                completion(nil, err.localizedDescription)
            }
            
        }.resume()
    }
}







