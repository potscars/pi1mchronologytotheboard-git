//
//  AppDelegate.swift
//  dashboardv2
//
//  Created by Mohd Zulhilmi Mohd Zain on 25/11/2016.
//  Copyright © 2016 Ingeniworks Sdn Bhd. All rights reserved.
//

import UIKit
import GoogleMaps
import GooglePlaces

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?
    static var mainMenuController: UIViewController?
    static var loginController: UIViewController?
    static var moduleAvailable: NSArray = ["MODULE_MYKOMUNITI","MODULE_MYSOAL","MODULE_MYSKOOL","MODULE_MYHEALTH","MODULE_MYSHOP"]
    let googleMapsAPIKey = "AIzaSyBdOuF3hHPCIwMzsY-sXp6sSIiiMWnsxyU"

    //MyQuiz
    var answeredQuestion: NSMutableArray? = nil
    var quizSubmitted: Bool = false
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        
        UIApplication.shared.statusBarStyle = UIStatusBarStyle.lightContent
        
        UINavigationBar.appearance().titleTextAttributes = [ NSFontAttributeName : UIFont(name: "Arial-BoldMT", size : 20.0)!, NSForegroundColorAttributeName : UIColor.white]
        UITabBar.appearance().tintColor = UIColor.white
        
        listingAllFontNames()
        
        GMSServices.provideAPIKey(googleMapsAPIKey)
        GMSPlacesClient.provideAPIKey(googleMapsAPIKey)
        
        self.answeredQuestion = NSMutableArray.init()
        
        return true
    }
    
    func listingAllFontNames() {
        
        for familyName in UIFont.familyNames {
            
            for fontName in UIFont.fontNames(forFamilyName: familyName) {
                
                print("[AppDelegate] Family font name to use: \(fontName)")
                
            }
        }
        
    }

    func applicationWillResignActive(_ application: UIApplication) {
        // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
        // Use this method to pause ongoing tasks, disable timers, and invalidate graphics rendering callbacks. Games should use this method to pause the game.
    }

    func applicationDidEnterBackground(_ application: UIApplication) {
        // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
        // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
    }

    func applicationWillEnterForeground(_ application: UIApplication) {
        // Called as part of the transition from the background to the active state; here you can undo many of the changes made on entering the background.
    }

    func applicationDidBecomeActive(_ application: UIApplication) {
        // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
    }

    func applicationWillTerminate(_ application: UIApplication) {
        // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
    }


}

