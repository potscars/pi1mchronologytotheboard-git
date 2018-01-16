//
//  MainMenuV3CVC.swift
//  dashboardv2
//
//  Created by Mohd Zulhilmi Mohd Zain on 09/11/2017.
//  Copyright © 2017 Ingeniworks Sdn Bhd. All rights reserved.
//

import UIKit

private let reuseIdentifier = "Cell"

private struct MainMenuIdentifier {
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
    static let GoToKospen = "GOTO_KOSPEN"
    static let GoToKospenUpdate = "GOTO_KOSPEN_UPDATE"
    static let GoToMyShop = "DB_GOTO_MYSHOP"
    static let GoToMyPlaces = "DB_GOTO_MYPLACES"
    static let GoToMyGames = "DB_GOTO_MYGAMES"
}

class MainMenuV3CVC: UICollectionViewController {
    
    var preferredPhoneNo: String = ""
    var myQuizVerifiedUser: Bool = false
    
    var questionAvailable: Bool = false
    
    var menusList = DBMenus.dashboardFrontMenu()
    
    var userData: UserData = UserData.init()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.collectionView?.delegate = self
        self.collectionView?.dataSource = self
        
        self.configureBarButton()
        
        //getQuizEvent()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        self.configureNavigationBar()
        
        if(userData.loggedIn == false) { _ = self.navigationController?.popViewController(animated: true) }
        
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        
        self.navigationController?.setNavigationBarHidden(false, animated: true)
    }
    
    func configureNavigationBar() {
        
        self.navigationController?.navigationBar.barTintColor = DBColorSet.dashboardMainColor
        self.navigationController?.navigationBar.tintColor = .white
    }
    
    func configureBarButton() {
        
        let settingsButton = UIBarButtonItem(image: #imageLiteral(resourceName: "ic_settings"), style: .plain, target: self, action: #selector(settingsButtonTapped(_:)))
        
        self.navigationItem.rightBarButtonItem = settingsButton
    }
    
    @objc private func settingsButtonTapped(_ sender: UIBarButtonItem) {
        
        self.performSegue(withIdentifier: MainMenuIdentifier.GoToSettings, sender: self)
    }
    
    func getQuizEvent() {
        
        let npQuiz: MainMenuQuizProcess = MainMenuQuizProcess.init(withURL: DBSettings.myQuizVerifyUserAndEvent)
        let quizParams: MainMenuQuizParams = MainMenuQuizParams.init()
        
        quizParams.dashboardToken = userData.token
        
        DispatchQueue.main.async {
            let quizRetrieved: MainMenuQuizRetrieved = npQuiz.verifyUserIsEligible(dashboardToken: quizParams)
            
            
        }
        
        
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

}

// MARK: UICollectionViewDataSource
extension MainMenuV3CVC {
    
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
extension MainMenuV3CVC : UICollectionViewDelegateFlowLayout{
    
    
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
            performSegue(withIdentifier: MainMenuIdentifier.GoToKospen, sender: self)
        } else if currentIndex == 4 {
            
            let storyboard = UIStoryboard(name: "MyShop", bundle: nil)
            guard let myShopTabbar = storyboard.instantiateInitialViewController() as? MyShopTabBar else { return }
            
            present(myShopTabbar, animated: true)
            
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
extension MainMenuV3CVC {
    
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
