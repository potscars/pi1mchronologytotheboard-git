//
//  DBWebServices.swift
//  dashboardv2
//
//  Created by Mohd Zulhilmi Mohd Zain on 06/12/2016.
//  Copyright © 2016 Ingeniworks Sdn Bhd. All rights reserved.
//

import UIKit
//import PlainPing

class DBWebServices: NSObject {
    
    static func checkConnectionToDashboard(viewController: AnyObject) -> Bool {
        
        if(ZNetwork.isConnectedToNetwork() == false)
        {
            print("[Libraries] No internet connection.")
            
            let alert = UIAlertController(title: "Masalah", message: "Sambungan Internet gagal. Sila periksa sambungan Internet anda.", preferredStyle: UIAlertControllerStyle.alert)
            alert.addAction(UIAlertAction(title: "OK", style: UIAlertActionStyle.default, handler: {(action: UIAlertAction) -> Void in
                
            }))
            
            viewController.parent!!.present(alert, animated: true, completion: nil)
            
            return false
        }
        else
        {
            print("[Libraries] Has internet connection.")
            
//            PlainPing.ping("http://dashboard.pi1m.my", withTimeout: 1.0, completionBlock: {(timeElapsed:Double?, error:Error?) in
//
//                if let latency = timeElapsed {
//
//                    print("[DBWebServices] Ping detected in elapsed time \(latency)...")
//
//                }
//                else if let error = error {
//
//                    print("[DBWebServices] Ping error: \(error.localizedDescription)")
//
//                }
//
//            })
            
            return true
        }
        
    }
    
    @objc static func getLoginData(data: NSDictionary, registeredNotification: String) {
        
        let getLoginURL = NSURL.init(string: DBSettings.loginURL)
        let getLoginParams = String.init(format: "username=%@&password=%@&regid=%@&imei=%@&os=%@", data.value(forKey: "USERNAME") as! String,data.value(forKey: "PASSWORD") as! String,data.value(forKey: "REGISTERED_ID") as! String,ZDeviceInfo.getDeviceVendorIdentifier(replaced: false),DBSettings.dbLoginOS)
        
        _ = ZNetwork.performPostData(url: getLoginURL!, parameters: getLoginParams, contentType: ZNetwork.ContentTypeXWWWFormUrlEncoded, includeContentLength: false, notificationName: registeredNotification)
        
    }
    
    static func getMyKomunitiAdminFeed(page: Int, registeredNotification: String) {
        
        //http://dashboard.pi1m.my/api/announcement/hq-announcements/{dash_token}/{dataperpage}
        
        let dashToken = UserDefaults.standard.object(forKey: "SuccessLoggerDashboardToken") as! String
        
        let getFeedParams = String(format: "%@/%@", dashToken, String(page))
        let getFeedURL = NSURL.init(string: "\(DBSettings.myKomunitiAdminURL)\(getFeedParams)")
        
        print("[DBWebServices] URL set: ",getFeedURL ?? "")
        
        _ = ZNetwork.performGetData(urlWithParameters: getFeedURL!, notificationName: registeredNotification)
    }
    
    
    static func getMyKomunitiPublicFeed(page: Int, registeredNotification: String) {
        
        //http://dashboard.pi1m.my/api/announcement/user-announcements/{dash_token}?page=1
        
        let dashToken = UserDefaults.standard.object(forKey: "SuccessLoggerDashboardToken") as! String
        print("MyKomuniti dashToken: \(dashToken)")
        
        let getFeedParams = String(format: "%@?page=%@", dashToken, String(page))
        let getFeedURL = NSURL.init(string: "\(DBSettings.myKomunitiPublicURL)\(getFeedParams)")
        
        print("[DBWebServices] URL set: ",getFeedURL ?? "")
        
        _ = ZNetwork.performGetData(urlWithParameters: getFeedURL!, notificationName: registeredNotification)
    }
    
    static func postMyKomunitiPostAnnouncement(viewController: UIViewController, title: String, contentMessage: String) {
        
        let spinner = LoadingSpinner.init(view: viewController.view, isNavBar: true)
        spinner.setLoadingScreen()
        
        let dbToken = UserDefaults.standard.object(forKey: "SuccessLoggerDashboardToken") as! String
        let url = URL(string: DBSettings.myKomunitiPostAnnouncement)!
        
        var params: [String: Any] = [:]
        params["token"] = dbToken
        params["title"] = title
        params["content"] = contentMessage
        
        DispatchQueue.global(qos: .default).async {
            
            ZNetwork.performPostRequest(url: url, params: params) { (responses) in
                
                if let status = responses["status"] as? Int {
                    
                    print("Status: \(responses)")
                    
                    DispatchQueue.main.async {
                        
                        spinner.removeLoadingScreen()
                        
                        if status == 1 {
                            
                            self.alertNotification(viewController, title: "Success!", message: "Successfully added.")
                        } else {
                            
                            self.alertNotification(viewController, title: "Warning!", message: "Failed to add announcement.")
                        }
                    }
                }
            }
        }
    }
    
