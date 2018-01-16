//
//  MyKospenProfileUpdateTVC.swift
//  dashboardv2
//
//  Created by Hainizam on 24/11/2017.
//  Copyright © 2017 Ingeniworks Sdn Bhd. All rights reserved.
//

import UIKit

class MyKospenProfileUpdateTVC: UITableViewController {
    
    var isFamilySickness = true
    var isSelfSickness = true
    
    var diseases = [Disease]()
    var isDiseasesAvailable = false
    
    var spinner: LoadingSpinner!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        spinner = LoadingSpinner.init(view: self.view, isNavBar: true)
        setupTableView()
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
                    print("ITS DONEE")
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
    
    var isHeight: Bool!
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        if segue.identifier == "GOTO_NUMBERPICKER" {
            
            if let vc = segue.destination as? NumberPickerVC {
                vc.isHeight = isHeight
            }
        }
    }
}

//DATASOURCE AND DELEGATES
extension MyKospenProfileUpdateTVC {
    
    // MARK: - Table view data source
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return 7
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        /*
         0 - intervensi
         1 - status merokok
         2 - ingin berhenti merokok
         3 - lilit pinggang
         4 - tinggi
         5 - penyakit keluarga
         6 - penyakit sendiri
         7 - Update button
         */
        
        let index = indexPath.row
        
        if index == 0 {
            
            let cell = tableView.dequeueReusableCell(withIdentifier: KospenIdentifier.KospenQuestionaireCell, for: indexPath) as! KospenQuestionaireCell
            
            cell.selectionStyle = .none
            cell.updateUI("Setuju Intervensi", message: "Adakah anda setuju untuk melakukan intervensi?", icon: #imageLiteral(resourceName: "intervention"))
            
            return cell
        } else if index == 1 {
            
            let cell = tableView.dequeueReusableCell(withIdentifier: KospenIdentifier.KospenQuestionaireCell, for: indexPath) as! KospenQuestionaireCell
            
            cell.selectionStyle = .none
            cell.updateUI("Status merokok", message: "Adakah anda seorang perokok?", icon: #imageLiteral(resourceName: "smoking"))
            
            return cell
        } else if index == 2 {
            
            let cell = tableView.dequeueReusableCell(withIdentifier: KospenIdentifier.KospenUserMeasureCell, for: indexPath) as! KospenUserMeasureCell
            
            cell.selectionStyle = .none
            cell.measureDelegate = self
            cell.updateUI("Ukur lilit pinggang (cm)", value: "\(28)", indicator: "cm", icon: #imageLiteral(resourceName: "measure-tape"))
            
            return cell
        } else if index == 3 {
            
            let cell = tableView.dequeueReusableCell(withIdentifier: KospenIdentifier.KospenUserMeasureCell, for: indexPath) as! KospenUserMeasureCell
            
            cell.selectionStyle = .none
            cell.measureDelegate = self
            cell.updateUI("Ketinggian (m)", value: "\(1.70)", indicator: "m", icon: #imageLiteral(resourceName: "height"))
            
            return cell
        } else if index == 4 {
            
            let cell = tableView.dequeueReusableCell(withIdentifier: KospenIdentifier.MedicalHistoryCell, for: indexPath) as! KospenUserSicknessCell
            
            cell.selectionStyle = .none
            cell.editButton.isUserInteractionEnabled = isDiseasesAvailable
            cell.sicknessDelegate = self
            cell.updateUI("Sejarah penyakit keluarga", icon: #imageLiteral(resourceName: "famili-sakit-history"), type: "family")
            if isFamilySickness {
                isFamilySickness = !isFamilySickness
                cell.tagView.titles = ["Batman", "Superman", "Arthur", "Merlin", "Clover", "Aragami", "Saiyan"]
            }
            
            return cell
        } else if index == 5 {
            
            let cell = tableView.dequeueReusableCell(withIdentifier: KospenIdentifier.MedicalHistoryCell, for: indexPath) as! KospenUserSicknessCell
            
            cell.selectionStyle = .none
            cell.editButton.isUserInteractionEnabled = isDiseasesAvailable
            cell.sicknessDelegate = self
            cell.updateUI("Sejarah penyakit sendiri", icon: #imageLiteral(resourceName: "sejarah-sakit-sendiri"),  type: "self")
            if isSelfSickness {
                isSelfSickness = !isSelfSickness
                cell.tagView.titles = ["Batman", "Superman", "Arthur", "Merlin", "Clover", "Aragami", "Saiyan"]
            }
            
            return cell
        } else {
            
            let cell = tableView.dequeueReusableCell(withIdentifier: "updateButtonIdentifier", for: indexPath) as! ButtonUpdateCell
            
            cell.updateButtonDelegate = self
            
            return cell
        }
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if indexPath.row == 6 {
            return 68.0
        } else {
            return UITableViewAutomaticDimension
        }
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {

    }
}

extension MyKospenProfileUpdateTVC: KospenUserMeasureCellDelegate {
    func didTappedMeasureEditButton(_ isHeight: Bool) {
        self.isHeight = isHeight
        self.performSegue(withIdentifier: "GOTO_NUMBERPICKER", sender: self)
    }
}

extension MyKospenProfileUpdateTVC: KospenUserSicknessDelegate {
    
    func didTappedSicknessEditButton(_ isFamily: Bool) {
        
        let storyboard = UIStoryboard(name: "MainV3", bundle: nil)
        let vc = storyboard.instantiateViewController(withIdentifier: "DiseasesListVC") as! DiseasesListVC
        vc.modalPresentationStyle = .overCurrentContext
        vc.diseases = diseases
        
        self.present(vc, animated: true, completion: nil)
    }
}

extension MyKospenProfileUpdateTVC: ButtonUpdateDelegate {
    
    func didUpdateButtonTapped() {
        print("Tapped!")
    }
}












