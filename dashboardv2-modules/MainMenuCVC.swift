//
//  MainMenuCVC.swift
//  dashboardv2
//
//  Created by Hainizam on 25/09/2017.
//  Copyright © 2017 Ingeniworks Sdn Bhd. All rights reserved.
//

import UIKit

private let reuseIdentifier = "Cell"

struct MainMenuIdentifier {
    static let HeaderView = "headerCell"
    static let MenuCell = "menuCell"
    static let QuizMenuCell = "quizMenuCell"
    static let GoToSettings = "DB_GOTO_SETTINGS"
    static let GoToQuiz = "DB_GOTO_QUIZ"
    static let GoToAbout = "DB_GOTO_ABOUT"
    static let GoToMyKomuniti = "DB_GOTO_MYKOMUNITI"
    static let GoToMySoal = "DB_GOTO_MYSOAL"
    static let GoToMySkool = "DB_GOTO_MYSKOOL"
    static let GoToMyHealth = "DB_GOTO_MYHEALTH"
    static let GoToMyShop = "DB_GOTO_MYSHOP"
    static let GoToMyPlaces = "DB_GOTO_MYPLACES"
    static let GoToMyGames = "DB_GOTO_MYGAMES"
}

class MainMenuCVC: UICollectionViewController {

    var preferredPhoneNo: String = ""
    var myQuizVerifiedUser: Bool = false
    
    let verifiedEventNotification: String = "MyQuizUserVerifiedNotification"
    let verifyingEventNotification: String = "MyQuizUserVerifyingNotification"
    let getQuestionLeft: String = "MyQuizGetQuestionLeftNotification"
    
    var questionAvailable: Bool = false
    
    var menusList = DBMenus.dashboardFrontMenu()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        collectionView?.delegate = self
        collectionView?.dataSource = self
        
        configureBarButton()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        configureNavigationBar()
        
