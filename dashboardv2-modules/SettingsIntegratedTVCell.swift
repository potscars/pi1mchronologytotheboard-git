//
//  SettingsIntegratedTVCell.swift
//  dashboardv2
//
//  Created by Mohd Zulhilmi Mohd Zain on 15/02/2017.
//  Copyright © 2017 Ingeniworks Sdn Bhd. All rights reserved.
//

import UIKit

class SettingsIntegratedTVCell: UITableViewCell {

    @IBOutlet weak var uilSITVCSwitchTypeTitle: UILabel!
    @IBOutlet weak var uilSITVCSwitchTypeDesc: UILabel!
    @IBOutlet weak var uisSITVCSwitchTypeSwitch: UISwitch!
    var userDefaultsString: String = ""
    
    @IBOutlet weak var uilSITVCSingleNormTitle: UILabel!
    
    @IBOutlet weak var uilSITVCSingleWarnTitle: UILabel!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func updateCellSwitchType(title: String, description: String, userDefaultsStandardObjectKey: String) {
        
        userDefaultsString = userDefaultsStandardObjectKey
        
        if(UserDefaults.standard.object(forKey: userDefaultsString) as! Bool == false) {
            
            uisSITVCSwitchTypeSwitch.setOn(false, animated: true)
            
        }
        else {
            
            uisSITVCSwitchTypeSwitch.setOn(true, animated: true)
            
        }
        
        uilSITVCSwitchTypeTitle.text = title
        uilSITVCSwitchTypeDesc.text = description
        uisSITVCSwitchTypeSwitch.addTarget(self, action: #selector(switchSelector(sender:)), for: .valueChanged)
        
        
    }
    
    @objc func switchSelector(sender: UISwitch)
    {
        if(sender.isOn){
            
            UserDefaults.standard.set(true, forKey: userDefaultsString)
            
        }
        else {
            
            UserDefaults.standard.set(false, forKey: userDefaultsString)
            
        }
    }
    
    func updateCellNormalType(title: String) {
        
        uilSITVCSingleNormTitle.text = title
        
    }
    
    func updateCellWarningType(viewController: UIViewController, title: String, message: String) {
        
        uilSITVCSingleWarnTitle.text = title
        
        let warningActionSheet: UIAlertController = UIAlertController(title: title, message: message, preferredStyle: .actionSheet)
        
        let noAction: UIAlertAction = UIAlertAction(title: "Tidak", style: .default, handler: { (action) in warningActionSheet.dismiss(animated: true, completion: {}) })
        
        let yesAction: UIAlertAction = UIAlertAction(title: "YA", style: .destructive, handler: { (action) in
        
            self.logoutApp(viewController: viewController)
            
        })
        
        warningActionSheet.addAction(noAction)
        warningActionSheet.addAction(yesAction)
        
        viewController.present(warningActionSheet, animated: true, completion: {})
    }
    
    func logoutApp(viewController: UIViewController)
    {
        // _ = viewController.navigationController?.popToRootViewController(animated: true)
        
        let mainMenu: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
        let loginNC: BeforeLoginNC = mainMenu.instantiateViewController(withIdentifier: "BeforeLoginStoryBoard") as! BeforeLoginNC
        let appDelegate: AppDelegate = UIApplication.shared.delegate as! AppDelegate
        
        //appDelegate.window?.rootViewController = loginNC
        
        UserDefaults.standard.set(false, forKey: "SuccessLoggerIsLogin")
        
        viewController.performSegue(withIdentifier: "DB_GOTO_BEFORELOGIN", sender: self)
        //_ = viewController.navigationController?.popToRootViewController(animated: true)
    }
    

}
