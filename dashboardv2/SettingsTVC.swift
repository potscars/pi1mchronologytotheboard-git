//
//  SettingsTVC.swift
//  dashboardv2
//
//  Created by Mohd Zulhilmi Mohd Zain on 03/01/2017.
//  Copyright © 2017 Ingeniworks Sdn Bhd. All rights reserved.
//

import UIKit

class SettingsTVC: UITableViewController {
    
    var listOfMenus: NSMutableArray = []
    
    var cell: SettingsIntegratedTVCell? = nil

    override func viewDidLoad() {
        super.viewDidLoad()

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem()
        
        self.tableView.rowHeight = UITableViewAutomaticDimension
        self.tableView.estimatedRowHeight = 100.0
        
        populateMenus()
        
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        for i in 0...listOfMenus.count - 1 {
            
            let menuDataAcquired: NSDictionary = listOfMenus.object(at: i) as! NSDictionary
            
            if(menuDataAcquired.value(forKey: "NOTIFICATION_ID") as? String != nil)
            {
                print("Registering \(menuDataAcquired.value(forKey: "NOTIFICATION_ID") as! String)")
                NotificationCenter.default.addObserver(self, selector: #selector(warningAction(notificationID:)), name: Notification.Name(menuDataAcquired.value(forKey: "NOTIFICATION_ID") as! String), object:nil)
            }
        }
        
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        
        super.viewDidDisappear(animated)
        
        for i in 0...listOfMenus.count - 1 {
            
            let menuDataAcquired: NSDictionary = listOfMenus.object(at: i) as! NSDictionary
            
            if(menuDataAcquired.value(forKey: "NOTIFICATION_ID") as? String != nil)
            {
                NotificationCenter.default.removeObserver(self, name: Notification.Name(menuDataAcquired.value(forKey: "NOTIFICATION_ID") as! String), object: nil)
            }
        }
        
    }
    
    func populateMenus()
    {
        listOfMenus.add(["CELL_TYPE":"SWITCH_TYPE",
                         "MENU_ID":"REMEMBER_ME",
                         "MENU_TITLE":DBStrings.DB_SETTINGS_REMEMBERME_TITLE_MS,
                         "MENU_DESCRIPTION":DBStrings.DB_SETTINGS_REMEMBERME_DESC_MS,
                         "USERDEFAULTS_ID":"SuccessLoggerSettingsRememberMe",
                         "NOTIFICATION_ID":nil])
    
        /*
        listOfMenus.add(["CELL_TYPE":"SINGLE_NORMAL_TYPE",
                         "MENU_ID":"MODULE_SELECTION",
                         "MENU_TITLE":"Pilihan Modul",
                         "MENU_DESCRIPTION":nil,
                         "USERDEFAULTS_ID":nil,
                         "NOTIFICATION_ID":nil])
        
        listOfMenus.add(["CELL_TYPE":"SINGLE_NORMAL_TYPE",
                         "MENU_ID":"LANGUAGE_SELECTION",
                         "MENU_TITLE":"Tetapan Bahasa",
                         "MENU_DESCRIPTION":nil,
                         "USERDEFAULTS_ID":nil,
                         "NOTIFICATION_ID":nil])
         */
        
        listOfMenus.add(["CELL_TYPE":"SINGLE_WARN_TYPE",
                         "MENU_ID":"LOGOUT",
                         "MENU_TITLE":DBStrings.DB_APP_SETTINGS_LOGOUT_TITLE_MS,
                         "MENU_DESCRIPTION":nil,
                         "USERDEFAULTS_ID":nil,
                         "NOTIFICATION_ID":"LogoutNotification"])
        
        
    }
    
    func warningAction(notificationID: String) {
        
        //specify yourself here
        
        print("WARNING TRIGGERED")
        
        if(notificationID == "LogoutNotification")
        {
            print("MAINMENU DISMISSED")
        }
        
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
        return listOfMenus.count
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
     ////TSwitchMenuCellID, TSingleMenuCellID, TWarningMenuCellID
    
        let menuDataAcquired: NSDictionary = listOfMenus.object(at: indexPath.row) as! NSDictionary
        
        print(menuDataAcquired.value(forKey: "CELL_TYPE") as! String)
        
        if(menuDataAcquired.value(forKey: "CELL_TYPE") as! String == "SWITCH_TYPE")
        {
            cell = tableView.dequeueReusableCell(withIdentifier: "TSwitchMenuCellID") as? SettingsIntegratedTVCell

            // Configure the cell...
            cell?.selectionStyle = UITableViewCellSelectionStyle.none
            cell?.updateCellSwitchType(title: menuDataAcquired.value(forKey: "MENU_TITLE") as! String, description: menuDataAcquired.value(forKey: "MENU_DESCRIPTION") as! String, userDefaultsStandardObjectKey: menuDataAcquired.value(forKey: "USERDEFAULTS_ID") as! String)

            return cell!
        }
        else if(menuDataAcquired.value(forKey: "CELL_TYPE") as! String == "SINGLE_WARN_TYPE")
        {
            cell = tableView.dequeueReusableCell(withIdentifier: "TWarningMenuCellID") as? SettingsIntegratedTVCell
            
            // Configure the cell...
            cell?.selectionStyle = UITableViewCellSelectionStyle.default
            
            return cell!
        }
        else
        {
            cell = tableView.dequeueReusableCell(withIdentifier: "TSingleMenuCellID") as? SettingsIntegratedTVCell
            
            // Configure the cell...
            cell?.selectionStyle = UITableViewCellSelectionStyle.default
            cell?.updateCellNormalType(title: menuDataAcquired.value(forKey: "MENU_TITLE") as! String)
            
            return cell!
        }
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        
        let menuDataAcquired: NSDictionary = listOfMenus.object(at: indexPath.row) as! NSDictionary
        
        if(menuDataAcquired.value(forKey: "CELL_TYPE") as! String == "SWITCH_TYPE") {
            
            return 100
            
        }
        else {
            
            return 60
            
        }
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        tableView.deselectRow(at: indexPath, animated: true)
        
        if(indexPath.row == 1)
        {
            cell = tableView.dequeueReusableCell(withIdentifier: "TWarningMenuCellID") as? SettingsIntegratedTVCell
            
            cell?.updateCellWarningType(viewController: self, title: DBStrings.DB_APP_SETTINGS_LOGOUT_TITLE_MS, message: DBStrings.DB_APP_SETTINGS_LOGOUT_MESSAGE_MS)
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
