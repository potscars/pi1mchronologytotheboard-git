//
//  SearchedResultCell.swift
//  dashboardv2
//
//  Created by Hainizam on 17/08/2017.
//  Copyright © 2017 Ingeniworks Sdn Bhd. All rights reserved.
//

import UIKit

class SearchedResultCell: UITableViewCell {

    @IBOutlet weak var featuredImage: UIImageView!
    @IBOutlet weak var title: UILabel!
    @IBOutlet weak var content: UILabel!
    @IBOutlet weak var searchedImageHeightConstraint: NSLayoutConstraint!
    
    var defaultSearchedImageHeightConstraint: CGFloat!
    var isImage = false
    
    var place: Place? {
        didSet {
            self.updateUI()
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    func updateUI() {
        
        title.text = place?.title
        content.text = place?.content
        
        if isImage {
            
            let defaultImage = UIImage(named: "no_image_available")!
            featuredImage.image = defaultImage
        } else {
            
            featuredImage.image = nil
            defaultSearchedImageHeightConstraint = searchedImageHeightConstraint.constant
            
            searchedImageHeightConstraint.constant = 0
            layoutIfNeeded()
        }
    }
    
    override func prepareForReuse() {
        
        if defaultSearchedImageHeightConstraint != nil && searchedImageHeightConstraint != nil {
            
            searchedImageHeightConstraint.constant = defaultSearchedImageHeightConstraint
        }
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}






