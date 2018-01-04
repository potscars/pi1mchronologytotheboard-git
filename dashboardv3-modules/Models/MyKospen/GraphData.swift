//
//  GraphData.swift
//  dashboardv2
//
//  Created by Hainizam on 20/12/2017.
//  Copyright © 2017 Ingeniworks Sdn Bhd. All rights reserved.
//

import UIKit

class GraphData {
    
    //bmi
    var weight: CGFloat?
    var bmi: CGFloat?
    var createdDate: String?
    
    //bloodpressure
    var glucoseLevel: CGFloat?
    
    //bloodsugarlevel
    var sys: Int?
    var dys: Int?
    
    //options type
    var type: String = "wt"
    
    //guna untuk initial declare class ni.
    init(_ type: String) {
        self.type = type
    }
    
    //wt
    init(_ weight: CGFloat, bmi: CGFloat, createdDate: String) {
        
        self.weight = weight
        self.bmi = bmi
        self.createdDate = createdDate
    }
    
    //bp
    init(_ glucoseLevel: CGFloat, createdDate: String) {
        
        self.glucoseLevel = glucoseLevel
        self.createdDate = createdDate
    }
    
    //glu
    init(_ sys: Int, dys: Int, createdDate: String) {
        
        self.sys = sys
        self.dys = dys
        self.createdDate = createdDate
    }
    
    func fetchData(completion: @escaping (([GraphData]?) -> ())) {
        
        let urlString = DBSettings.kospenGrapghDetailsURL
        let params: [String : Any] = ["type": type,
                      "myhealth_id": 205,
                      "count": 10]
        
        let np = NetworkProcessor.init(urlString)
        var graphData = [GraphData]()
        
        np.postRequestJSONFromUrl(params) { (result, response) in
            
            guard response == nil else { return }
            
            guard let result = result else { return }
            
            if let status = result["status"] as? Int, status == 1 {
                
                if let datas = result["data"] as? NSArray {
                    
                    var weightTemp: CGFloat = 0.0
                    var bmiTemp: CGFloat = 0.0
                    var dateTemp = "-"
                    var glucoseTemp: CGFloat = 0.0
                    var sysTemp = 0
                    var dysTemp = 0
                    
                    for data in datas {
                        
                        if let hWeight = (data as AnyObject).object(forKey: "weight") as? CGFloat {
                            weightTemp = hWeight
                        }
                        
                        if let hBMI = (data as AnyObject).object(forKey: "bmi") as? CGFloat {
                            bmiTemp = hBMI
                        }
                        
                        if let hDate = (data as AnyObject).object(forKey: "created_at") as? String {
                            dateTemp = hDate
                        }
                        
                        if let hGlucose = (data as AnyObject).object(forKey: "glucose_level") as? CGFloat {
                            glucoseTemp = hGlucose
                        }
                        
                        if let hSys = (data as AnyObject).object(forKey: "sys") as? Int {
                            sysTemp = hSys
                        }
                        
                        if let hDys = (data as AnyObject).object(forKey: "dys") as? Int {
                            dysTemp = hDys
                        }
                        
                        if self.type == "wt" {
                            graphData.append(GraphData.init(weightTemp, bmi: bmiTemp, createdDate: dateTemp))
                        } else if self.type == "glu" {
                            graphData.append(GraphData.init(glucoseTemp, createdDate: dateTemp))
                        } else {
                            graphData.append(GraphData.init(sysTemp, dys: dysTemp, createdDate: dateTemp))
                        }
                    }
                    
                    completion(graphData)
                } else {
                    completion(graphData)
                }
                
            } else {
                //status 0
            }
        }
    }
}











