//
//  LoginProcessingVC.swift
//  dashboardv2
//
//  Created by Mohd Zulhilmi Mohd Zain on 06/12/2016.
//  Copyright © 2016 Ingeniworks Sdn Bhd. All rights reserved.
//

import UIKit

class LoginProcessingVC: UIViewController {
    
    var loginData: NSDictionary = [:]
    
    let notificationName = Notification.Name("performLogin")
    let tokenMySoalRetrieval = Notification.Name("tokenForMySoal")
    let tokenMySkoolRetrieval = Notification.Name("tokenForMySkool")

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        NotificationCenter.default.addObserver(self, selector: #selector(loginProcess(data:)), name: notificationName, object: nil)
        
        NotificationCenter.default.addObserver(self, selector: #selector(tokenForMySoal(data:)), name: tokenMySoalRetrieval, object: nil)
        
        NotificationCenter.default.addObserver(self, selector: #selector(tokenForMySkool(data:)), name: tokenMySkoolRetrieval, object: nil)
        
        ZGraphics.applyGradientColorAtView(mainView: self.view, colorSet: DBColorSet.loginColorSet())
        
        print("[LPVC] Calling post with login data \(loginData)...")
        
        DBWebServices.getLoginData(data: loginData, registeredNotification: notificationName.rawValue)
        
    }
    
    @objc func loginProcess(data: NSDictionary)
    {
        print("[LPVC] Processing login with data is \(data)...")
        
        var email = ""
        var fullname = ""
        var icNumber = ""
        var message = ""
        var siteId = ""
        var siteName = ""
        var siteCode = ""
        var token = ""
        
        guard let breakDown = data.value(forKey: "object") as? NSDictionary else {
            print("There is no data available..")
            return
        }
        
        guard let isSuccess = breakDown.value(forKey: "success") as? Int else { return }
        
        if(isSuccess == 1) {
            
            print("[LPVC] Login is success...")
            
            if let tempEmail = breakDown.value(forKey: "email") as? String {
                email = tempEmail
            }
            
            if let tempFullname = breakDown.value(forKey: "full_name") as? String {
                fullname = tempFullname
            }
            
            if let tempIcNumber = breakDown.value(forKey: "ic_no") as? String {
                icNumber = tempIcNumber
            }
            
            if let tempMessage = breakDown.value(forKey: "message") as? String {
                message = tempMessage
            }
            
            if let tempSiteId = breakDown.value(forKey: "site_id") as? String {
                siteId = tempSiteId
            }
            
            if let tempSiteName = breakDown.value(forKey: "site_name") as? String {
                siteName = tempSiteName
            }
            
            if let tempSiteCode = breakDown.value(forKey: "sitecode") as? String {
                siteCode = tempSiteCode
            }
            
            if let tempToken = breakDown.value(forKey: "token") as? String {
                token = tempToken
            }
            
            UserDefaults.standard.set(true, forKey: "SuccessLoggerIsLogin")
            UserDefaults.standard.set( email, forKey: "SuccessLoggerEmail")
            UserDefaults.standard.set( fullname, forKey: "SuccessLoggerFullName")
            UserDefaults.standard.set( icNumber, forKey: "SuccessLoggerICNo")
            UserDefaults.standard.set( message, forKey: "SuccessLoggerMessage")
            UserDefaults.standard.set( siteId, forKey: "SuccessLoggerSiteID")
            UserDefaults.standard.set( siteName, forKey: "SuccessLoggerSiteName")
            UserDefaults.standard.set( siteCode, forKey: "SuccessLoggerSiteCode")
            UserDefaults.standard.set(isSuccess, forKey: "SuccessLoggerLoginStatus")
            UserDefaults.standard.set( token, forKey: "SuccessLoggerDashboardToken")
            
            //Perform to get MySoal Token
            DBWebServices.getMySoalToken(registeredNotification: tokenMySoalRetrieval.rawValue)
            DBWebServices.getMySkoolToken(registeredNotification: tokenMySkoolRetrieval.rawValue)
            
            //Set Default settings if not available
            if(UserDefaults.standard.object(forKey: "SuccessLoggerSettingsRememberMe") == nil)
            {
                UserDefaults.standard.set(true, forKey: "SuccessLoggerSettingsRememberMe")
            }
            
            if(UserDefaults.standard.object(forKey: "SuccessLoggerSettingsLanguage") == nil)
            {
                UserDefaults.standard.set("MY", forKey: "SuccessLoggerSettingsLanguage")
            }
            
            if(UserDefaults.standard.object(forKey: "SuccessLoggerSettingsModuleSelected") == nil)
            {
                UserDefaults.standard.set(AppDelegate.moduleAvailable, forKey: "SuccessLoggerSettingsModuleSelected")
            }
            
        }
        else {
            
            print("[LPVC] Login has error...")
            
            UserDefaults.standard.set(false, forKey: "SuccessLoggerIsLogin")
            UserDefaults.standard.set(false, forKey: "RememberLogger")
            UserDefaults.standard.set(breakDown.value(forKey: "message"), forKey: "FailedLoggerMessage")
            UserDefaults.standard.set(isSuccess, forKey: "FailedLoggerLoginStatus")
            
            ZUIs.showOKDialogBox(viewController: self, dialogTitle: DBStrings.DB_PROCESS_ERROR_TITLE_MS, dialogMessage: DBStrings.DB_PROCESS_ERROR_DESC_MS, afterDialogDismissed: "BACK_TO_PREVIOUS_VIEWCONTROLLER")
 
        }
        
        NotificationCenter.default.removeObserver(self, name: notificationName, object: nil);
    }
    
    @objc func tokenForMySoal(data: NSDictionary)
    {
        let breakDown = data.value(forKey: "object") as! NSDictionary
        
        UserDefaults.standard.set(breakDown.value(forKey: "token"), forKey: "SuccessLoggerMySoalToken")
        
        NotificationCenter.default.removeObserver(self, name: tokenMySoalRetrieval, object: nil);
        
    }
    
    @objc func tokenForMySkool(data: NSDictionary)
    {
        let breakDown = data.value(forKey: "object") as! NSDictionary
        
        UserDefaults.standard.set(breakDown.value(forKey: "token"), forKey: "SuccessLoggerMySkoolToken")
        
        NotificationCenter.default.removeObserver(self, name: tokenMySkoolRetrieval, object: nil);
        
        self.finalizingToMainMenu()
    }
    
    func finalizingToMainMenu() {
        
        UserDefaults.standard.set(true, forKey: "RememberLogger")
        self.performSegue(withIdentifier: "DB_GOTO_MAINMENU", sender: self)
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    
    // MARK: - Navigation
    /*
    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
        
        if(segue.identifier == "DB_GOTO_MAINMENU") {
            
            /*
            let mainMenu: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
            let mainMenuTVC: AfterLoginNC = mainMenu.instantiateViewController(withIdentifier: "AfterLoginStoryBoard") as! AfterLoginNC
            let appDelegate: AppDelegate = UIApplication.shared.delegate as! AppDelegate

            appDelegate.window?.rootViewController = mainMenuTVC
             */
            
            let destinationVC: AfterLoginNC = segue.destination as! AfterLoginNC
        }
        
    }
    */

}
