//
//  NetworkProcessor.swift
//  BicaraPakarApp
//
//  Created by Hainizam on 04/08/2017.
//  Copyright © 2017 com.ingeniworks. All rights reserved.
//

import Foundation
import UIKit

class NetworkProcessor {
    
    struct HttpResponsesCode {
        
        static let Success = 200
        static let BadRequest = 400
        static let NotFound = 404
        static let RequestTimeout = 408
        static let InternalServerError = 500
    }
    
    //Letak as lazy sebab bila nak guna baru execute.
    lazy var configuration: URLSessionConfiguration = URLSessionConfiguration.default
    lazy var session: URLSession = URLSession(configuration: self.configuration)
    
    typealias JSONDictionaryHandler = ([String: Any]?, String?) -> ()
    typealias JSONDataHandler = (Any?, String?) -> ()
    
    var url: URL
    
    init(_ urlString: String) {
        
        url = URL(string: urlString)!
    }
    
    //MARK: - Getting data from database.
    
    func getRequestJSONFromUrl(_ completion: @escaping JSONDataHandler) {
        
        var request = URLRequest(url: url)
        request.httpMethod = "GET"
        
        let task = session.dataTask(with: request) { (data, response, error) in
            
            guard error == nil else { completion(nil, error?.localizedDescription); return }
            
            if let httpResponse = response as? HTTPURLResponse {
                
                if httpResponse.statusCode == HttpResponsesCode.Success {
                    
                    let httpResponsesString = self.checkResponseStatusCode(httpResponse.statusCode)
                    
                    if let data = data {
                        
                        let jsonData = try? JSONSerialization.jsonObject(with: data, options: .mutableContainers)
                        
                        completion(jsonData, nil)
                    } else {
                        completion(nil, httpResponsesString)
                    }
                    
                }
            } else {
                completion(nil, "There is no http responses.")
            }
        }
        
        task.resume()
    }
    
    //MARK: - Setting data to database with json data as parameters
    
    func postRequestJSONFromUrl(_ params: [String: Any], completion: @escaping JSONDictionaryHandler) {
        
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        
        do {
            
            request.httpBody = try JSONSerialization.data(withJSONObject: params, options: [])
        } catch let error {
            
            print(error.localizedDescription)
            return
        }
        
        
        let task = session.dataTask(with: request) { (data, response, error) in
            
            guard error == nil else { completion(nil, error?.localizedDescription); return }
            
            if let httpResponse = response as? HTTPURLResponse {
                
                if httpResponse.statusCode == HttpResponsesCode.Success {
                    
                    let httpResponsesString = self.checkResponseStatusCode(httpResponse.statusCode)
                    
                    if let data = data {
                        
                        let jsonData = try? JSONSerialization.jsonObject(with: data, options: .mutableContainers) as! [String: Any]
                        
                        completion(jsonData, nil)
                    } else {
                        completion(nil, httpResponsesString)
                    }
                    
                }
            } else {
                completion(nil, "There is no http responses.")
            }
        }
        
        task.resume()
    }
    
    //MARK: - UPLOAD with image(s) using multipart.
    func uploadDataMultipart(_ params: [String: Any], images: [UIImage], completion: @escaping JSONDictionaryHandler) {
        
        var imageDataList = [Data]()
        let boundary = generateBoundaryString()
        
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.setValue("multipart/form-data; boundary=\(boundary)", forHTTPHeaderField: "Content-Type")
        
        for image in images {
            
            guard let imageData = UIImageJPEGRepresentation(image, 0.8) else { return; }
            imageDataList.append(imageData)
        }
        
        request.httpBody = createBodyWithParameters(params, filePathKey: "img", imagesData: imageDataList, boundary: boundary)

        let task = session.dataTask(with: request) { (data, response, error) in
            
            guard error == nil else { completion(nil, error?.localizedDescription); return }
            
            if let httpResponse = response as? HTTPURLResponse {
                
                if httpResponse.statusCode == HttpResponsesCode.Success {
                    
                    let httpResponsesString = self.checkResponseStatusCode(httpResponse.statusCode)
                    
                    if let data = data {
                        
                        let jsonData = try? JSONSerialization.jsonObject(with: data, options: .mutableContainers) as! [String: Any]
                        
                        completion(jsonData, nil)
                    } else {
                        completion(nil, httpResponsesString)
                    }
                    
                }
            } else {
                completion(nil, "There is no http responses.")
            }
        }
        
        task.resume()
    }
    
