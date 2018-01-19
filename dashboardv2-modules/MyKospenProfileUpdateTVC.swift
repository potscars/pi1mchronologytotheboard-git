//
//  MyKospenProfileUpdateTVC.swift
//  dashboardv2
//
//  Created by Hainizam on 24/11/2017.
//  Copyright © 2017 Ingeniworks Sdn Bhd. All rights reserved.
//

import UIKit

enum KospenEtc {
    
    case Family
    case SelfDiseases
    case Update
    case Cancel
    
    enum Question {
        case Intervention
        case Smoking
        case QuitSmoking
    }
}

class MyKospenProfileUpdateTVC: UITableViewController {
    
    var isFamilySickness = true
    var isSelfSickness = true
    
    //variables for updating the profile.
    var ownDiseasesList = [[String: Any]]()
    var familyDiseasesList = [[String: Any]]()
    var heightValue: CGFloat!
    var waistValue: CGFloat!
    var interventionValue: Int!
    var smokingStatusValue: Int!
    var quittingSmokingValue: Int!
    
    var diseases = [Disease]()
    var isDiseasesAvailable = false
    
    var profileData: [String: Any]!
    var spinner: LoadingSpinner!
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        UIApplication.shared.statusBarStyle = .lightContent
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        spinner = LoadingSpinner.init(view: self.view, isNavBar: true)
        UIApplication.shared.statusBarStyle = .default
        setupTableView()
        setupInitialValue()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        let disease = Disease.init()
        spinner.setLoadingScreen()
        if DBWebServices.checkConnectionToDashboard(viewController: self) {
            disease.fetchDiseasesData { (result, response) in
                
                guard response == nil else {
                    print(response!)
                    return
                }
                
                guard let result = result else { return }
                
                DispatchQueue.main.async {
                    self.diseases = result
                    let familyIndexPath = IndexPath(row: 4, section: 0)
                    let selfIndexPath = IndexPath(row: 5, section: 0)
                    self.tableView.reloadRows(at: [familyIndexPath, selfIndexPath], with: .none)
                    self.isDiseasesAvailable = true
                    self.spinner.removeLoadingScreen()
                }
            }
        } else {
            spinner.removeLoadingScreen()
            print("No internet connection..")
        }
    }
    
    func setupTableView() {
        
        tableView.rowHeight = UITableViewAutomaticDimension
        tableView.estimatedRowHeight = 220.0
        
        let questionaireNib = UINib(nibName: "KospenQuestionaireCell", bundle: nil)
        tableView.register(questionaireNib, forCellReuseIdentifier: KospenIdentifier.KospenQuestionaireCell)
        let measureNib = UINib(nibName: "KospenUserMeasureCell", bundle: nil)
        tableView.register(measureNib, forCellReuseIdentifier: KospenIdentifier.KospenUserMeasureCell)
        let medicalNib = UINib(nibName: "KospenUserSicknessCell", bundle: nil)
        tableView.register(medicalNib, forCellReuseIdentifier: KospenIdentifier.MedicalHistoryCell)
    }
    
    //init value asal, supaya kalau tak tukar value, remain the same.
    func setupInitialValue() {
        
        var familyDiseaseTemp = [String: Any]()
        if let diseasesCollection = profileData[KospenProfileIdentifier.FamilyDiseases] as? NSArray {
            for disease in diseasesCollection {
                
                if let id = (disease as AnyObject).object(forKey: "myhealth_disease_id") as? Int {
                    familyDiseaseTemp["id"] = id
                }
                
                familyDiseaseTemp["type"] = 2
                familyDiseasesList.append(familyDiseaseTemp)
            }
        }
        
        var ownDiseaseTemp = [String: Any]()
        if let diseasesCollection = profileData[KospenProfileIdentifier.OwnDiseases] as? NSArray {
            for disease in diseasesCollection {
                
                if let id = (disease as AnyObject).object(forKey: "myhealth_disease_id") as? Int {
                    ownDiseaseTemp["id"] = id
                }
                
                ownDiseaseTemp["type"] = 1
                ownDiseasesList.append(ownDiseaseTemp)
            }
        }
        
        interventionValue = profileData[KospenProfileIdentifier.Intervensi] as! Int
        heightValue = profileData[KospenProfileIdentifier.Height] as! CGFloat
        waistValue = profileData[KospenProfileIdentifier.WaistMeasure] as! CGFloat
        smokingStatusValue = profileData[KospenProfileIdentifier.SmokingStatus] as! Int
        quittingSmokingValue = profileData[KospenProfileIdentifier.isQuittingSmoke] as! Int
    }
    
    func updatedAlert(_ title: String, message: String) {
        
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let okayButton = UIAlertAction(title: "Okay", style: .default) { (alert) in
            
            self.dismiss(animated: true, completion: nil)
        }
        
        alert.addAction(okayButton)
        present(alert, animated: true)
    }
    
    var isHeight: Bool!
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        if segue.identifier == "GOTO_NUMBERPICKER" {
            
            if let vc = segue.destination as? NumberPickerVC {
                vc.isHeight = isHeight
                vc.numberPickerDelegate = self
            }
        }
    }
}











