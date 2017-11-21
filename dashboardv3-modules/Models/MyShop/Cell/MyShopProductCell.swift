//
//  MyShopProductCell.swift
//  dashboardv2
//
//  Created by Hainizam on 07/11/2017.
//  Copyright © 2017 Ingeniworks Sdn Bhd. All rights reserved.
//

import UIKit
import SDWebImage

class MyShopProductCell: UICollectionViewCell {
    
    @IBOutlet weak var imageFeatured: UIImageView!
    @IBOutlet weak var productNameLabel: UILabel!
    @IBOutlet weak var productPriceLabel: UILabel!
    @IBOutlet weak var viewsCountLabel: UILabel!
    @IBOutlet weak var viewImage: UIImageView!
    @IBOutlet weak var commentsCountLabel: UILabel!
    @IBOutlet weak var commentImage: UIImageView!
    
    var product: Product! {
        didSet {
            self.updateUI()
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        viewImage.tintColor = .darkGray
        commentImage.tintColor = .darkGray
    }
    
    private func updateUI() {
        
        productNameLabel.backgroundColor = .clear
        productPriceLabel.backgroundColor = .clear
        viewsCountLabel.backgroundColor = .clear
        commentsCountLabel.backgroundColor = .clear
        
        productNameLabel.text = product.productName
        productPriceLabel.text = "RM \(product.productPrice!)"
        viewsCountLabel.text = " \(product.productViewCount!)"
        commentsCountLabel.text = " \(product.productCommentCount!)"
        
        let urlStringAfterTrimming = product.productThumbnailURL.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed)
        if let imageURL = URL(string: urlStringAfterTrimming!) {
            imageFeatured.sd_setImage(with: imageURL)
        }
    }
}















