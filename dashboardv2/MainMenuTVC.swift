//
//  MainMenuTVC.swift
//  dashboardv2
//
//  Created by Mohd Zulhilmi Mohd Zain on 27/12/2016.
//  Copyright © 2016 Ingeniworks Sdn Bhd. All rights reserved.
//

import UIKit

class MainMenuTVC: UITableViewController {
    
    //let menuArrays: NSMutableArray = []
    var preferredPhoneNo: String = ""
    var myQuizVerifiedUser: Bool = false
    let appDelegate: AppDelegate = UIApplication.shared.delegate as! AppDelegate
    
    @IBOutlet var uitvMMTVCMenuLists: UITableView!
    
    let verifiedEventNotification: String = "MyQuizUserVerifiedNotification"
    let verifyingEventNotification: String = "MyQuizUserVerifyingNotification"
    let getQuestionLeft: String = "MyQuizGetQuestionLeftNotification"
    
    var questionAvailable: Bool = false
    
    
    override func loadView() {
        super.loadView()
        
        
        
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem()
        
        DBWebServices.checkConnectionToDashboard(viewController: self)
        
        AppDelegate.mainMenuController = self
        
        self.tableView.rowHeight = UITableViewAutomaticDimension
        self.tableView.separatorStyle = UITableViewCellSeparatorStyle.none
        self.tableView.estimatedRowHeight = 120.0
        self.edgesForExtendedLayout = []
        self.tableView.backgroundColor = DBColorSet.dashboardMainColor
        self.navigationController?.setNavigationBarHidden(false, animated: true)
        
        let rightBtnItem: UIBarButtonItem = UIBarButtonItem.init(title: "\u{2699}", style: .plain, target: self, action: #selector(gotoSettings))
        self.navigationItem.rightBarButtonItem = rightBtnItem
        
        let backButtonItem: UIBarButtonItem = UIBarButtonItem()
        backButtonItem.title = DBStrings.DB_BUTTON_BACK_LABEL_MS
        self.navigationItem.backBarButtonItem = backButtonItem
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        if(DBWebServices.checkConnectionToDashboard(viewController: self) == true) {
            
            NotificationCenter.default.addObserver(self, selector: #selector(myQuizVerifiedUser(data:)), name: Notification.Name(verifiedEventNotification), object: nil)
            NotificationCenter.default.addObserver(self, selector: #selector(myQuizVerifyUser(data:)), name: Notification.Name(verifyingEventNotification), object: nil)
            NotificationCenter.default.addObserver(self, selector: #selector(gotQuestionData(data:)), name: Notification.Name(getQuestionLeft), object: nil)
            
            DBWebServices.getMyQuizGetQuestions(token: String(describing:UserDefaults.standard.object(forKey: "SuccessLoggerDashboardToken")!), registeredNotification: getQuestionLeft)
            
            DBWebServices.getMyQuizVerifyEvent(token: String(describing: UserDefaults.standard.object(forKey: "SuccessLoggerDashboardToken")!), registeredNotification: verifyingEventNotification)
            
        }
        
        let getUserDefaults: UserDefaults? = UserDefaults.standard
        let loginState: Bool? = getUserDefaults?.object(forKey: "SuccessLoggerIsLogin") as? Bool
        
        print("Loginstate is \(loginState!)")
        
        if(loginState! == false)
        {
            _ = self.navigationController?.popViewController(animated: true)
        }
        
        print("Settings registered:\n\nRemember Me: \(UserDefaults.standard.object(forKey: "SuccessLoggerSettingsRememberMe") as! Bool)\nLanguage Selected: \(UserDefaults.standard.object(forKey: "SuccessLoggerSettingsLanguage") as! String)\nModule Selected: \(UserDefaults.standard.object(forKey: "SuccessLoggerSettingsModuleSelected") as! NSArray)")
        
        ZGraphics.applyNavigationBarColor(controller: self, setBarTintColor: DBColorSet.dashboardMainColor, setBackButtonFontColor: UIColor.init(red: 255.0/255.0, green: 255.0/255.0, blue: 255.0/255.0, alpha: 1.0), setBarFontColor: UIColor.init(red: 255.0/255.0, green: 255.0/255.0, blue: 255.0/255.0, alpha: 1.0), setBarFontFace: UIFont.init(name: "Arial-BoldMT", size: CGFloat(17.0))!)
        
        self.tableView.reloadData()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        
        NotificationCenter.default.removeObserver(self, name: Notification.Name(verifiedEventNotification), object: nil);
        NotificationCenter.default.removeObserver(self, name: Notification.Name(verifyingEventNotification), object: nil);
    }
    
    func gotoSettings(sender: UIEvent)
    {
        print("[MainMenuTVC] Open settings \(sender)!")
        
        self.performSegue(withIdentifier: "DB_GOTO_SETTINGS", sender: self)
    }
    
    func gotQuestionData(data: NSDictionary) {
        
        if let unwrapData = data.value(forKey: "object") as? NSDictionary {
            
            if let questionStatus = unwrapData.value(forKey: "status") as? Int{
                
                print("inininin \(questionStatus)")
                
                if(questionStatus == 0) {
                    
                    questionAvailable = false
                    
                    DispatchQueue.main.async {
                        
                        self.tableView.reloadData()
                    }
                } else {
                    
                    questionAvailable = true
                    DispatchQueue.main.async {
                        
                        self.tableView.reloadData()
                    }
                }
            }
        }
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        if(questionAvailable == true) {
            return 2
        }
        else {
            return 1
        }
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        
        if(section == 0 && questionAvailable == true) {
            return 1
        }
        else {
            return DBMenus.dashboardFrontMenu().count
        }
    
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        if(questionAvailable == true) {
        
            if(indexPath.row == 0 && indexPath.section == 0) { //MMQuizMenuCellID
        
                let cell: MMMenuListTVCell = tableView.dequeueReusableCell(withIdentifier: "MMQuizMenuCellID") as! MMMenuListTVCell
            
                // Configure the cell...
            
                //cell.updateCell()
            
                return cell
        
            
            }
            else if(indexPath.row == 0) {
            
                //tableView.estimatedRowHeight = 150.0
            
                let cell: MMImageTransTVCell = tableView.dequeueReusableCell(withIdentifier: "MMImageCellID") as! MMImageTransTVCell
            
                // Configure the cell...
            
                cell.updateCell()
            
                return cell
            
            }
            else {
            
                //tableView.estimatedRowHeight = 120.0
            
                let cell: MMMenuListTVCell = tableView.dequeueReusableCell(withIdentifier: "MMMenuGridCellID") as! MMMenuListTVCell

                // Configure the cell...
        
                cell.updateCell(data: DBMenus.dashboardFrontMenu().object(at: indexPath.row) as! NSDictionary)

                return cell
            
            }
        }
        else {
            
            if(indexPath.row == 0) {
                
                //tableView.estimatedRowHeight = 150.0
                
                let cell: MMImageTransTVCell = tableView.dequeueReusableCell(withIdentifier: "MMImageCellID") as! MMImageTransTVCell
                
                // Configure the cell...
                
                cell.updateCell()
                
                return cell
                
            }
            else {
                
                //tableView.estimatedRowHeight = 120.0
                
                let cell: MMMenuListTVCell = tableView.dequeueReusableCell(withIdentifier: "MMMenuGridCellID") as! MMMenuListTVCell
                
                // Configure the cell...
                
                cell.updateCell(data: DBMenus.dashboardFrontMenu().object(at: indexPath.row) as! NSDictionary)
                
                return cell
                
            }
        }
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        tableView.deselectRow(at: indexPath, animated: true)
        
        if(questionAvailable == true) {
            
            if(indexPath.row == 0 && indexPath.section == 0 && DBWebServices.checkConnectionToDashboard(viewController: self) == true)
            {
                if(self.myQuizVerifiedUser == false) { self.getPhoneAlert(retry:false) }
                else { self.performSegue(withIdentifier: "DB_GOTO_QUIZ", sender: self) }
            }
            else if(indexPath.row == 0 && DBWebServices.checkConnectionToDashboard(viewController: self) == true)
            {
                self.performSegue(withIdentifier: "DB_GOTO_ABOUT", sender: self)
            }
            else if(indexPath.row == 1 && DBWebServices.checkConnectionToDashboard(viewController: self) == true)
            {
                self.performSegue(withIdentifier: "DB_GOTO_MYKOMUNITI", sender: self)
            
            }
            else if(indexPath.row == 2 && DBWebServices.checkConnectionToDashboard(viewController: self) == true)
            {
                self.performSegue(withIdentifier: "DB_GOTO_MYSOAL", sender: self)
            
            }
            else if(indexPath.row == 3 && DBWebServices.checkConnectionToDashboard(viewController: self) == true)
            {
                self.performSegue(withIdentifier: "DB_GOTO_MYSKOOL", sender: self)
            
            }
            else if(indexPath.row == 4 && DBWebServices.checkConnectionToDashboard(viewController: self) == true)
            {
                self.performSegue(withIdentifier: "DB_GOTO_MYHEALTH", sender: self)
            
            }
            else if(indexPath.row == 5 && DBWebServices.checkConnectionToDashboard(viewController: self) == true)
            {
                self.performSegue(withIdentifier: "DB_GOTO_MYSHOP", sender: self)
            
            } else if(indexPath.row == 6 && DBWebServices.checkConnectionToDashboard(viewController: self) == true)
            {
                self.performSegue(withIdentifier: "DB_GOTO_MYPLACES", sender: self)
                
            } else if(indexPath.row == 7 && DBWebServices.checkConnectionToDashboard(viewController: self) == true)
            {
                self.performSegue(withIdentifier: "DB_GOTO_MYGAMES", sender: self)
                
            }
            
        }
        else {
            
            if(indexPath.row == 0 && DBWebServices.checkConnectionToDashboard(viewController: self) == true)
            {
                self.performSegue(withIdentifier: "DB_GOTO_ABOUT", sender: self)
            }
            else if(indexPath.row == 1 && DBWebServices.checkConnectionToDashboard(viewController: self) == true)
            {
                self.performSegue(withIdentifier: "DB_GOTO_MYKOMUNITI", sender: self)
                
            }
            else if(indexPath.row == 2 && DBWebServices.checkConnectionToDashboard(viewController: self) == true)
            {
                self.performSegue(withIdentifier: "DB_GOTO_MYSOAL", sender: self)
                
            }
            else if(indexPath.row == 3 && DBWebServices.checkConnectionToDashboard(viewController: self) == true)
            {
                self.performSegue(withIdentifier: "DB_GOTO_MYSKOOL", sender: self)
                
            }
            else if(indexPath.row == 4 && DBWebServices.checkConnectionToDashboard(viewController: self) == true)
            {
                self.performSegue(withIdentifier: "DB_GOTO_MYHEALTH", sender: self)
                
            }
            else if(indexPath.row == 5 && DBWebServices.checkConnectionToDashboard(viewController: self) == true)
            {
                self.performSegue(withIdentifier: "DB_GOTO_MYSHOP", sender: self)
                
            } else if(indexPath.row == 6 && DBWebServices.checkConnectionToDashboard(viewController: self) == true)
            {
                self.performSegue(withIdentifier: "DB_GOTO_MYPLACES", sender: self)
                
            } else if(indexPath.row == 7 && DBWebServices.checkConnectionToDashboard(viewController: self) == true)
            {
                self.performSegue(withIdentifier: "DB_GOTO_MYGAMES", sender: self)
                
            }
            
        }
    }
    
    func getPhoneAlert(retry: Bool) {
        
        if(retry == true) { self.preferredPhoneNo = "" }
        
        let phoneAlertController: UIAlertController = UIAlertController.init(title: DBStrings.DB_MODULE_MYQUIZ_PHONEASK_TITLE_MS, message: DBStrings.DB_MODULE_MYQUIZ_PHONEASK_DESC_MS, preferredStyle: UIAlertControllerStyle.alert)
        
        let phoneCancelAction: UIAlertAction = UIAlertAction.init(title: DBStrings.DB_BUTTON_CANCEL_LABEL_MS, style: UIAlertActionStyle.default, handler: { action -> Void in phoneAlertController.dismiss(animated: true, completion: nil) })
        phoneAlertController.addAction(phoneCancelAction)
        
        let phoneTNCAction: UIAlertAction = UIAlertAction.init(title: DBStrings.DB_MODULE_MYQUIZ_TNCLABEL_BUTTON_MS, style: UIAlertActionStyle.default, handler: { action -> Void in
            
            UIApplication.shared.open(URL.init(string: DBSettings.myQuizTNCUrl)!, options: [:], completionHandler: nil)
            
            phoneAlertController.dismiss(animated: true, completion: nil)
            
        })
        phoneAlertController.addAction(phoneTNCAction)
        
        let phoneOKAction: UIAlertAction = UIAlertAction.init(title: DBStrings.DB_BUTTON_OK_LABEL_MS, style: UIAlertActionStyle.default, handler: { action -> Void in
            
            self.preferredPhoneNo = String(describing: phoneAlertController.textFields![0].text!).trimmingCharacters(in: NSCharacterSet.whitespaces)
            
            if(self.preferredPhoneNo != "")
            {
                let phoneConfirmAlertController: UIAlertController = UIAlertController.init(title: DBStrings.DB_MODULE_MYQUIZ_PHONECONFIRM_TITLE_MS, message: "\(DBStrings.DB_MODULE_MYQUIZ_PHONECONFIRM_DESC_MS) \(self.preferredPhoneNo)?", preferredStyle: UIAlertControllerStyle.alert)
            
                let phoneNoAction: UIAlertAction = UIAlertAction.init(title: DBStrings.DB_BUTTON_NO_LABEL_MS, style: UIAlertActionStyle.cancel, handler: { action -> Void in
                
                    self.getPhoneAlert(retry: true)
                })
            
                phoneConfirmAlertController.addAction(phoneNoAction)
            
                let phoneYesAction: UIAlertAction = UIAlertAction.init(title: DBStrings.DB_BUTTON_YES_LABEL_MS, style: UIAlertActionStyle.default, handler: { action -> Void in
                    
                    DBWebServices.getMyQuizVerifyUser(token: String(describing: UserDefaults.standard.object(forKey: "SuccessLoggerDashboardToken")!), phoneNo: self.preferredPhoneNo, flag: 1, registeredNotification: self.verifiedEventNotification)
                
                    
                
                })
            
                phoneConfirmAlertController.addAction(phoneYesAction)
                phoneConfirmAlertController.preferredAction = phoneYesAction
            
                self.present(phoneConfirmAlertController, animated: true, completion: nil)
            }
            else {
                self.getPhoneAlert(retry: true)
            }
            
        })
        phoneAlertController.addAction(phoneOKAction)
        phoneAlertController.preferredAction = phoneOKAction
        phoneAlertController.addTextField(configurationHandler: { (textField : UITextField!) -> Void in
            
            textField.placeholder = DBStrings.DB_MODULE_MYQUIZ_PHONEASK_PLACEHOLDER_MS
            textField.keyboardType = UIKeyboardType.numberPad
            
        })
        
        self.present(phoneAlertController, animated: true, completion: nil)

        
    }

    func myQuizVerifyUser(data: NSDictionary) {
        
        //check if user is eligible
        
        if let breakUpObject: NSDictionary = data.value(forKey: "object") as? NSDictionary {
            
            if(breakUpObject.value(forKey: "status") as! Int == 1) {
                
                print("User already Verified")
                
                self.myQuizVerifiedUser = true
            }
            else {
                
                self.myQuizVerifiedUser = false
            }
        } else {
            print("Quiz data nil.")
        }
    }
    
    func myQuizVerifiedUser(data: NSDictionary) {
        
        //verify user after insert phone no
        
        let breakUpObject: NSDictionary = data.value(forKey: "object") as! NSDictionary
        
        if(breakUpObject.value(forKey: "status") as! Int == 1) {
            
            print("Verified")
            
            DispatchQueue.main.async {
                self.performSegue(withIdentifier: "DB_GOTO_QUIZ", sender: self)
            }
            
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
