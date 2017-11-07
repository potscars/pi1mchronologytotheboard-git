//
//  ZImages.swift
//  dashboardv2
//
//  Created by Mohd Zulhilmi Mohd Zain on 03/02/2017.
//  Copyright © 2017 Ingeniworks Sdn Bhd. All rights reserved.
//

import UIKit

class ZImages: NSObject {

    static func getImageFromUrlAsync(fromURL: String?, defaultImage: UIImage?) -> UIImage? {
        
        if(fromURL != nil)
        {
            print("[ZImages] fromURL: \(fromURL!)")
            
            let imageURL: URL = URL.init(string: fromURL!.addingPercentEncoding(withAllowedCharacters: CharacterSet.urlQueryAllowed)!)!
            var imageReturn: UIImage? = nil
            
            print("[ZImages] ImageURL: \(imageURL)")
        
            DispatchQueue.global(qos: .default).async() { () -> Void in
            
                print("[ZImages] Dispatching queue in global...")
                
                let data: NSData? = NSData.init(contentsOf: imageURL)
                
                print("[ZImages] Data: \(String(describing: data))")
            
                DispatchQueue.main.async() { () -> Void in
            
                    imageReturn = UIImage.init(data: data! as Data)

                }
            }
        
            return imageReturn!
        }
        else {
            
            return nil
        }
    }
    
    static func getImageFromUrlSession(fromURL: String, defaultImage: String) -> UIImage {
        
        let imageURL: URL = URL.init(string: fromURL.addingPercentEncoding(withAllowedCharacters: CharacterSet.urlQueryAllowed)!)!
        let session = URLSession(configuration: URLSessionConfiguration.default)
        var imageReturn: UIImage = UIImage.init(named: defaultImage)!
            
        let downloadPicTask = session.dataTask(with: imageURL) { (data, response, error) in
            
            if let e = error {
                print("[ZImages] Error downloading picture, using defaultImage instead : \(e)")
            }
            else {
                    
                if let res = response as? HTTPURLResponse {
                    print("[ZImages] Response got : \(res.statusCode)")
                        
                    if let imageData = data {
                            
                        imageReturn = UIImage.init(data: imageData)!
                            
                    } else if let e = error {
                            
                        print("[ZImages] Error processing image, using defaultImage instead : \(e)")
                            
                    } else {
                        
                        print("[ZImages] Unknown error")
                        
                    }
                        
                }
                else if let e = error {
                        
                    print("[ZImages] Error retrieving response, using defaultImage instead : \(e)")
                        
                }
                    
            }
            
            
        }
            
        downloadPicTask.resume()
            
        return imageReturn
    }
    
    
    static func getImageFromUrlSession(fromURL: String, defaultImage: String, imageView: UIImageView) {
        
        let imageURL: URL = URL.init(string: fromURL.addingPercentEncoding(withAllowedCharacters: CharacterSet.urlQueryAllowed)!)!
        let session = URLSession(configuration: URLSessionConfiguration.default)
        imageView.image = UIImage.init(named: defaultImage)!
        
        print("[ZImages] ImageURL: \(imageURL)")
        
        let downloadPicTask = session.dataTask(with: imageURL) { (data, response, error) in
            
            if let e = error {
                print("[ZImages] Error downloading picture, using defaultImage instead : \(e)")
            }
            else {
                
                if let res = response as? HTTPURLResponse {
                    print("[ZImages] Response got : \(res.statusCode)")
                    
                    if let imageData = data {
                        
                        DispatchQueue.main.async() { () -> Void in imageView.image = UIImage.init(data: imageData)! }
                        
                    } else if let e = error {
                        
                        print("[ZImages] Error processing image, using defaultImage instead : \(e)")
                        
                    } else {
                        
                        print("[ZImages] Unknown error")
                        
                    }
                    
                }
                else if let e = error {
                    
                    print("[ZImages] Error retrieving response, using defaultImage instead : \(e)")
                    
                }
                
            }
            
            
        }
        
        downloadPicTask.resume()
    }
    
    
}
