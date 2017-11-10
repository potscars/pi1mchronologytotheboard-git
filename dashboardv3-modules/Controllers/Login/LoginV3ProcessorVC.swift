//
//  LoginV3ProcessorVC.swift
//  dashboardv2
//
//  Created by Mohd Zulhilmi Mohd Zain on 07/11/2017.
//  Copyright © 2017 Ingeniworks Sdn Bhd. All rights reserved.
//

import UIKit
import NVActivityIndicatorView

class LoginV3ProcessorVC: UIViewController {
    
    var count: Int = 0
    let fromLogin: LoginDataParams = LoginDataParams.init()
    
    override func loadView() {
        super.loadView()
        
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        let xAxis = self.view.center.x
        let yAxis = self.view.center.y
        let setLoadingFrame = CGRect.init(x: xAxis - 30, y: yAxis - 30, width: 50, height: 50)
        let setTextFrame = CGRect.init(x: xAxis - 65, y: yAxis + 30, width: 140, height: 30)
        let nvIndicator: NVActivityIndicatorView = NVActivityIndicatorView.init(frame: setLoadingFrame, type: NVActivityIndicatorType.ballGridBeat, color: DBColorSet.dashboardV3_MinorColor, padding: nil)
        nvIndicator.backgroundColor = UIColor.clear
        let textView: UITextView = UITextView.init(frame: setTextFrame)
        textView.text = "Sedang memuatkan..."
        textView.backgroundColor = UIColor.clear
        
        self.view.addSubview(nvIndicator)
        self.view.addSubview(textView)
        nvIndicator.startAnimating()
        
        DispatchQueue.main.async {
            
            let nprocess: LoginProcess = LoginProcess.init(withURL: DBSettings.loginURL)
            let dataGot: LoginDataRetrieved = nprocess.processLoginData(parameters: self.fromLogin)
            
            
            if dataGot.status == 1 {
                
                self.insertIntoDefaults(data: dataGot)
                
                let mySoalTokenProcess: MySoalProcess = MySoalProcess.init(withURL: DBSettings.mySkoolTokenRetrievalURL)
                let sendDashTokenMySoal: MySoalDataParams = MySoalDataParams.init()
                sendDashTokenMySoal.dashboardToken = dataGot.userToken
                let mySoalGotToken: MySoalDataRetrieval = mySoalTokenProcess.processMySoalToken(parameters: sendDashTokenMySoal)
                
                if mySoalGotToken.tokenMySoal != "N/A" { self.insertMySoalToken(data: mySoalGotToken) } else { }
                
                let mySkoolTokenProcess: MySkoolProcess = MySkoolProcess.init(withURL: DBSettings.mySkoolTokenRetrievalURL)
                let sendDashTokenMySkool: MySkoolDataParams = MySkoolDataParams.init()
                sendDashTokenMySkool.dashboardToken = dataGot.userToken
                let mySkoolGotToken: MySkoolDataRetrieval = mySkoolTokenProcess.processMySkoolToken(parameters: sendDashTokenMySkool)
                
                if mySkoolGotToken.tokenMySkool != "N/A" { self.insertMySkoolToken(data: mySkoolGotToken) } else { }
                
            } else {
                
                self.failedToLogin(data: dataGot)
                
            }
            
        }
        
    }
    
    func insertIntoDefaults(data: LoginDataRetrieved) {
        
        print("Login Got")
        
        UserDefaults.standard.set(true, forKey: "SuccessLoggerIsLogin")
        UserDefaults.standard.set(data.userEmail, forKey: "SuccessLoggerEmail")
        UserDefaults.standard.set(data.userFullName, forKey: "SuccessLoggerFullName")
        UserDefaults.standard.set(data.userICNo, forKey: "SuccessLoggerICNo")
        UserDefaults.standard.set(data.serverMessage, forKey: "SuccessLoggerMessage")
        UserDefaults.standard.set(data.userSiteID, forKey: "SuccessLoggerSiteID")
        UserDefaults.standard.set(data.userSiteName, forKey: "SuccessLoggerSiteName")
        UserDefaults.standard.set(data.userSiteCode, forKey: "SuccessLoggerSiteCode")
        UserDefaults.standard.set(data.status, forKey: "SuccessLoggerLoginStatus")
        UserDefaults.standard.set(data.userToken, forKey: "SuccessLoggerDashboardToken")
        
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
        
        count = count + 1
        self.validToGoMainMenu(count: self.count)
        
    }
    
    func insertMySoalToken(data: MySoalDataRetrieval) {
        
        print("MySoal Token got")
        
        UserDefaults.standard.set(data.tokenMySoal, forKey: "SuccessLoggerMySoalToken")
        
        count = count + 1
        self.validToGoMainMenu(count: self.count)
        
    }
    
    func insertMySkoolToken(data: MySkoolDataRetrieval) {
        
        print("MySkool Token got")
        
        UserDefaults.standard.set(data.tokenMySkool, forKey: "SuccessLoggerMySkoolToken")
        
        count = count + 1
        self.validToGoMainMenu(count: self.count)
        
    }
    
    func failedToLogin(data: LoginDataRetrieved) {
        
        UserDefaults.standard.set(false, forKey: "SuccessLoggerIsLogin")
        UserDefaults.standard.set(false, forKey: "RememberLogger")
        UserDefaults.standard.set(data.serverMessage, forKey: "FailedLoggerMessage")
        UserDefaults.standard.set(data.status, forKey: "FailedLoggerLoginStatus")
        
        ZUIs.showOKDialogBox(viewController: self, dialogTitle: DBStrings.DB_PROCESS_ERROR_TITLE_MS, dialogMessage: String.init(format: "%@ (%@)", DBStrings.DB_PROCESS_ERROR_DESC_MS, data.serverMessage), afterDialogDismissed: "BACK_TO_PREVIOUS_VIEWCONTROLLER")
        
    }
    
    func failedToGetMySoalToken(data: MySoalDataRetrieval) {
        
        ZUIs.showOKDialogBox(viewController: self, dialogTitle: DBStrings.DB_PROCESS_ERROR_TITLE_MS, dialogMessage: String.init(format: "%@ (%@)", DBStrings.DB_MODULE_MYSOAL_TOKEN_FAILED_MS, data.tokenErrorMessage), afterDialogDismissed: nil)
        
        count = count + 1
        self.validToGoMainMenu(count: self.count)
        
    }
    
    func failedToGetMySkoolToken(data: MySkoolDataRetrieval) {
        
        ZUIs.showOKDialogBox(viewController: self, dialogTitle: DBStrings.DB_PROCESS_ERROR_TITLE_MS, dialogMessage: String.init(format: "%@ (%@)", DBStrings.DB_MODULE_MYSKOOL_TOKEN_FAILED_MS, data.tokenErrorMessage), afterDialogDismissed: nil)
        
        count = count + 1
        self.validToGoMainMenu(count: self.count)
        
    }
    
    func validToGoMainMenu(count: Int) {
        
        if count == 3 { self.performSegue(withIdentifier: "DB_GOTO_MAINMENU", sender: self) }
        
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