    func createBodyWithParameters(_ parameters: [String: Any]?, filePathKey: String, imagesData: [Data], boundary: String) -> Data {
        var body = Data();
        
        if parameters != nil {
            for (key, value) in parameters! {
                if key == "token" {
                    body.appendString("--\(boundary)\r\n")
                    body.appendString("Content-Disposition: form-data; name=\"\(key)\"\r\n\r\n")
                    body.appendString("\(value)\r\n")
                } else if key == "location" {

                    if let dictValue = value as? NSDictionary {
                        
                        for (locationKey, locationValue) in dictValue {
                            
                            let locationKeyString = locationKey as! String
                            let locationDictKey = "\(key)[\(locationKeyString)]"
                            print("\(locationDictKey),\(locationValue)")
                            if locationKeyString == "category" {
                                
                                if let dictLocationValue = locationValue as? NSDictionary {
                                    for (categoryKey, categoryValue) in dictLocationValue {
                                        
                                        let locationCategoryKey = "\(locationDictKey)[\(categoryKey)]"
                                        print("\(locationCategoryKey),\(categoryValue)")
                                        body.appendString("--\(boundary)\r\n")
                                        body.appendString("Content-Disposition: form-data; name=\"\(locationCategoryKey)\"\r\n\r\n")
                                        body.appendString("\(categoryValue)\r\n")
                                    }
                                }
                            } else {
                                
                                body.appendString("--\(boundary)\r\n")
                                body.appendString("Content-Disposition: form-data; name=\"\(locationDictKey)\"\r\n\r\n")
                                body.appendString("\(locationValue)\r\n")
                            }
                        }
                    }
                }
            }
        }
        
        let filename = "images"
        
        let mimetype = "image/jpg"
        
        var nameCount = 0
        
        for imageData in imagesData {
            
            let filePathName = "\(filePathKey)[\(nameCount)]"
            print("Filename = \(filePathName)")
            
            body.appendString("--\(boundary)\r\n")
            body.appendString("Content-Disposition: form-data; name=\"\(filePathName)\"; filename=\"\(filename)\(nameCount).jpg\"\r\n")
            body.appendString("Content-Type: \(mimetype)\r\n\r\n")
            body.append(imageData)
            body.appendString("\r\n")
            
            nameCount += 1
        }
        
        body.appendString("--\(boundary)--\r\n")
        
        return body
    }
    
    private func generateBoundaryString() -> String {
        return "Boundary-\(NSUUID().uuidString)"
    }
    
    //MARK: - Check the http response status code
    
    func checkResponseStatusCode(_ statusCode: Int) -> String{
        
        switch statusCode {
            
        case HttpResponsesCode.Success:
            //Success
            return "\(HttpResponsesCode.Success): Success"
        case HttpResponsesCode.BadRequest:
            //Bad Request
            return "\(HttpResponsesCode.BadRequest): Bad Request!"
        case HttpResponsesCode.NotFound:
            //Server not found
            return "\(HttpResponsesCode.NotFound): Not Found"
        case HttpResponsesCode.RequestTimeout:
            //Request timeout
            return "\(HttpResponsesCode.RequestTimeout): Request Timeout"
        case HttpResponsesCode.InternalServerError:
            return "\(HttpResponsesCode.InternalServerError): Internal Server Error"
        default:
            return "\(statusCode): Error"
        }
    }
    
}

extension Data {
    
    mutating func appendString(_ string: String) {
        let data = string.data(using: String.Encoding.utf8, allowLossyConversion: true)
        append(data!)
    }
}






















