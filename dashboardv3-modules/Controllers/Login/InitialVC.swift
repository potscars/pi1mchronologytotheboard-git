//
//  InitialVC.swift
//  dashboardv2
//
//  Created by Mohd Zulhilmi Mohd Zain on 08/11/2017.
//  Copyright © 2017 Ingeniworks Sdn Bhd. All rights reserved.
//

import UIKit

class InitialVC: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        //let loggedIn: Bool? = UserDefaults.standard.object(forKey: "SuccessLoggerIsLogin") as? Bool ?? false
        
        if(ChangeSettingsValue.loggedIn == true) {
        
            switch ChangeSettingsValue.rememberMe {
            
            case nil:
                self.notLoggedInVC()
                break
                
            case false:
                self.notLoggedInVC()
                break
                
            case true:
                self.loggedInVC()
                break
            
            }
        }
        else {
            self.notLoggedInVC()
        }
    }
    
    func notLoggedInVC()
    {
        let getStoryBoard: UIStoryboard = UIStoryboard.init(name: "MainV3", bundle: nil)
        let viewController: BeforeLoginV3NC = getStoryBoard.instantiateViewController(withIdentifier: "NotLoggedInV3NC") as! BeforeLoginV3NC
        let appDel: AppDelegate = UIApplication.shared.delegate as! AppDelegate
        appDel.window?.rootViewController = viewController
    }
    
    func loggedInVC()
    {
        let getStoryBoard: UIStoryboard = UIStoryboard.init(name: "MainV3", bundle: nil)
        let viewController: AfterLoginV3NC = getStoryBoard.instantiateViewController(withIdentifier: "LoggedInV3NC") as! AfterLoginV3NC
        let appDel: AppDelegate = UIApplication.shared.delegate as! AppDelegate
        appDel.window?.rootViewController = viewController
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
