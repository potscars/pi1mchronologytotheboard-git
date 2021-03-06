//
//  LoginV3VC.swift
//  dashboardv2
//
//  Created by Mohd Zulhilmi Mohd Zain on 18/09/2017.
//  Copyright © 2017 Ingeniworks Sdn Bhd. All rights reserved.
//

import UIKit
import QuartzCore.CALayer

class LoginV3VC: UIViewController, UITextFieldDelegate {
    
    @IBOutlet weak var uitfLV3VCUsername: UITextField!
    @IBOutlet weak var uitfLV3VCPassword: UITextField!
    @IBOutlet weak var uibLV3VCLoginBtn: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow), name: NSNotification.Name.UIKeyboardWillShow, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide), name: NSNotification.Name.UIKeyboardWillHide, object: nil)
        
        let rect: CGRect = CGRect.init(x: 0, y: 0, width: 30, height: 30)
        
        let iconImage: UIImage = #imageLiteral(resourceName: "ic_logincard300.png")
        let iconPassImage: UIImage = #imageLiteral(resourceName: "ic_loginkey300.png")
        
        UIGraphicsBeginImageContext(rect.size)
        iconImage.draw(in: rect)
        let newIconImage: UIImageView = UIImageView.init(image: UIGraphicsGetImageFromCurrentImageContext()?.addImagePadding(x: 16, y: 16))
        UIGraphicsEndImageContext()
        uitfLV3VCUsername.leftView = newIconImage
        uitfLV3VCUsername.leftViewMode = UITextFieldViewMode.always
        
        UIGraphicsBeginImageContext(rect.size)
        iconPassImage.draw(in: rect)
        let newIconPassImage: UIImageView = UIImageView.init(image: UIGraphicsGetImageFromCurrentImageContext()?.addImagePadding(x: 16, y: 16))
        UIGraphicsEndImageContext()
        uitfLV3VCPassword.leftView = newIconPassImage
        uitfLV3VCPassword.leftViewMode = UITextFieldViewMode.always
        uitfLV3VCPassword.isSecureTextEntry = true
        
        uibLV3VCLoginBtn.layer.cornerRadius = 10
        uibLV3VCLoginBtn.clipsToBounds = true
        
        //loginprocess
        uibLV3VCLoginBtn.addTarget(self, action: #selector(gotoLoginProcess(_:)), for: UIControlEvents.touchUpInside)
        
        //debugpurposes
        uitfLV3VCUsername.text = "881015138333"
        uitfLV3VCPassword.text = "password"
        
    }
    
    @objc func gotoLoginProcess(_ sender: UIButton) {
        
        self.performSegue(withIdentifier: "DB_PROCESS_LOGIN", sender: self)
        
    }
    
    @objc func keyboardWillShow(notification: NSNotification) {
        if let keyboardSize = (notification.userInfo?[UIKeyboardFrameBeginUserInfoKey] as? NSValue)?.cgRectValue {
            if self.view.frame.origin.y == 0{
                self.view.frame.origin.y -= keyboardSize.height - 150
            }
        }
    }
    
    @objc func keyboardWillHide(notification: NSNotification) {
        if let keyboardSize = (notification.userInfo?[UIKeyboardFrameBeginUserInfoKey] as? NSValue)?.cgRectValue {
            if self.view.frame.origin.y != 0{
                self.view.frame.origin.y += keyboardSize.height - 150
            }
        }
    }
    
    func textFieldDidBeginEditing(_ textField: UITextField) {
        
        //ZGraphics.moveViewYPosition(view: self.view, yPosition: 100, animationDuration: 0.4, moveToUp: true)
        
        //self.view.frame = CGRect.init(x: 0, y: -110, width: self.view.bounds.width, height: self.view.bounds.height)
        //self.view.frame = CGRect.init(x: 0, y: -110, width: self.view.bounds.width, height: self.view.bounds.height)
        
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        
        uitfLV3VCPassword.endEditing(true)
        
        return true
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
        
        if(segue.identifier == "DB_PROCESS_LOGIN") {
            
            let destinationVC: LoginV3ProcessorVC = segue.destination as! LoginV3ProcessorVC
            destinationVC.fromLogin.sendUserName = uitfLV3VCUsername.text!
            destinationVC.fromLogin.sendPassword = uitfLV3VCPassword.text!
            destinationVC.fromLogin.sendRegID = "1"
            destinationVC.fromLogin.sendIMEI = ZDeviceInfo.getDeviceVendorIdentifier(replaced: false)
            destinationVC.fromLogin.sendOS = DBSettings.dbLoginOS
            
            
        }
        
    }
    

}
