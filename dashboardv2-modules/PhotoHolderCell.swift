//
//  PhotoHolderCell.swift
//  dashboardKB
//
//  Created by Hainizam on 06/06/2017.
//  Copyright © 2017 Ingeniworks Sdn Bhd. All rights reserved.
//

import UIKit

class PhotoHolderCell: UICollectionViewCell {
    
    @IBOutlet weak var imageView: UIImageView!
    
    var image: UIImage! {
        didSet {
            self.updateCell()
        }
    }
    
    func updateCell() {
        
        imageView.image = image
    }
}
