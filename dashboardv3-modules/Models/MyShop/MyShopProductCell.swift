//
//  MyShopProductCell.swift
//  dashboardv2
//
//  Created by Hainizam on 07/11/2017.
//  Copyright © 2017 Ingeniworks Sdn Bhd. All rights reserved.
//

import UIKit

class MyShopProductCell: UICollectionViewCell {
    
    @IBOutlet weak var imageFeatured: UIImageView!
    @IBOutlet weak var productNameLabel: UILabel!
    @IBOutlet weak var productPriceLabel: UILabel!
    @IBOutlet weak var viewsCountLabel: UILabel!
    @IBOutlet weak var viewImage: UIImageView!
    @IBOutlet weak var commentsCountLabel: UILabel!
    @IBOutlet weak var commentImage: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        viewImage.tintColor = .darkGray
        commentImage.tintColor = .darkGray
    }
}
