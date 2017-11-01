//
//  ZNetwork.swift
//  dashboardv2
//
//  Created by Mohd Zulhilmi Mohd Zain on 05/01/2017.
//  Copyright © 2017 Ingeniworks Sdn Bhd. All rights reserved.
//

import UIKit
import SystemConfiguration

class ZNetwork: NSObject {
    
    static let ContentTypeFormData: String = "form-data"
    static let ContentTypeXWWWFormUrlEncoded: String = "x-www-form-urlencoded"
    static let ContentTypeRaw: String = "raw"
    static let ContentTypeBinary: String = "binary"
    static let ContentTypeJSON: String = "json"
    
    /** 
     
     Checking the connection to network
     Memeriksa sambungan ke rangkaian
     
     */
    
    static func isConnectedToNetwork() -> Bool {
        
        var zeroAddress = sockaddr_in()
        zeroAddress.sin_len = UInt8(MemoryLayout.size(ofValue: zeroAddress))
        zeroAddress.sin_family = sa_family_t(AF_INET)
        let defaultRouteReachability = withUnsafePointer(to: &zeroAddress) {
            $0.withMemoryRebound(to: sockaddr.self, capacity: 1) {zeroSockAddress in
                SCNetworkReachabilityCreateWithAddress(nil, zeroSockAddress)
            }
        }
        var flags = SCNetworkReachabilityFlags()
        if !SCNetworkReachabilityGetFlags(defaultRouteReachability!,  &flags) {
            return false
        }
        let isReachable = (flags.rawValue & UInt32(kSCNetworkFlagsReachable)) != 0
        let needsConnection = (flags.rawValue & UInt32(kSCNetworkFlagsConnectionRequired)) != 0
        
        return (isReachable && !needsConnection)
        
    }
    
    static func performGetData(urlWithParameters: NSURL, notificationName: String?) -> NSDictionary {
        
        var dataResponded: NSDictionary = [:]
        
        let requestData = NSMutableURLRequest.init(url: urlWithParameters as URL, cachePolicy:NSURLRequest.CachePolicy.useProtocolCachePolicy , timeoutInterval: 60.0)
        requestData.httpMethod = "GET"
        requestData.addValue("application/x-www-form-urlencoded", forHTTPHeaderField: "Content-Type")
        
        let task = URLSession.shared.dataTask(with: requestData as URLRequest, completionHandler: { (retrievedData: Data?,response: URLResponse?,error: Error?) -> Void in
            
            print("[ZNetwork] Response got: ",response ?? "")
            
            if let retrievedData = retrievedData {
                
                do {
                    
                    if let getDataFromJSON = try JSONSerialization.jsonObject(with: retrievedData, options: JSONSerialization.ReadingOptions.mutableContainers) as? NSDictionary {
                        
                        print("[DBWebServices] Data got (as NSDictionary): ",getDataFromJSON)
                        
                        DispatchQueue.global(qos: DispatchQoS.QoSClass.default).async {
                            
                            if notificationName != nil { NotificationCenter.default.post(name: Notification.Name(notificationName!), object: getDataFromJSON) }
                            
                        }
                        
                        dataResponded = ["GET_RESPONDED" : true, "ERROR_CATCH" : ""]
                        
                    }
                    else if let getDataFromJSON = try JSONSerialization.jsonObject(with: retrievedData, options: JSONSerialization.ReadingOptions.mutableContainers) as? NSArray {
                        
                        print("[DBWebServices] Data got (as NSMutableArray): ",getDataFromJSON)
                        
                        DispatchQueue.global(qos: DispatchQoS.QoSClass.default).async {
                            
                            if notificationName != nil { NotificationCenter.default.post(name: Notification.Name(notificationName!), object: getDataFromJSON) }
                            
                        }
                        
                        dataResponded = ["GET_RESPONDED" : true, "ERROR_CATCH" : ""]
                        
                    }
                    else if let error = error {
                        
                        print("[ZNetwork] Object retrieval error: \(error)")
                        
                        dataResponded = ["GET_RESPONDED" : false, "ERROR_CATCH" : error.localizedDescription]
                    }
                    
                }
                catch let error as NSError {
                    
                    print("[ZNetwork] Error while retrieve data ",error)
                    
                    dataResponded = ["GET_RESPONDED" : false, "ERROR_CATCH" : error.localizedDescription]
                    
                    if notificationName != nil { NotificationCenter.default.post(name: Notification.Name(notificationName!), object: dataResponded) }
                    
                    
                }
            }
            else if let error = error {
                print("[ZNetwork] Error while retrieve data ",error)
                
                dataResponded = ["GET_RESPONDED" : false, "ERROR_CATCH" : error.localizedDescription]
                
                if notificationName != nil { NotificationCenter.default.post(name: Notification.Name(notificationName!), object: dataResponded) }
            }
        })
        
        task.resume()
        
        return dataResponded
    }
    
