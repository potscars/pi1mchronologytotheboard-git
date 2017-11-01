//
//  LoginVC.swift
//  dashboardv2
//
//  Created by Mohd Zulhilmi Mohd Zain on 25/11/2016.
//  Copyright © 2016 Ingeniworks Sdn Bhd. All rights reserved.
//

import UIKit

class LoginViewController: UIViewController, UITextFieldDelegate {

    @IBOutlet weak var uilLVCLoginLabel: UILabel!
    @IBOutlet weak var uitfLVCLoginField: UITextField!
    @IBOutlet weak var uilLVCLoginDesc: UILabel!
    @IBOutlet var uivLVCMainView: UIView!
    
    var dbUserName: String = ""
    var dbPassword: String = ""
    var dbDataAcquire: String = "USERNAME"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        AppDelegate.loginController = self
        
        let gestureRecognizer: UITapGestureRecognizer = UITapGestureRecognizer.init(target: self, action: #selector(keyboardHide))
        
        self.view.addGestureRecognizer(gestureRecognizer)
        
        ZGraphics.applyGradientColorAtView(mainView: self.view, colorSet: DBColorSet.loginColorSet())
        
        self.applyLanguage(selectedLang: "MS")
        
    }
    
    @objc func keyboardHide(recognizer:UITapGestureRecognizer)
    {
        print("[LVC] Hiding keyboard...")
        self.view.endEditing(true)
    }
    
    @IBAction func loginAction(_ sender: UIButton) {
        
        if(dbDataAcquire != "PASSWORD") {
            
            print("[LVC] Still requiring input...")
            
            getUserData(sender)
            
        }
        else {
            
            print("[LVC] Done. Processing...")
            
            getUserData(sender)
            
            self.view.endEditing(true)
            
            if(DBWebServices.checkConnectionToDashboard(viewController: self) == true)
            {
                self.performSegue(withIdentifier: "DB_PROCESS_LOGIN", sender: self)
            }
            
        }
        
    }
    
    func getUserData(_ sender: UIButton) {
        
        if (uitfLVCLoginField.text != "" && dbDataAcquire == "USERNAME") {
            
            print("[LVC] Username acquired")
            
            ZGraphics.labelLayerFadeAnimation(labelView: uilLVCLoginLabel, labelTextToAnimate: DBStrings.DB_LOGIN_PASSWORD_LABEL_MS)
            ZGraphics.buttonLabelFadeAnimation(button: sender, animType: .curveLinear, labelTextToAnimate: DBStrings.DB_LOGIN_LOGIN_BUTTON_MS)
            
            dbUserName = uitfLVCLoginField.text!
            uitfLVCLoginField.text = ""
            uitfLVCLoginField.isSecureTextEntry = true
            uitfLVCLoginField.keyboardType = UIKeyboardType.default
            uitfLVCLoginField.returnKeyType = UIReturnKeyType.done
            uitfLVCLoginField.reloadInputViews()
            dbDataAcquire = "PASSWORD"
            
        }
        else if(uitfLVCLoginField.text == "" && dbDataAcquire == "USERNAME")
        {
            ZUIs.showOKDialogBox(viewController: self, dialogTitle: DBStrings.DB_LOGIN_TITLE_MS, dialogMessage: DBStrings.DB_LOGIN_INSERT_USER_MS, afterDialogDismissed: nil)
            
        }
        else if (uitfLVCLoginField.text != "" && dbDataAcquire == "PASSWORD") {
            
            print("[LVC] Password acquired")
            
            ZGraphics.labelLayerFadeAnimation(labelView: uilLVCLoginLabel, labelTextToAnimate: DBStrings.DB_LOGIN_IC_LABEL_MS)
            ZGraphics.buttonLabelFadeAnimation(button: sender, animType: .curveLinear, labelTextToAnimate: DBStrings.DB_LOGIN_NEXT_BUTTON_MS)
            
            dbPassword = uitfLVCLoginField.text!
            uitfLVCLoginField.text = ""
            uitfLVCLoginField.isSecureTextEntry = false
            uitfLVCLoginField.keyboardType = UIKeyboardType.numberPad
            uitfLVCLoginField.returnKeyType = UIReturnKeyType.next
            uitfLVCLoginField.reloadInputViews()
            dbDataAcquire = "USERNAME"
            
        }
        else if (uitfLVCLoginField.text == "" && dbDataAcquire == "PASSWORD") {
            
            ZUIs.showOKDialogBox(viewController: self, dialogTitle: DBStrings.DB_LOGIN_TITLE_MS, dialogMessage: DBStrings.DB_LOGIN_INSERT_PASS_MS, afterDialogDismissed: nil)
            
        }
        
    }
    
    
    func textFieldDidBeginEditing(_ textField: UITextField) {
        
        print("[LVC] Textfield did begin editing...")
        
        ZGraphics.moveViewYPosition(view: self.view, yPosition: 100, animationDuration: 0.4, moveToUp: true)
        
    }
    
    func textFieldShouldBeginEditing(_ textField: UITextField) -> Bool {
        
        print("[LVC] Textfield should begin editing...")
        
        return true
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        
        ZGraphics.moveViewYPosition(view: self.view, yPosition: 100, animationDuration: 0.4, moveToUp: false)
        
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        
        print("[LVC] Textfield should return...")
        
        uitfLVCLoginField.endEditing(true)
        
        return true
    }
    
    
    func applyLanguage(selectedLang: String) {
        
        if(selectedLang == "MS")
        {
            uilLVCLoginLabel.text = DBStrings.DB_LOGIN_IC_LABEL_MS
            uilLVCLoginDesc.text = DBStrings.DB_LOGIN_DESC_LABEL_MS
        }
        else
        {
            uilLVCLoginLabel.text = DBStrings.DB_LOGIN_IC_LABEL_EN
            uilLVCLoginDesc.text = DBStrings.DB_LOGIN_DESC_LABEL_EN
        }
        
    }
    

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        if(segue.identifier == "DB_PROCESS_LOGIN") {
            
            let destinationVC: LoginProcessingVC = segue.destination as! LoginProcessingVC
            
            destinationVC.loginData =
                ["USERNAME":dbUserName,
                 "PASSWORD":dbPassword,
                 "REGISTERED_ID":"1"]
            
        }
        
    }
    
}

