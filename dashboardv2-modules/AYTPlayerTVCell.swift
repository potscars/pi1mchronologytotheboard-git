//
//  AYTPlayerTVCell.swift
//  dashboardv2
//
//  CELL-ID: AYTPlayerIntroCellID
//
//  Created by Mohd Zulhilmi Mohd Zain on 29/12/2016.
//  Copyright © 2016 Ingeniworks Sdn Bhd. All rights reserved.
//

import UIKit
import youtube_ios_player_helper

class AYTPlayerTVCell: UITableViewCell {

    @IBOutlet weak var introPlayerView: YTPlayerView!
    @IBOutlet weak var uilAYTPTVCWarn: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func configureCell(data: NSDictionary)
    {
        self.backgroundColor = DBColorSet.aboutWhatDBBGColor
        self.introPlayerView.load(withVideoId: data.value(forKey: "YT_EMBEDDED_KEY") as! String)
        uilAYTPTVCWarn.text = data.value(forKey: "VIDEO_PLAYBACK_WARN") as? String
        uilAYTPTVCWarn.textColor = UIColor.white
    }

}
