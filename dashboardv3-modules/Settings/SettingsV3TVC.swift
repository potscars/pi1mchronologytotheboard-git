//
//  SettingsTVC.swift
//  dashboardv2
//
//  Created by Mohd Zulhilmi Mohd Zain on 10/11/2017.
//  Copyright © 2017 Ingeniworks Sdn Bhd. All rights reserved.
//

import UIKit

class SettingsV3TVC: UITableViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem
        self.tableView.rowHeight = UITableViewAutomaticDimension
        self.tableView.estimatedRowHeight = 60.0
        
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
        return 2
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        if indexPath.row == 0 {
            
            let cell = UITableViewCell.init(style: UITableViewCellStyle.subtitle, reuseIdentifier: "SettingsRememberMeCellID")

            // Configure the cell...
            let rememberMeSwitch: UISwitch = UISwitch.init()
            rememberMeSwitch.isOn = ChangeSettingsValue.rememberMe
            rememberMeSwitch.addTarget(self, action: #selector(rememberMeSwitching(switchState:)), for: UIControlEvents.valueChanged)
            cell.accessoryView = rememberMeSwitch
            cell.textLabel?.text = "Ingatkan Saya"
            cell.detailTextLabel?.text = "Mengarahkan aplikasi untuk mengingati akaun anda."
            cell.detailTextLabel?.numberOfLines = 0
            cell.imageView?.image = #imageLiteral(resourceName: "ic_rememberMe.png").resizeImageWith(newSize: CGSize.init(width: 30, height: 30), opaque: false)
            cell.selectionStyle = UITableViewCellSelectionStyle.none
            
            return cell
        }
        else {
            
            let cell = UITableViewCell.init(style: UITableViewCellStyle.default, reuseIdentifier: "SettingsLogoutCellID")
            
            // Configure the cell...
            cell.textLabel?.text = "Log Keluar"
            cell.imageView?.image = #imageLiteral(resourceName: "ic_logout.png").resizeImageWith(newSize: CGSize.init(width: 30, height: 30), opaque: false)
            
            return cell
            
        }
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if(indexPath.row == 0) {
            return 80.0
        }
        else {
            return 60.0
        }
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        tableView.deselectRow(at: indexPath, animated: true)
        
        if(indexPath.row == 1) {
            exitToLogin()
        }
    }
    
    @objc func rememberMeSwitching(switchState: UISwitch) {
        
        if switchState.isOn == true {
            
            ChangeSettingsValue.rememberMe = true
            
        } else if switchState.isOn == false {
            
            ChangeSettingsValue.rememberMe = false
            
        }
        
    }
    
    func exitToLogin() {
        
        let logoutAlertController: UIAlertController = UIAlertController.init(title: DBStrings.DB_APP_SETTINGS_LOGOUT_TITLE_MS, message: DBStrings.DB_APP_SETTINGS_LOGOUT_MESSAGE_MS, preferredStyle: UIAlertControllerStyle.alert)
        
        let logoutCancelAction: UIAlertAction = UIAlertAction.init(title: DBStrings.DB_BUTTON_NO_LABEL_MS, style: UIAlertActionStyle.default, handler: { action -> Void in
            
            logoutAlertController.dismiss(animated: true, completion: nil)
            
        })
        logoutAlertController.addAction(logoutCancelAction)
        
        let logoutProceedAction: UIAlertAction = UIAlertAction.init(title: DBStrings.DB_BUTTON_YES_LABEL_MS, style: UIAlertActionStyle.default, handler: { action -> Void in
            
            ChangeSettingsValue.clearAllUserData()
            self.performSegue(withIdentifier: "DB_RETURNTO_LOGIN", sender: self)
            
        })
        logoutAlertController.addAction(logoutProceedAction)
        
        logoutAlertController.preferredAction = logoutCancelAction
        
        self.present(logoutAlertController, animated: true, completion: nil)
        
        
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