        if(DBWebServices.checkConnectionToDashboard(viewController: self) == true) {
            
            NotificationCenter.default.addObserver(self, selector: #selector(myQuizVerifiedUser(data:)), name: Notification.Name(verifiedEventNotification), object: nil)
            NotificationCenter.default.addObserver(self, selector: #selector(myQuizVerifyUser(data:)), name: Notification.Name(verifyingEventNotification), object: nil)
            NotificationCenter.default.addObserver(self, selector: #selector(gotQuestionData(data:)), name: Notification.Name(getQuestionLeft), object: nil)
            
            DBWebServices.getMyQuizGetQuestions(token: String(describing:UserDefaults.standard.object(forKey: "SuccessLoggerDashboardToken")!), registeredNotification: getQuestionLeft)
            
            DBWebServices.getMyQuizVerifyEvent(token: String(describing: UserDefaults.standard.object(forKey: "SuccessLoggerDashboardToken")!), registeredNotification: verifyingEventNotification)
            
        }
        
        let getUserDefaults: UserDefaults? = UserDefaults.standard
        let loginState: Bool? = getUserDefaults?.object(forKey: "SuccessLoggerIsLogin") as? Bool
        
        print("Loginstate is \(loginState!)")
        
        if(loginState! == false)
        {
            _ = self.navigationController?.popViewController(animated: true)
        }
        
        print("Settings registered:\n\nRemember Me: \(UserDefaults.standard.object(forKey: "SuccessLoggerSettingsRememberMe") as? Bool)\nLanguage Selected: \(UserDefaults.standard.object(forKey: "SuccessLoggerSettingsLanguage") as? String)\nModule Selected: \(UserDefaults.standard.object(forKey: "SuccessLoggerSettingsModuleSelected") as? NSArray)")
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        
        NotificationCenter.default.removeObserver(self, name: Notification.Name(verifiedEventNotification), object: nil);
        NotificationCenter.default.removeObserver(self, name: Notification.Name(verifyingEventNotification), object: nil);
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        navigationController?.setNavigationBarHidden(false, animated: true)
    }
    
    func configureNavigationBar() {
        
        navigationController?.navigationBar.barTintColor = DBColorSet.dashboardMainColor
        navigationController?.navigationBar.tintColor = .white
        //navigationController?.navigationBar.titleTextAttributes = [NSFontAttributeName : UIFont(name: "Futura-Bold", size: 20.0)!, NSForegroundColorAttributeName : UIColor.white]
    }
    
    func configureBarButton() {
        
        let settingsButton = UIBarButtonItem(image: #imageLiteral(resourceName: "ic_settings"), style: .plain, target: self, action: #selector(settingsButtonTapped(_:)))
        
        navigationItem.rightBarButtonItem = settingsButton
    }
    
    @objc private func settingsButtonTapped(_ sender: UIBarButtonItem) {
        
        performSegue(withIdentifier: MainMenuIdentifier.GoToSettings, sender: self)
    }
    
    @objc func gotQuestionData(data: NSDictionary) {
        
        if let unwrapData = data.value(forKey: "object") as? NSDictionary {
            
            if let questionStatus = unwrapData.value(forKey: "status") as? Int{
                
                print("inininin \(questionStatus)")
                
                if(questionStatus == 0) {
                    
                    questionAvailable = false
                    
                    DispatchQueue.main.async {
                        
                        self.collectionView?.reloadData()
                    }
                } else {
                    
                    questionAvailable = true
                    DispatchQueue.main.async {
                        
                        self.collectionView?.reloadData()
                    }
                }
            }
        }
    }
    
    @objc func myQuizVerifyUser(data: NSDictionary) {
        
        //check if user is eligible
        
        if let breakUpObject: NSDictionary = data.value(forKey: "object") as? NSDictionary {
            
            if(breakUpObject.value(forKey: "status") as! Int == 1) {
                
                print("User already Verified")
                
                self.myQuizVerifiedUser = true
            }
            else {
                
                self.myQuizVerifiedUser = false
            }
        } else {
            print("Quiz data nil.")
        }
    }
    
    @objc func myQuizVerifiedUser(data: NSDictionary) {
        
        //verify user after insert phone no
        
        let breakUpObject: NSDictionary = data.value(forKey: "object") as! NSDictionary
        
        if(breakUpObject.value(forKey: "status") as! Int == 1) {
            
            print("Verified")
            
            DispatchQueue.main.async {
                self.performSegue(withIdentifier: "DB_GOTO_QUIZ", sender: self)
            }
            
        }
    }
    
    func getPhoneAlert(retry: Bool) {
        
        if(retry == true) { self.preferredPhoneNo = "" }
        
        let phoneAlertController: UIAlertController = UIAlertController.init(title: DBStrings.DB_MODULE_MYQUIZ_PHONEASK_TITLE_MS, message: DBStrings.DB_MODULE_MYQUIZ_PHONEASK_DESC_MS, preferredStyle: UIAlertControllerStyle.alert)
        
        let phoneCancelAction: UIAlertAction = UIAlertAction.init(title: DBStrings.DB_BUTTON_CANCEL_LABEL_MS, style: UIAlertActionStyle.default, handler: { action -> Void in phoneAlertController.dismiss(animated: true, completion: nil) })
        phoneAlertController.addAction(phoneCancelAction)
        
        let phoneTNCAction: UIAlertAction = UIAlertAction.init(title: DBStrings.DB_MODULE_MYQUIZ_TNCLABEL_BUTTON_MS, style: UIAlertActionStyle.default, handler: { action -> Void in
            
            UIApplication.shared.open(URL.init(string: DBSettings.myQuizTNCUrl)!, options: [:], completionHandler: nil)
            
            phoneAlertController.dismiss(animated: true, completion: nil)
            
        })
        phoneAlertController.addAction(phoneTNCAction)
        
        let phoneOKAction: UIAlertAction = UIAlertAction.init(title: DBStrings.DB_BUTTON_OK_LABEL_MS, style: UIAlertActionStyle.default, handler: { action -> Void in
            
            self.preferredPhoneNo = String(describing: phoneAlertController.textFields![0].text!).trimmingCharacters(in: NSCharacterSet.whitespaces)
            
            if(self.preferredPhoneNo != "")
            {
                let phoneConfirmAlertController: UIAlertController = UIAlertController.init(title: DBStrings.DB_MODULE_MYQUIZ_PHONECONFIRM_TITLE_MS, message: "\(DBStrings.DB_MODULE_MYQUIZ_PHONECONFIRM_DESC_MS) \(self.preferredPhoneNo)?", preferredStyle: UIAlertControllerStyle.alert)
                
                let phoneNoAction: UIAlertAction = UIAlertAction.init(title: DBStrings.DB_BUTTON_NO_LABEL_MS, style: UIAlertActionStyle.cancel, handler: { action -> Void in
                    
                    self.getPhoneAlert(retry: true)
                })
                
                phoneConfirmAlertController.addAction(phoneNoAction)
                
                let phoneYesAction: UIAlertAction = UIAlertAction.init(title: DBStrings.DB_BUTTON_YES_LABEL_MS, style: UIAlertActionStyle.default, handler: { action -> Void in
                    
                    DBWebServices.getMyQuizVerifyUser(token: String(describing: UserDefaults.standard.object(forKey: "SuccessLoggerDashboardToken")!), phoneNo: self.preferredPhoneNo, flag: 1, registeredNotification: self.verifiedEventNotification)
                    
                    
                    
                })
                
                phoneConfirmAlertController.addAction(phoneYesAction)
                phoneConfirmAlertController.preferredAction = phoneYesAction
                
                self.present(phoneConfirmAlertController, animated: true, completion: nil)
            }
            else {
                self.getPhoneAlert(retry: true)
            }
            
        })
        phoneAlertController.addAction(phoneOKAction)
        phoneAlertController.preferredAction = phoneOKAction
        phoneAlertController.addTextField(configurationHandler: { (textField : UITextField!) -> Void in
            
            textField.placeholder = DBStrings.DB_MODULE_MYQUIZ_PHONEASK_PLACEHOLDER_MS
            textField.keyboardType = UIKeyboardType.numberPad
            
        })
        
        self.present(phoneAlertController, animated: true, completion: nil)
    }
}

// MARK: UICollectionViewDataSource
extension MainMenuCVC {
    
    override func numberOfSections(in collectionView: UICollectionView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        let countTotal = questionAvailable ? menusList.count + 1 : menusList.count
        print(countTotal)
        
        return countTotal
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        if questionAvailable {
            
            if indexPath.row == 0 {
                let cell = collectionView.dequeueReusableCell(withReuseIdentifier: MainMenuIdentifier.QuizMenuCell, for: indexPath)
                
                cell.roundedCorners(10)
                
                return cell
            } else {
                
                return createCell(collectionView, indexPath: indexPath)
            }
        } else {
            
            return createCell(collectionView, indexPath: indexPath)
        }
    }
    
    func createCell(_ collectionView: UICollectionView, indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: MainMenuIdentifier.MenuCell, for: indexPath)
        cell.addShadow()
        
        let currentIndex = questionAvailable ? indexPath.row - 1 : indexPath.row
        
        let cellLabel = cell.viewWithTag(3) as! UILabel
        let cellView = cell.viewWithTag(1)! as UIView
        let cellImage = cell.viewWithTag(2) as! UIImageView
        let menuDictionary = menusList.object(at: currentIndex) as! NSDictionary
        
        cellLabel.text = menuDictionary.value(forKey: "MenuString") as? String
        cellImage.image = menuDictionary.value(forKey: "IconString") as? UIImage
        cellView.backgroundColor = menuDictionary.value(forKey: "ColorObject") as? UIColor
        cellView.roundedCorners(10)
        
        return cell
    }
    
    override func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        
        switch kind {
            
        case UICollectionElementKindSectionHeader:
            let headerView = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: MainMenuIdentifier.HeaderView, for: indexPath) as UICollectionReusableView
            
            let tapGesture = UITapGestureRecognizer(target: self, action: #selector(headerViewTapped(_:)))
            headerView.addGestureRecognizer(tapGesture)
            
            return headerView;
            
        default:
            assert(false, "Failed to create headerView!");
        }
        
        return UICollectionReusableView()
    }
    
    @objc private func headerViewTapped(_ sender: UITapGestureRecognizer) {
        performSegue(withIdentifier: MainMenuIdentifier.GoToAbout, sender: self)
    }
}

//Delegates
extension MainMenuCVC : UICollectionViewDelegateFlowLayout{
    
    
    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        let index = indexPath.row
        
