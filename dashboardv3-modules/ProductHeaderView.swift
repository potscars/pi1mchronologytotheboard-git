//
//  ProductImageView.swift
//  dashboardv2
//
//  Created by Hainizam on 15/11/2017.
//  Copyright © 2017 Ingeniworks Sdn Bhd. All rights reserved.
//

import UIKit

class ProductHeaderView: UIView {

    @IBOutlet weak var pageControl: UIPageControl!
    
}

extension ProductHeaderView: ProductImagePageVCDelegate {
    
    func setupPageController(_ numberOfPages: Int) {
        pageControl.numberOfPages = numberOfPages
    }
    
    func turnToPages(_ index: Int) {
        
        pageControl.currentPage = index
    }
}
