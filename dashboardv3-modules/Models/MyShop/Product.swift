//
//  Product.swift
//  dashboardv2
//
//  Created by Hainizam on 10/11/2017.
//  Copyright © 2017 Ingeniworks Sdn Bhd. All rights reserved.
//

import UIKit

class Product {
    
    var productId: Int!
    var productName: String!
    var productPrice: String!
    var productCommentCount: Int!
    var productViewCount: Int!
    var productThumbnailURL: String!
    
    var urlString: String!
    
    init(_ urlString: String) {
        self.urlString = urlString
    }
    
    init(_ id: Int, name: String, price: String, commentCount: Int, viewCount: Int, thumbnailURL: String? = nil) {
        
        self.productId = id
        self.productName = name
        self.productPrice = price
        self.productCommentCount = commentCount
        self.productViewCount = viewCount
        self.productThumbnailURL = thumbnailURL
    }
    
    typealias ProductCompletion = ([Product]?, Bool, String?) -> ()
    
    func fetchProduct(_ page: Int, completion: @escaping ProductCompletion) {
        
        var products = [Product]()
        let urlStringWithPage = "\(urlString!)?page=\(page)"
        print(urlStringWithPage)
        let networkProcessor = NetworkProcessor.init(urlStringWithPage)
        
        networkProcessor.getRequestJSONFromUrl { (results, responses) in
            
            guard responses == nil else {
                completion(nil, false, responses!)
                return
            }
            
            guard let data = results as? NSDictionary else { return }
            
            guard let totalPage = data["last_page"] as? Int else { return }
            
            guard let currentPage = data["current_page"] as? Int, currentPage != totalPage else {
                completion(nil, false, nil)
                return }
            
            if let dataArray = data["data"] as? NSArray {
                
                var idTemp = 0
                var titleTemp = "Not Available"
                var priceTemp = "Not Available"
                var commentsCountTemp = 0
                var viewsCountTemp = 0
                var thumbnailsTemp = String()
                
                for product in dataArray {
                    
                    if let id = (product as AnyObject).object(forKey: "id") as? Int {
                        idTemp = id
                    }
                    
                    if let title = (product as AnyObject).object(forKey: "title") as? String {
                        titleTemp = title
                    }
                    
                    if let price = (product as AnyObject).object(forKey: "price") as? String {
                        priceTemp = price
                    }
                    
                    if let commentsCount = (product as AnyObject).object(forKey: "comment_count") as? Int {
                        commentsCountTemp = commentsCount
                    }
                    
                    if let viewsCount = (product as AnyObject).object(forKey: "viewer_count") as? Int {
                        viewsCountTemp = viewsCount
                    }
                    
                    if let thumbnailsURL = (product as AnyObject).object(forKey: "url_photo_thumb") as? String {
                        thumbnailsTemp = thumbnailsURL
                    }
                    
                    products.append(Product.init(idTemp, name: titleTemp, price: priceTemp, commentCount: commentsCountTemp, viewCount: viewsCountTemp, thumbnailURL: thumbnailsTemp))
                }
                
                completion(products, true, nil)
            } else {
                completion(products, false, nil)
            }
        }
    }
}

//{
//    "id": 16448,
//    "sub_category_id": 10,
//    "status": 1,
//    "typeofunit_id": null,
//    "user_id": 135309,
//    "title": "SHAKLEE",
//    "description": "<p><img src=\"../../../textImages/23483033_1981847945426903_1397153722_o.png\" alt=\"\" /></p>",
//    "rating_cache": 3,
//    "rating_count": 0,
//    "viewer_count": 1,
//    "viewer_count_by_week": 1,
//    "search_count_by_week": 0,
//    "week_viewer": 45,
//    "week_search": 0,
//    "comment_count": 0,
//    "price": "376.00",
//    "quantity": 0,
//    "sku": null,
//    "per_item_shipping_id": null,
//    "option": null,
//    "date": "0000-00-00 00:00:00",
//    "term": "",
//    "updated_at": "2017-11-10 09:40:13",
//    "created_at": "2017-11-10 09:23:28",
//    "deleted_at": "0000-00-00 00:00:00",
//    "main_photo": "1510305808_23483033_1981847945426903_1397153722_o.png",
//    "url_photo_thumb": "http://myshop.pi1m.my/productImage/thumbs/1510305808_23483033_1981847945426903_1397153722_o.png",
//    "url_photo_large": "http://myshop.pi1m.my/productImage/large/1510305808_23483033_1981847945426903_1397153722_o.png",
//    "photos": [
//    {
//    "id": 26508,
//    "product_id": 16448,
//    "name": "1510305808_23483033_1981847945426903_1397153722_o.png",
//    "updated_at": "2017-11-10 09:23:28",
//    "created_at": "2017-11-10 09:23:28",
//    "deleted_at": null
//    }
//    ]
//}





