//
//  AboutTVC.swift
//  dashboardv2
//
//  SEGUE NAME: DB_GOTO_ABOUT
//
//  Created by Mohd Zulhilmi Mohd Zain on 29/12/2016.
//  Copyright © 2016 Ingeniworks Sdn Bhd. All rights reserved.
//

import UIKit

class AboutTVC: UITableViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem()
        
        self.tableView.rowHeight = UITableViewAutomaticDimension
        self.tableView.separatorStyle = UITableViewCellSeparatorStyle.none
        self.tableView.estimatedRowHeight = 120.0
        self.tableView.backgroundColor = DBColorSet.dashboardMainColor
        self.edgesForExtendedLayout = []
        
        ZGraphics.applyNavigationBarColor(controller: self, setBarTintColor: DBColorSet.dashboardMainColor, setBackButtonFontColor: UIColor.init(red: 255.0/255.0, green: 255.0/255.0, blue: 255.0/255.0, alpha: 1.0), setBarFontColor: UIColor.init(red: 255.0/255.0, green: 255.0/255.0, blue: 255.0/255.0, alpha: 1.0), setBarFontFace: UIFont.init(name: "Arial-BoldMT", size: CGFloat(17.0))!)
        
    }
    
    func preparingAboutInfo() -> NSDictionary
    {
        let version: String? = Bundle.main.infoDictionary?["CFBundleShortVersionString"] as? String
        let buildNo: String? = Bundle.main.infoDictionary?["CFBundleVersion"] as? String
        
        return ["ABOUT_APPNAME":DBStrings.DB_FULL_APPNAME,
                "ABOUT_COPYRIGHT":DBStrings.DB_APP_COPYRIGHT_MS,
                "ABOUT_BUILDER":DBStrings.DB_APP_BUILDER_MS,
                "ABOUT_VERSION":"\(DBStrings.DB_APP_VERSION_MS) \(version!)",
                "ABOUT_BUILDNO":"\(DBStrings.DB_APP_BUILDNO_MS) \(buildNo!)"
        ]
    }
    
    func preparingInfoData() -> NSDictionary
    {
        return ["ABOUT_INFO_TITLE":DBStrings.DB_ABOUT_INFO_TITLE_MS,
                "ABOUT_INFO_DESC":DBStrings.DB_ABOUT_INFO_DESC_MS
        ]
    }
    
    func preparingVideoData() -> NSDictionary
    {
        
        return ["YT_EMBEDDED_KEY":DBSettings.ytEmbeddedVideo,
                "VIDEO_PLAYBACK_WARN":DBStrings.DB_ABOUT_PLAYBACK_WARN_MS
        ]
    }
    
    func preparingImportanceData() -> NSDictionary
    {
        
        return ["YT_EMBEDDED_KEY":DBSettings.ytEmbeddedVideo,
                "VIDEO_PLAYBACK_WARN":DBStrings.DB_ABOUT_PLAYBACK_WARN_MS
        ]
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return 4
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        if(indexPath.row == 0)
        {
            let cell: ABuildInfoTVCell = tableView.dequeueReusableCell(withIdentifier: "ABuildInfoCellID") as! ABuildInfoTVCell
            
            cell.updateCell(data: preparingAboutInfo())
            
            return cell
        }
        else if (indexPath.row == 1){
            
            let cell: AWhatDBTVCell = tableView.dequeueReusableCell(withIdentifier: "AWhatDBCellID") as! AWhatDBTVCell
            
            // Configure the cell...
            
            cell.updateCell(data: preparingInfoData())
            
            return cell
        }
        else if (indexPath.row == 2) {
            
            let cell: AYTPlayerTVCell = tableView.dequeueReusableCell(withIdentifier: "AYTPlayerIntroCellID") as! AYTPlayerTVCell

        // Configure the cell...
        
            cell.configureCell(data: preparingVideoData())

            return cell
        }
        else {
            
            let cell: AImportanceDBTVCell = tableView.dequeueReusableCell(withIdentifier: "AImportanceDBCellID") as! AImportanceDBTVCell
            
            // Configure the cell...
            
            cell.updateImportanceDB(data: preparingImportanceData())
            
            return cell
        }
    }

    /*
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

    /*
    // Override to support rearranging the table view.
    override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
