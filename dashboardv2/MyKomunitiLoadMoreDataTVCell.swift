//
//  MyKomunitiLoadMoreDataTVCell.swift
//  dashboardv2
//
//  Created by Mohd Zulhilmi Mohd Zain on 12/01/2017.
//  Copyright © 2017 Ingeniworks Sdn Bhd. All rights reserved.
//

import UIKit

class MyKomunitiLoadMoreDataTVCell: UITableViewCell {

    @IBOutlet weak var uilMKLMDTVCText: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        
        self.backgroundColor = DBColorSet.myKomunitiColor
        self.uilMKLMDTVCText.textColor = UIColor.white
    }
    
    func setProcessingState()
    {
        self.uilMKLMDTVCText.text = DBStrings.DB_MODULE_MYKOMUNITI_LOADMORE_PROCESSING_MS
        self.isUserInteractionEnabled = false
    }
    
    func setFinishState()
    {
        self.uilMKLMDTVCText.text = DBStrings.DB_MODULE_MYKOMUNITI_LOADMORE_IDLE_MS
        self.isUserInteractionEnabled = true
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