    static func alertNotification(_ viewController: UIViewController, title: String, message: String) {
        
        let alertController = UIAlertController(title: title, message: message, preferredStyle: .alert)
        
        let okayButton = UIAlertAction(title: "Okay", style: .default) { (action) in
            
            viewController.navigationController?.popViewController(animated: true)
        }
        
        alertController.addAction(okayButton)
        
        viewController.present(alertController, animated: true, completion: nil)
    }
    
    static func getMySoalToken(registeredNotification: String) {
        
        let dashToken = UserDefaults.standard.object(forKey: "SuccessLoggerDashboardToken") as! String
        
        let getLoginURL = NSURL.init(string: DBSettings.mySoalTokenRetrievalURL)!
        let getLoginParams = String(format: "dash_token=%@", dashToken)
        
        _ = ZNetwork.performPostData(url: getLoginURL, parameters: getLoginParams, contentType: ZNetwork.ContentTypeXWWWFormUrlEncoded, includeContentLength: true, notificationName: registeredNotification)
    }
    
    static func getMySoalFeed(tokenForMySoal: String, page: Int, registeredNotification: String) {
        
        let getMySoalURL = NSURL.init(string: "\(DBSettings.mySoalPetiMasukURL)/page:\(page)")!
        let getMySoalData = String(format: "token=%@", tokenForMySoal)
        
        ZNetwork.performPostData(url: getMySoalURL, parameters: getMySoalData, contentType: ZNetwork.ContentTypeXWWWFormUrlEncoded, includeContentLength: false, notificationName: registeredNotification)
        
    }
    
    static func getMySkoolToken(registeredNotification: String) {
        
        let dashToken = UserDefaults.standard.object(forKey: "SuccessLoggerDashboardToken") as! String
        
        let getLoginURL = NSURL.init(string: DBSettings.mySkoolTokenRetrievalURL)!
        let getLoginParams = String(format: "dash_token=%@", dashToken)
        
        ZNetwork.performPostData(url: getLoginURL, parameters: getLoginParams, contentType: ZNetwork.ContentTypeXWWWFormUrlEncoded, includeContentLength: true, notificationName: registeredNotification)
    }
    
    static func getMySkoolInboxFeed(tokenForMySkool: String, page: Int, registeredNotification: String) {
        
        let getFeedParams = String(format: "%@/page:%@", tokenForMySkool, String(page))
        let getFeedURL = NSURL.init(string: "\(DBSettings.mySkoolPetiMasukURL)\(getFeedParams)")
        
        print("[DBWebServices] URL set: ",getFeedURL ?? "")
        
        ZNetwork.performGetData(urlWithParameters: getFeedURL!, notificationName: registeredNotification)
    }
    
    static func getMyHealthBPFeed(page: Int, registeredNotification: String) {
        
        let dashToken = UserDefaults.standard.object(forKey: "SuccessLoggerDashboardToken") as! String
        
        let getFeedParams = String(format: "%@/page=%@", dashToken, String(page))
        let getFeedURL = NSURL.init(string: "\(DBSettings.myHealthBPURL)\(getFeedParams)")
        
        print("[DBWebServices] URL set: ",getFeedURL ?? "")
        
        ZNetwork.performGetData(urlWithParameters: getFeedURL!, notificationName: registeredNotification)
    }
    
    static func getMyHealthBWFeed(page: Int, registeredNotification: String) {
        
        let dashToken = UserDefaults.standard.object(forKey: "SuccessLoggerDashboardToken") as! String
        
        let getFeedParams = String(format: "%@/page=%@", dashToken, String(page))
        let getFeedURL = NSURL.init(string: "\(DBSettings.myHealthBWURL)\(getFeedParams)")
        
        print("[DBWebServices] URL set: ",getFeedURL ?? "")
        
        ZNetwork.performGetData(urlWithParameters: getFeedURL!, notificationName: registeredNotification)
    }
    
