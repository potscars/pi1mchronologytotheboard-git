//
//  MySkoolIntegratedTVCell.swift
//  dashboardv2
//
//  Cell-id: MySkoolMainCellID, MySkoolLoadingCellID, MySkoolLoadMoreCellID
//
//  Created by Mohd Zulhilmi Mohd Zain on 23/01/2017.
//  Copyright © 2017 Ingeniworks Sdn Bhd. All rights reserved.
//

import UIKit

class MySkoolIntegratedTVCell: UITableViewCell {
    
    @IBOutlet weak var uivMSITVCIndicator: UIView!
    @IBOutlet weak var uilMSITVCSenderName: UILabel!
    @IBOutlet weak var uilMSITVCArticleDate: UILabel!
    @IBOutlet weak var uilMSITVCArticleTitle: UILabel!
    @IBOutlet weak var uilMSITVCArticleDesc: UILabel!
    
    @IBOutlet weak var uiaivMSITVCProgress: UIActivityIndicatorView!
    @IBOutlet weak var uilMSITVCProgressStatus: UILabel!
    
    @IBOutlet weak var uilMSITVCLoadMoreStatus: UILabel!

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    func updateFeedData(data: NSDictionary)
    {
        uilMSITVCSenderName.text = data.object(forKey: "MESSAGE_SENDER") as? String
        uilMSITVCArticleTitle.text = data.object(forKey: "MESSAGE_TITLE") as? String
        uilMSITVCArticleDate.text = ZDateTime.dateFormatConverter(valueInString: data.value(forKey: "MESSAGE_DATE") as! String, dateTimeFormatFrom: nil, dateTimeFormatTo: ZDateTime.DateInShort)
        uilMSITVCArticleDesc.text = data.object(forKey: "MESSAGE_SUMMARY") as? String
        uivMSITVCIndicator.backgroundColor = DBColorSet.mySkoolColor
    }
    
    func setLoadingState(isLoading: Bool)
    {
        if(isLoading == true) {
            uilMSITVCProgressStatus.text = "Sedang memuatkan..."
            uiaivMSITVCProgress.startAnimating()
        }
        else {
            uilMSITVCProgressStatus.text = "Data telah dimuatkan"
            uiaivMSITVCProgress.stopAnimating()
        }
    }
    
    func setLoadMoreState(isLoadingMore: Bool)
    {
        self.backgroundColor = DBColorSet.mySkoolColor
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