    static func performPostData(url: NSURL, parameters: String, contentType: String, includeContentLength: Bool, notificationName: String?) -> NSDictionary {
        
        var dataResponded: NSDictionary = [:]
        
        let getPostLength = String(format:"%lu",parameters.characters.count)
        
        let setPostData: Data? = parameters.data(using: .ascii, allowLossyConversion: true)
        
        let requestData = NSMutableURLRequest.init(url: url as URL, cachePolicy:URLRequest.CachePolicy.useProtocolCachePolicy , timeoutInterval: 60.0)
        requestData.httpMethod = "POST"
        requestData.addValue("application/\(contentType)", forHTTPHeaderField: "Content-Type")
        
        if(includeContentLength == true) {
            
            requestData.addValue(getPostLength, forHTTPHeaderField: "Content-Length")
        }
        
        requestData.httpBody = setPostData
        
        let setUrlSession: URLSession = URLSession.shared
        let setSessionDataTask = setUrlSession.dataTask(with: requestData as URLRequest, completionHandler: {
            (data, response, error) -> Void in
            
            //print("[ZNetwork] GetLoginData: Response is \(response)")
            
            if let data = data {
                
                do {
                    
                    if let getDataFromJSON = try JSONSerialization.jsonObject(with: data, options:JSONSerialization.ReadingOptions.mutableContainers) as? NSDictionary {
                        
                        print("[ZNetwork] Data retrieved in NSDictionary: \(getDataFromJSON)")
                        
                        DispatchQueue.global(qos: DispatchQoS.QoSClass.default).async {
                            
                            if notificationName != nil { NotificationCenter.default.post(name: Notification.Name(notificationName!), object: getDataFromJSON) }
                            
                        }
                        
                        dataResponded = ["GET_RESPONDED" : true, "ERROR_CATCH" : ""]
                        
                    }
                    else if let getDataFromJSON = try JSONSerialization.jsonObject(with: data, options:JSONSerialization.ReadingOptions.mutableContainers) as? NSArray {
                        
                        print("[ZNetwork] Data retrieved in NSArray: \(getDataFromJSON)")
                        
                        DispatchQueue.global(qos: DispatchQoS.QoSClass.default).async {
                            
                            if notificationName != nil { NotificationCenter.default.post(name: Notification.Name(notificationName!), object: getDataFromJSON) }
                            
                        }
                        
                        dataResponded = ["GET_RESPONDED" : true, "ERROR_CATCH" : ""]
                        
                    }
                    else if let error = error {
                        
                        print("[ZNetwork] Object retrieval error: \(error)")
                        
                        dataResponded = ["GET_RESPONDED" : false, "ERROR_CATCH" : error.localizedDescription]
                    }
                }
                catch let error {
                    
                    print("[ZNetwork] Error while do converting JSON: \(error)")
                    
                    dataResponded = ["GET_RESPONDED" : false, "ERROR_CATCH" : error.localizedDescription]
                    
                    if notificationName != nil { NotificationCenter.default.post(name: Notification.Name(notificationName!), object: dataResponded) }
                }
            }
            else if let error = error {
                
                print("[ZNetwork] Error while passing data: \(error)")
                
                dataResponded = ["GET_RESPONDED" : false, "ERROR_CATCH" : error.localizedDescription]
            }
        })
        setSessionDataTask.resume()
        
        return dataResponded
    }
    
