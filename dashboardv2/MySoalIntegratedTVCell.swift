//
//  MySoalIntegratedTVCell.swift
//  dashboardv2
//
//  CellIDs = MySoalMainCellID, MySoalLoadingCellID, MySoalLoadMoreCellID
//
//  Created by Mohd Zulhilmi Mohd Zain on 18/01/2017.
//  Copyright © 2017 Ingeniworks Sdn Bhd. All rights reserved.
//

import UIKit

class MySoalIntegratedTVCell: UITableViewCell {
    
    @IBOutlet weak var uilMSITVCSenderName: UILabel!
    @IBOutlet weak var uilMSITVCArticleTitle: UILabel!
    @IBOutlet weak var uilMSITVCArticleDate: UILabel!
    @IBOutlet weak var uilMSITVCArticleDesc: UILabel!
    @IBOutlet weak var uivMSITVCLegendColor: UIView!
    
    @IBOutlet weak var uilMSITVCLoadingStatus: UILabel!
    @IBOutlet weak var uiaivMSITVCLoadingIndicator: UIActivityIndicatorView!
    
    @IBOutlet weak var uilMSITVCLoadMoreStatus: UILabel!

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    func updateFeedData(data: NSDictionary)
    {
        uilMSITVCSenderName.text = data.object(forKey: "MESSAGE_SENDER") as? String
        uilMSITVCArticleTitle.text = data.object(forKey: "MESSAGE_TITLE") as? String
        uilMSITVCArticleDate.text = data.object(forKey: "MESSAGE_DATE_SHORT") as? String
        uilMSITVCArticleDesc.text = data.object(forKey: "MESSAGE_SUMMARY") as? String
        uivMSITVCLegendColor.backgroundColor = DBColorSet.mySoalColor
    }
    
    func setLoadingState(isLoading: Bool)
    {
        if(isLoading == true) {
            uilMSITVCLoadingStatus.text = "Sedang memuatkan..."
            uiaivMSITVCLoadingIndicator.startAnimating()
        }
        else {
            uilMSITVCLoadingStatus.text = "Data telah dimuatkan"
            uiaivMSITVCLoadingIndicator.stopAnimating()
        }
    }
    
    func setLoadMoreState(isLoadingMore: Bool)
    {
        self.backgroundColor = DBColorSet.mySoalColor
        self.uilMSITVCLoadMoreStatus.textColor = UIColor.white
        
        if(isLoadingMore == true)
        {
            uilMSITVCLoadMoreStatus.text = DBStrings.DB_MODULE_MYSOAL_LOADMORE_PROCESSING_MS
        }
        else
        {
            uilMSITVCLoadMoreStatus.text = DBStrings.DB_MODULE_MYSOAL_LOADMORE_IDLE_MS
        }
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
