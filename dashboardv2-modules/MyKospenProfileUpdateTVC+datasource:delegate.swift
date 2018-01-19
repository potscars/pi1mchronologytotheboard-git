//
//  MyKospenProfileUpdateTVC+datasource:delegate.swift
//  dashboardv2
//
//  Created by Hainizam on 17/01/2018.
//  Copyright © 2018 Ingeniworks Sdn Bhd. All rights reserved.
//

import UIKit

//DATASOURCE AND DELEGATES
extension MyKospenProfileUpdateTVC {
    
    // MARK: - Table view data source
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return 9
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
            cell.updateUI("Setuju Intervensi", message: "Adakah anda setuju untuk melakukan intervensi?", icon: #imageLiteral(resourceName: "intervention"), agreement: profileData[KospenProfileIdentifier.Intervensi] as! Int, type: .Intervention)
            cell.questionDelegate = self
            
            return cell
        } else if index == 1 {
            
            let cell = tableView.dequeueReusableCell(withIdentifier: KospenIdentifier.KospenQuestionaireCell, for: indexPath) as! KospenQuestionaireCell
            
            cell.selectionStyle = .none
            cell.updateUI("Status merokok", message: "Adakah anda seorang perokok?", icon: #imageLiteral(resourceName: "smoking"), agreement: profileData[KospenProfileIdentifier.SmokingStatus] as! Int, type: .Smoking)
            cell.questionDelegate = self
            
            return cell
        } else if index == 2 {
            
            let cell = tableView.dequeueReusableCell(withIdentifier: KospenIdentifier.KospenQuestionaireCell, for: indexPath) as! KospenQuestionaireCell
            
            cell.selectionStyle = .none
            cell.updateUI("Status merokok", message: "Adakah anda ingin berhenti merokok?", icon: #imageLiteral(resourceName: "tak-merokok"), agreement: profileData[KospenProfileIdentifier.isQuittingSmoke] as! Int, type: .QuitSmoking)
            cell.questionDelegate = self
            
            return cell
        } else if index == 3 {
            
            let cell = tableView.dequeueReusableCell(withIdentifier: KospenIdentifier.KospenUserMeasureCell, for: indexPath) as! KospenUserMeasureCell
            
            cell.selectionStyle = .none
            cell.measureDelegate = self
            cell.updateUI("Ukur lilit pinggang (cm)", value: "\(profileData[KospenProfileIdentifier.WaistMeasure] as! CGFloat)", indicator: "cm", icon: #imageLiteral(resourceName: "measure-tape"))
            
            return cell
        } else if index == 4 {
            
            let cell = tableView.dequeueReusableCell(withIdentifier: KospenIdentifier.KospenUserMeasureCell, for: indexPath) as! KospenUserMeasureCell
            
            cell.selectionStyle = .none
            cell.measureDelegate = self
            cell.updateUI("Ketinggian (m)", value: "\(profileData[KospenProfileIdentifier.Height] as! CGFloat)", indicator: "m", icon: #imageLiteral(resourceName: "height"))
            
            return cell
        } else if index == 5 {
            
            let cell = tableView.dequeueReusableCell(withIdentifier: KospenIdentifier.MedicalHistoryCell, for: indexPath) as! KospenUserSicknessCell
            
            cell.selectionStyle = .none
            cell.editButton.isUserInteractionEnabled = isDiseasesAvailable
            cell.sicknessDelegate = self
            
            if isFamilySickness {
                isFamilySickness = !isFamilySickness
                cell.updateUI("Sejarah penyakit keluarga", icon: #imageLiteral(resourceName: "famili-sakit-history"), type: "family", diseases: profileData[KospenProfileIdentifier.FamilyDiseases] as! NSArray)
            }

            return cell
        } else if index == 6 {
            
            let cell = tableView.dequeueReusableCell(withIdentifier: KospenIdentifier.MedicalHistoryCell, for: indexPath) as! KospenUserSicknessCell
            
            cell.selectionStyle = .none
            cell.editButton.isUserInteractionEnabled = isDiseasesAvailable
            cell.sicknessDelegate = self
            
            if isSelfSickness {
                isSelfSickness = !isSelfSickness
                cell.updateUI("Sejarah penyakit sendiri", icon: #imageLiteral(resourceName: "sejarah-sakit-sendiri"),  type: "self", diseases: profileData[KospenProfileIdentifier.OwnDiseases] as! NSArray)
            }

            return cell
        } else if index == 7 {
            
            let cell = tableView.dequeueReusableCell(withIdentifier: "updateButtonIdentifier", for: indexPath) as! ButtonUpdateCell
            
            cell.updateButtonDelegate = self
            cell.updateUI(buttonName: "Update", buttonColor: DBColorSet.myHealthColor)
            
            return cell
        } else {
            
            let cell = tableView.dequeueReusableCell(withIdentifier: "updateButtonIdentifier", for: indexPath) as! ButtonUpdateCell
            
            cell.updateButtonDelegate = self
            cell.updateUI(buttonName: "Cancel", buttonColor: .lightRed)
            
            return cell
        }
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if indexPath.row == 7 || indexPath.row == 8 {
            return 68.0
        } else {
            return UITableViewAutomaticDimension
        }
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
    }
}








