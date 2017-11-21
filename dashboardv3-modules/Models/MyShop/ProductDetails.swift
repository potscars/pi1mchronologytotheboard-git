//
//  ProductDetails.swift
//  dashboardv2
//
//  Created by Hainizam on 13/11/2017.
//  Copyright © 2017 Ingeniworks Sdn Bhd. All rights reserved.
//

import Foundation
import UIKit

class ProductDetails {
    
    var productName: String!
    var productDescription: String!
    var productOwnerName: String!
    var productOwnerEmail: String!
    var productOwnerPhone: String!
    var productImageURLs: [String]!
    var productLocation: String!
    var productCategory: String!
    var productComments: [Comment]!
    
    var urlString: String!
    
    init(_ name: String, description: String, ownerName: String, ownerEmail: String, ownerPhone: String, imageURLs: [String], location: String, category: String, comments: [Comment] = [Comment]()) {
        
        self.productName = name
        self.productDescription = description
        self.productOwnerName = ownerName
        self.productOwnerEmail = ownerEmail
        self.productOwnerPhone = ownerPhone
        self.productImageURLs = imageURLs
        self.productLocation = location
        self.productCategory = category
        self.productComments = comments
        
    }
    
    init(_ urlString: String) {
        self.urlString = urlString
    }
    
    func fetchData(completion: @escaping (ProductDetails?, String?) -> ()) {
        
        var productDetails: ProductDetails!
        let networkProcessor = NetworkProcessor.init(self.urlString)
        
        networkProcessor.getRequestJSONFromUrl { (results, responses) in
            
            guard responses == nil else { return }
            
            if let resultsDictionary = results as? NSDictionary {
                
                var titleTemp = "Tiada"
                var descriptionTemp = "Tiada maklumat"
                var imageURLsTemp = [String]()
                var categoryTemp = "Tiada"
                var ownerNameTemp = "Tiada"
                var ownerEmailTemp = "Tiada"
                var ownerPhoneTemp = "Tiada"
                var locationTemp = "Tiada"
                
                guard let status = resultsDictionary["status"] as? Int, status == 1 else { return }
                
                if let title = resultsDictionary["title"] as? String {
                    titleTemp = title
                }
                
                if let description = resultsDictionary["description"] as? String {
                    descriptionTemp = description
                }
                
                if let imageURLs = resultsDictionary["photos"] as? NSArray {
                    
                    for imageURL in imageURLs {
                        
                        if let urlString = (imageURL as AnyObject).object(forKey: "url_photo_large") as? String, let encodedURLString = urlString.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed) {
                            imageURLsTemp.append(encodedURLString)
                        }
                    }
                }
                
                if let subcategory = resultsDictionary["sub_category"] as? NSDictionary, let category = subcategory["category"] as? NSDictionary, let name = category["name"] as? String {
                    categoryTemp = name
                }
                
                //user details
                if let user = resultsDictionary["user"] as? NSDictionary {
                    
                    if let name = user["name"] as? String {
                        ownerNameTemp = name
                    }
                    
                    if let email = user["email"] as? String {
                        ownerEmailTemp = email
                    }
                    
                    if let phoneNumber = user["phone"] as? String {
                        ownerPhoneTemp = phoneNumber
                    }
                    
                    if let site = user["site"] as? NSDictionary, let location = site["address"] as? String {
                        locationTemp = location
                    }
                }
                
                //product reviews
                
                var comments = [Comment]()
                var idTemp = 0
                var commentTemp = ""
                
                if let reviews = resultsDictionary["reviews"] as? NSArray {
                    
                    //guard reviews.count > 0 else { return }
                    
                    for review in reviews {
                        
                        if let id = (review as AnyObject).object(forKey: "user_id") as? Int {
                            idTemp = id
                        }
                        
                        if let comment = (review as AnyObject).object(forKey: "comment") as? String {
                            commentTemp = comment
                        }
                        
                        comments.append(Comment.init(idTemp, message: commentTemp))
                    }
                }
                
                productDetails = ProductDetails.init(titleTemp, description: descriptionTemp, ownerName: ownerNameTemp, ownerEmail: ownerEmailTemp, ownerPhone: ownerPhoneTemp, imageURLs: imageURLsTemp, location: locationTemp, category: categoryTemp, comments: comments)
                
                completion(productDetails, nil)
            } else {
                completion(nil, "Such empty..")
            }
        }
    }
    
}

class Comment {
    
    var senderID: Int!
    var message: String!
    
    init(_ senderID: Int, message: String) {
        self.senderID = senderID
        self.message = message
    }
}
