    static func getMyShopLatestProdFeed(page: Int, registeredNotification: String) {
        
        let getFeedParams = String(format: "?page=%@", String(page))
        let getFeedURL = NSURL.init(string: "\(DBSettings.myShopLatestProductURL)\(getFeedParams)")
        
        print("[DBWebServices] URL set: ",getFeedURL ?? "")
        
        ZNetwork.performGetData(urlWithParameters: getFeedURL!, notificationName: registeredNotification)
    }
    
    static func getMyShopPopularProdFeed(page: Int, registeredNotification: String) {
        
        let getFeedParams = String(format: "?page=%@", String(page))
        let getFeedURL = NSURL.init(string: "\(DBSettings.myShopPopularProductURL)\(getFeedParams)")
        
        print("[DBWebServices] URL set: ",getFeedURL ?? "")
        
        ZNetwork.performGetData(urlWithParameters: getFeedURL!, notificationName: registeredNotification)
    }
    
    static func getMyShopHiRatingProdFeed(page: Int, registeredNotification: String) {
        
        let getFeedParams = String(format: "?page=%@", String(page))
        let getFeedURL = NSURL.init(string: "\(DBSettings.myShopHiRatingProductURL)\(getFeedParams)")
        
        print("[DBWebServices] URL set: ",getFeedURL ?? "")
        
        ZNetwork.performGetData(urlWithParameters: getFeedURL!, notificationName: registeredNotification)
    }
    
    static func getMyShopLocalProdFeed(registeredNotification: String) {
        
        let dashToken = UserDefaults.standard.object(forKey: "SuccessLoggerDashboardToken") as! String
        
        let getFeedParams = String(format: "?token=%@", dashToken)
        let getFeedURL = NSURL.init(string: "\(DBSettings.myShopLocalProductURL)\(getFeedParams)")
        
        print("[DBWebServices] URL set: ",getFeedURL ?? ""," and Token: ",dashToken )
        
        ZNetwork.performGetData(urlWithParameters: getFeedURL!, notificationName: registeredNotification)
    }
    
    static func getMyShopProductDetails(productID: Int, registeredNotification: String) {
        
        let getFeedParams = String(format: "%@", String(productID))
        let getFeedURL = NSURL.init(string: "\(DBSettings.myShopProductDetailsURL)/\(getFeedParams)")
        
        print("[DBWebServices] URL set: ",getFeedURL ?? "")
        
        ZNetwork.performGetData(urlWithParameters: getFeedURL!, notificationName: registeredNotification)
    }
    
    //MARK: - MyQuiz
    
    static func getMyQuizGetQuestions(token: String, registeredNotification: String) {
        
        let getTokenParams = String(format: "%@", token)
        let getTokenURL = NSURL.init(string: "\(DBSettings.myQuizGetQuestionURL)/\(getTokenParams)")
        
        print("[DBWebServices] Token params",getTokenParams," URL set: ",getTokenURL?.description ?? "")
        
        ZNetwork.performGetData(urlWithParameters: getTokenURL!, notificationName: registeredNotification)
    }
    
    static func getMyQuizSendAnswers(token: String, data: NSDictionary, registeredNotification: String) {
        
        let myQuizAnswerURL = NSURL.init(string: "\(DBSettings.myQuizSendAnswerURL)/\(token)")!
        
        ZNetwork.performPostDictionaryObject(url: myQuizAnswerURL, parameters: data, contentType: ZNetwork.ContentTypeJSON, notificationName: registeredNotification)
    }
    
    static func getMyQuizVerifyEvent(token: String, registeredNotification: String) {
        
        let myQuizAnswerURL = NSURL.init(string: "\(DBSettings.myQuizVerifyUserAndEvent)/\(token)")!
        
        ZNetwork.performGetData(urlWithParameters: myQuizAnswerURL, notificationName: registeredNotification)
    }
    
    static func getMyQuizVerifyUser(token: String, phoneNo: String, flag: Int, registeredNotification: String) {
        
        let myQuizAnswerURL = NSURL.init(string: "\(DBSettings.myQuizVerifyUserAndEvent)")!
        let myQuizParams = String(format: "phone=%@&verify=%@&token=%@", String(describing: phoneNo), String(describing: flag), String(describing: token))
        
        print("[DBWebServices] Check params: ",myQuizParams ?? "")
        
        ZNetwork.performPostData(url: myQuizAnswerURL, parameters: myQuizParams, contentType: ZNetwork.ContentTypeXWWWFormUrlEncoded, includeContentLength: true, notificationName: registeredNotification)
    }
}
