    static func performPostRequest(url: URL, params: [String: Any], completion: @escaping (NSDictionary) -> Void ) {
        
        var request = URLRequest(url: url as URL)
        request.httpMethod = "POST"
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        
        if let jsonParams = try? JSONSerialization.data(withJSONObject: params) {
            request.httpBody = jsonParams
        }
        
        let session = URLSession.shared
        
        let task = session.dataTask(with: request) { (data, response, error) in
            
            guard error == nil else { return }
            
            guard let responseData = data else { return }
            
            do {
                
                let responseJson = try JSONSerialization.jsonObject(with: responseData, options: .mutableContainers) as! NSDictionary
                
                completion(responseJson)
                
            } catch let error {
                
                print(error.localizedDescription)
            }
        }
        
        task.resume()
    }
    
    static func performPostDictionaryObject(url: NSURL, parameters: NSDictionary, contentType: String, notificationName: String?) -> NSDictionary {
        
        var dataResponded: NSDictionary = [:]
        
        let requestData = NSMutableURLRequest.init(url: url as URL, cachePolicy:URLRequest.CachePolicy.useProtocolCachePolicy , timeoutInterval: 60.0)
        requestData.httpMethod = "POST"
        requestData.addValue("application/\(contentType)", forHTTPHeaderField: "Content-Type")
        
        do {
            
            requestData.httpBody = try JSONSerialization.data(withJSONObject: parameters, options: .prettyPrinted)
            
            let setUrlSession: URLSession = URLSession.shared
            let setSessionDataTask = setUrlSession.dataTask(with: requestData as URLRequest, completionHandler: {
                (data, response, error) -> Void in
                
                print("[ZNetwork] Response is \(response!)")
                
                if let data = data {
                    
                    do {
                        
                        if let getDataFromJSON = try JSONSerialization.jsonObject(with: data, options:JSONSerialization.ReadingOptions.mutableContainers) as? NSDictionary {
                            
                            print("[ZNetwork] Data retrieved in NSDictionary: \(getDataFromJSON)")
                            
                            DispatchQueue.global(qos: DispatchQoS.QoSClass.default).async {
                                
                                if notificationName != nil { NotificationCenter.default.post(name: Notification.Name(notificationName!), object: getDataFromJSON) }
                                
                            }
                            
                            dataResponded = ["GET_RESPONDED" : true, "ERROR_CATCH" : ""]
                            
                        }
                        else if let getDataFromJSON = try JSONSerialization.jsonObject(with: data, options:JSONSerialization.ReadingOptions.mutableContainers) as? NSArray {
                            
                            print("[ZNetwork] Data retrieved in NSArray: \(getDataFromJSON)")
                            
                            DispatchQueue.global(qos: DispatchQoS.QoSClass.default).async {
                                
                                if notificationName != nil { NotificationCenter.default.post(name: Notification.Name(notificationName!), object: getDataFromJSON) }
                                
                            }
                            
                            dataResponded = ["GET_RESPONDED" : true, "ERROR_CATCH" : ""]
                            
                        }
                        else if let error = error {
                            
                            print("[ZNetwork] Object retrieval error: \(error.localizedDescription)")
                            
                            dataResponded = ["GET_RESPONDED" : false, "ERROR_CATCH" : error.localizedDescription]
                        }
                    }
                    catch let error {
                        
                        print("[ZNetwork] Error while do converting JSON: \(error.localizedDescription)")
                        
                        dataResponded = ["GET_RESPONDED" : false, "ERROR_CATCH" : error.localizedDescription]
                        
                        if notificationName != nil { NotificationCenter.default.post(name: Notification.Name(notificationName!), object: dataResponded) }
                    }
                }
                else if let error = error {
                    
                    print("[ZNetwork] Error while passing data: \(error.localizedDescription)")
                    
                    dataResponded = ["GET_RESPONDED" : false, "ERROR_CATCH" : error.localizedDescription]
                }
            })
            setSessionDataTask.resume()
            
            
        } catch {
            
            print("[ZNetwork] Error occured while verifying JSON object: \(error.localizedDescription)")
            dataResponded = ["GET_RESPONDED" : false, "ERROR_CATCH" : error.localizedDescription]
            
        }
        
        return dataResponded
    }

}























