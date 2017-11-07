//
//  PhotosHolderVC.swift
//  dashboardKB
//
//  Created by Hainizam on 06/06/2017.
//  Copyright © 2017 Ingeniworks Sdn Bhd. All rights reserved.
//

import UIKit

class PhotosHolderVC: UICollectionView {

    struct Storyboard {
        static let photoCell = "photoCell"
    }
    
    var images: [UIImage]?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        dataSource = self
        //delegate = self
    }
}

// MARK: UICollectionViewDataSource

extension PhotosHolderVC: UICollectionViewDataSource {
    
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of items
        
        if images == nil {
            
            return 1
        } else {
            
            return (images?.count)!
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: Storyboard.photoCell, for: indexPath) as! PhotoHolderCell
        
        if images == nil {
            
            cell.image = UIImage(named: "default_avatar")
        } else {
            
            cell.image = images?[indexPath.item]
        }
        
        return cell
    }
}
























