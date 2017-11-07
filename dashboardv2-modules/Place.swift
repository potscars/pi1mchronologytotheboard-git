//
//  Place.swift
//  dashboardv2
//
//  Created by Hainizam on 16/08/2017.
//  Copyright © 2017 Ingeniworks Sdn Bhd. All rights reserved.
//

import Foundation

class Place {
    
    var nextPage: String?
    var id: Int?
    var title: String?
    var content: String?
    var postcode: String?
    var street: String?
    var city: String?
    var viewerCount: String?
    var latitude: String?
    var longitude: String?
    var createdAt: String?
    var categoryName: [String]?
    var iconPath: [String]?
    
    init(_ id: Int, title: String, content: String, postcode: String, street: String, city: String, viewerCount: String, latitude: String, longitude: String, createdAt: String, categoryName: [String], iconPath: [String]) {
    
        self.id = id
        self.title = title
        self.content = content
        self.postcode = postcode
        self.street = street
        self.city = city
        self.viewerCount = viewerCount
        self.latitude = latitude
        self.longitude = longitude
        self.createdAt = createdAt
        self.categoryName = categoryName
        self.iconPath = iconPath
    }
    
    init() {
        
    }
    
    typealias PlaceHandler = ([Place]?, String?) -> ()
    
    func fetchPlace(_ keyword : String, completion: @escaping PlaceHandler) {
        
        var idTemp: Int = 9999
        var titleTemp: String = "N/A"
        var contentTemp: String = "N/A"
        var postcodeTemp: String = "N/A"
        var streetTemp: String = "N/A"
        var cityTemp: String = "N/A"
        var viewerCountTemp: String = "N/A"
        var latitudeTemp: String = "N/A"
        var longitudeTemp: String = "N/A"
        var createdAtTemp: String = "N/A"
        var categoryNameTemp = [String]()
        var iconPathTemp = [String]()
        
        var placeList = [Place]()
        
        let urlString = "http://myplace.myapp.my/api/search/\(keyword)"
        let networkProcessor = NetworkProcessor.init(urlString)
        
        networkProcessor.getRequestJSONFromUrl { (result, responses) in
            
            guard responses == nil else {
                
                completion(nil, responses)
                return;
            }
            
            guard let dataResult = result as? NSDictionary else {
                print("No data")
                completion(nil, "There is no data available!")
                return
            }
            
            guard let status = dataResult.value(forKey: "status") as? Int, status == 1 else {
                print("Failed!")
                completion(nil, "Failed to get data!")
                return
            }
            
            if let data = dataResult.value(forKey: "data") as? NSDictionary, let dataArray = data.value(forKey: "data") as? NSArray {
                
                guard dataArray.count > 0 else {
                    completion(nil, "There is no result related to \"\(keyword)\"")
                    return
                }
                
                for place in dataArray {
                    
                    if let idResult = (place as AnyObject).value(forKey: "id") as? Int {
                        idTemp = idResult
                    }
                    
                    if let titleResult = (place as AnyObject).value(forKey: "title") as? String {
                        titleTemp = titleResult
                    }
                    
                    if let contentResult = (place as AnyObject).value(forKey: "content") as? String {
                        contentTemp = contentResult
                    }
                    
                    if let postcodeResult = (place as AnyObject).value(forKey: "postcode") as? String {
                        postcodeTemp = postcodeResult
                    }
                    
                    if let streetResult = (place as AnyObject).value(forKey: "street") as? String {
                        streetTemp = streetResult
                    }
                    
                    if let cityResult = (place as AnyObject).value(forKey: "city") as? String {
                        cityTemp = cityResult
                    }
                    
                    if let viewerCountResult = (place as AnyObject).value(forKey: "viewer_count") as? String {
                        viewerCountTemp = viewerCountResult
                    }
                    
                    if let latResult = (place as AnyObject).value(forKey: "lat") as? String {
                        latitudeTemp = latResult
                    }
                    
                    if let longResult = (place as AnyObject).value(forKey: "lng") as? String {
                        longitudeTemp = longResult
                    }
                    
                    if let createdAtResult = (place as AnyObject).value(forKey: "created_at") as? String {
                        createdAtTemp = createdAtResult
                    }
                    
                    if let category = (place as AnyObject).value(forKey: "types") as? NSArray {
                        
                        for cat in category {
                            
                            if let catName = (cat as AnyObject).value(forKey: "name") as? String {
                                categoryNameTemp.append(catName)
                            }
                            if let icon = (cat as AnyObject).value(forKey: "icon_path") as? String {
                                iconPathTemp.append(icon)
                            }
                        }
                    }
                    
                    placeList.append(Place.init(idTemp, title: titleTemp, content: contentTemp, postcode: postcodeTemp, street: streetTemp, city: cityTemp, viewerCount: viewerCountTemp, latitude: latitudeTemp, longitude: longitudeTemp, createdAt: createdAtTemp, categoryName: categoryNameTemp, iconPath: iconPathTemp))
                }
                
                completion(placeList, nil)
            } else {
                completion(nil, "There is no result related to \"\(keyword)\"")
            }
        }
    }
}


//"data": [
//{
//"id": 18,
//"user_id": null,
//"title": "Pusat Internet 1Malaysia Felda Jengka 22",
//"content": "Pusat Internet 1Malaysia Felda Jengka 22, Bgn IKS Felda Jengka 22, 26400 Bandar Pusat Jengka, Pahang",
//"postcode": "",
//"street": "",
//"city": "Jengka 22",
//"state_id": "10",
//"viewer_count": "0",
//"confirm": "0",
//"lat": "3.89528",
//"lng": "102.671",
//"created_at": "2016-09-07 04:16:28",
//"updated_at": "2016-09-07 04:16:28",
//"deleted_at": "-0001-11-30 00:00:00",
//"state": {
//"id": 10,
//"name": "Pahang"
//},
//"types": [
//{
//"id": 4,
//"name": "Pi1M",
//"name_bm": "PI1M",
//"label": "pi1m",
//"icon_path": "img/pi1m.png",
//"pivot": {
//"location_id": "18",
//"type_id": "4"
//}
//}
//]
//}
