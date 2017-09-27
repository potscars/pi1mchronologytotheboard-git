//
//  LoginV3VC.swift
//  dashboardv2
//
//  Created by Mohd Zulhilmi Mohd Zain on 18/09/2017.
//  Copyright © 2017 Ingeniworks Sdn Bhd. All rights reserved.
//

import UIKit
import QuartzCore.CALayer

extension UIImage {
    
    func addImagePadding(x: CGFloat, y: CGFloat) -> UIImage? {
        let width: CGFloat = self.size.width + x
        let height: CGFloat = self.size.width + y
        UIGraphicsBeginImageContextWithOptions(CGSize(width: width, height: height), false, 0)
        let origin: CGPoint = CGPoint(x: (width - self.size.width) / 2, y: (height - self.size.height) / 2)
        self.draw(at: origin)
        let imageWithPadding = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        
        return imageWithPadding
    }
    
}

class LoginV3VC: UIViewController, UITextFieldDelegate {
    
    @IBOutlet weak var uitfLV3VCUsername: UITextField!
    @IBOutlet weak var uitfLV3VCPassword: UITextField!
    @IBOutlet weak var uibLV3VCLoginBtn: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        let rect: CGRect = CGRect.init(x: 0, y: 0, width: 30, height: 30)
        
        let iconImage: UIImage = UIImage.init(named: "ic_logincard300.png")!
        let iconPassImage: UIImage = UIImage.init(named: "ic_loginkey300.png")!
        
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
        
    }
    
    func textFieldDidBeginEditing(_ textField: UITextField) {
        
        ZGraphics.moveViewYPosition(view: self.view, yPosition: 100, animationDuration: 0.4, moveToUp: true)
        
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        
        uitfLV3VCPassword.endEditing(true)
        
        return true
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
