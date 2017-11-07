//
//  BeforeLoginNC.swift
//  dashboardv2
//
//  Created by Mohd Zulhilmi Mohd Zain on 27/12/2016.
//  Copyright © 2016 Ingeniworks Sdn Bhd. All rights reserved.
//

import UIKit

class BeforeLoginNC: UINavigationController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        let getUserDefaults: UserDefaults? = UserDefaults.standard
        let getRememberData: Bool? = getUserDefaults?.object(forKey: "SuccessLoggerSettingsRememberMe") as? Bool
        let getLoggedInData: Bool? = getUserDefaults?.object(forKey: "SuccessLoggerIsLogin") as? Bool
        
        if(getRememberData == true && getLoggedInData == true)
        {
            print("[BeforeLoginNC] User remembered")
            
            // Apabila user da log masuk sebelum ini dan seting remember me
            // disetkan, terus jadikan AfterLoginNC sebagai rootviewcontroller
            
            let mainMenu: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
            let mainMenuTVC: AfterLoginNC = mainMenu.instantiateViewController(withIdentifier: "AfterLoginStoryBoard") as! AfterLoginNC
            let appDelegate: AppDelegate = UIApplication.shared.delegate as! AppDelegate
            
            appDelegate.window?.rootViewController = mainMenuTVC
        }
        else if(getRememberData == false || getLoggedInData == false)
        {
            print("[BeforeLoginNC] User not remembered")
            
            // Apabila user da log masuk sebelum ini dan seting remember me tak
            // disetkan, user perlu login semula. Tiada tindakan diambil.
            
            resetAllData()
            
        }
        else
        {
            print("[BeforeLoginNC] First time login")
            
            // User buka app buat pertama kali atau reset app data. 
            // Tiada tindakan diambil.
            
            resetAllData()
            UserDefaults.standard.set(true, forKey: "SuccessLoggerSettingsRememberMe")
        }
    }
    
    func resetAllData() {
        
        UserDefaults.standard.set(false, forKey: "SuccessLoggerIsLogin")
        UserDefaults.standard.set(nil, forKey: "SuccessLoggerEmail")
        UserDefaults.standard.set(nil, forKey: "SuccessLoggerFullName")
        UserDefaults.standard.set(nil, forKey: "SuccessLoggerICNo")
        UserDefaults.standard.set(nil, forKey: "SuccessLoggerMessage")
        UserDefaults.standard.set(nil, forKey: "SuccessLoggerSiteID")
        UserDefaults.standard.set(nil, forKey: "SuccessLoggerSiteName")
        UserDefaults.standard.set(nil, forKey: "SuccessLoggerSiteCode")
        UserDefaults.standard.set(nil, forKey: "SuccessLoggerLoginStatus")
        UserDefaults.standard.set(nil, forKey: "SuccessLoggerDashboardToken")
        UserDefaults.standard.set(["MODULE_MYKOMUNITI","MODULE_MYSOAL","MODULE_MYSKOOL","MODULE_MYHEALTH","MODULE_MYSHOP"], forKey: "SuccessLoggerSettingsModuleSelected")
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
