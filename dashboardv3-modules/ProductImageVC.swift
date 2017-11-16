//
//  ProductImageVC.swift
//  dashboardv2
//
//  Created by Hainizam on 15/11/2017.
//  Copyright © 2017 Ingeniworks Sdn Bhd. All rights reserved.
//

import UIKit
import SDWebImage

class ProductImageVC: UIViewController {

    @IBOutlet weak var imageView: UIImageView!
    
    var imageString: String? {
        didSet{
            print(imageString)
            if let imageURL = URL(string: imageString!) {
                self.imageView?.sd_setImage(with: imageURL)
            }
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        if let imageString = self.imageString, let url = URL(string: imageString) {
            self.imageView?.sd_setImage(with: url)
        }
    }
}




