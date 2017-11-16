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

extension UIImage{
    
    func resizeImageWith(newSize: CGSize, opaque: Bool) -> UIImage {
        
        let horizontalRatio = newSize.width / size.width
        let verticalRatio = newSize.height / size.height
        
        let ratio = max(horizontalRatio, verticalRatio)
        let newSize = CGSize(width: size.width * ratio, height: size.height * ratio)
        UIGraphicsBeginImageContextWithOptions(newSize, opaque, 0)
        draw(in: CGRect(origin: CGPoint(x: 0, y: 0), size: newSize))
        let newImage = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        return newImage!
    }
    
    func addImagePadding(x: CGFloat, y: CGFloat) -> UIImage? {
        let width: CGFloat = self.size.width + x
        let height: CGFloat = self.size.width + y
        UIGraphicsBeginImageContextWithOptions(CGSize(width: width, height: height), false, 0)
        let origin: CGPoint = CGPoint(x: (width - self.size.width) / 2, y: (height - self.size.height) / 2)
        self.draw(at: origin)
        let imageWithPadding = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        
        return imageWithPadding
    }
    
    func drawInRectAspectFill(rect: CGRect) {
        let targetSize = rect.size
        if targetSize == CGSize.zero {
            return self.draw(in: rect)
        }
        let widthRatio    = targetSize.width  / self.size.width
        let heightRatio   = targetSize.height / self.size.height
        let scalingFactor = max(widthRatio, heightRatio)
        let newSize = CGSize(width:  self.size.width  * scalingFactor,
                             height: self.size.height * scalingFactor)
        UIGraphicsBeginImageContext(targetSize)
        let origin = CGPoint(x: (targetSize.width  - newSize.width)  / 2,
                             y: (targetSize.height - newSize.height) / 2)
        self.draw(in: CGRect(origin: origin, size: newSize))
        let scaledImage = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        scaledImage!.draw(in: rect)
    }
    
}