        if DBWebServices.checkConnectionToDashboard(viewController: self) {
            
            if questionAvailable {
                
                if index == 0 {
                    performSegue(withIdentifier: MainMenuIdentifier.GoToQuiz, sender: self)
                } else {
                    performSegueWithIndex(index)
                }
            } else {
                performSegueWithIndex(index)
            }
        }
    }
    
    func performSegueWithIndex(_ index: Int) {
        
        let currentIndex = questionAvailable ? index - 1 : index
        
        if currentIndex == 0 {
            performSegue(withIdentifier: MainMenuIdentifier.GoToMyKomuniti, sender: self)
        } else if currentIndex == 1 {
            performSegue(withIdentifier: MainMenuIdentifier.GoToMySoal, sender: self)
        } else if currentIndex == 2 {
            performSegue(withIdentifier: MainMenuIdentifier.GoToMySkool, sender: self)
        } else if currentIndex == 3 {
            performSegue(withIdentifier: MainMenuIdentifier.GoToMyHealth, sender: self)
        } else if currentIndex == 4 {
            performSegue(withIdentifier: MainMenuIdentifier.GoToMyShop, sender: self)
        } else if currentIndex == 5 {
            performSegue(withIdentifier: MainMenuIdentifier.GoToMyPlaces, sender: self)
        } else if currentIndex == 6 {
            performSegue(withIdentifier: MainMenuIdentifier.GoToMyGames, sender: self)
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        let itemWidth = (collectionView.bounds.width - 24) / 2
        
        let layout = collectionViewLayout as! UICollectionViewFlowLayout
        layout.minimumLineSpacing = 8
        layout.minimumInteritemSpacing = 0
        layout.sectionInset = UIEdgeInsetsMake(8, 8, 8, 8)
        
        if questionAvailable && indexPath.row == 0 {
            return CGSize(width: collectionView.bounds.width - 16, height: 100)
        } else {
            return CGSize(width: itemWidth, height: itemWidth)
        }
    }
}

//ScrollView delegates
extension MainMenuCVC {
    
    override func scrollViewWillEndDragging(_ scrollView: UIScrollView, withVelocity velocity: CGPoint, targetContentOffset: UnsafeMutablePointer<CGPoint>) {
        
        if velocity.y > 0 {
            UIView.animate(withDuration: 2.0, animations: { 
                self.navigationController?.setNavigationBarHidden(true, animated: true)
            })
        } else {
            UIView.animate(withDuration: 2.0, animations: {
                self.navigationController?.setNavigationBarHidden(false, animated: true)
            })
        }
    }
}



















