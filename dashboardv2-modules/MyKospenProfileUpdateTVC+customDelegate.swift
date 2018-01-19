//
//  MyKospenProfileUpdateTVC+customDelegate.swift
//  dashboardv2
//
//  Created by Hainizam on 17/01/2018.
//  Copyright © 2018 Ingeniworks Sdn Bhd. All rights reserved.
//

import UIKit

extension MyKospenProfileUpdateTVC: KospenUserMeasureCellDelegate, NumberPickerDelegate {
    
    func didTappedMeasureEditButton(_ isHeight: Bool) {
        self.isHeight = isHeight
        self.performSegue(withIdentifier: "GOTO_NUMBERPICKER", sender: self)
    }
    
    func didSelectNumber(_ value: String, isHeight: Bool) {
        
        let index = isHeight ? 4 : 3
        let indicator = isHeight ? "m" : "cm"
        let identifier = isHeight ? KospenProfileIdentifier.Height : KospenProfileIdentifier.WaistMeasure
        let indexPath = IndexPath(row: index, section: 0)
        
        if let cell = tableView.cellForRow(at: indexPath) as? KospenUserMeasureCell {
            guard let valueInCGFloat = NumberFormatter().number(from: value) as? CGFloat else { return }
            profileData[identifier] = valueInCGFloat
            
            if isHeight {
                heightValue = valueInCGFloat
            } else {
                waistValue = valueInCGFloat
            }
            
            cell.unitValue = "\(value) \(indicator)"
        }
    }
}

extension MyKospenProfileUpdateTVC: KospenUserSicknessDelegate, DiseaseListDelegate {
    
    func didTappedSicknessEditButton(_ isFamily: Bool) {
        
        let storyboard = UIStoryboard(name: "MainV3", bundle: nil)
        let vc = storyboard.instantiateViewController(withIdentifier: "DiseasesListVC") as! DiseasesListVC
        vc.modalPresentationStyle = .overCurrentContext
        vc.diseases = diseases
        vc.diseasesType = isFamily ? "family" : "self"
        vc.diseasesDelegate = self
        self.present(vc, animated: true, completion: nil)
    }
    
    func didSelectDiseases(diseases: DiseaseType) {
        
        let index = diseases.type == "family" ? 5 : 6
        let indexPath = IndexPath(row: index, section: 0)
        let typeValue = diseases.type == "family" ? 2 : 1
        var tempDiseasesArray = [String]()
        var tempDiseaseDetails = [String: Any]()
        
        if typeValue == 1 {
            ownDiseasesList.removeAll()
        } else {
            familyDiseasesList.removeAll()
        }
        
        for disease in diseases.diseases {
            
            tempDiseaseDetails["id"] = disease.id
            tempDiseaseDetails["type"] = typeValue
            if disease.extraInfo != nil {
                tempDiseaseDetails["value"] = disease.extraInfo
            }
            
            if typeValue == 1 {
                ownDiseasesList.append(tempDiseaseDetails)
            } else {
                familyDiseasesList.append(tempDiseaseDetails)
            }
            
            //kalau extra info tak nil, gabung kan sekali ngan name penyakit.
            let diseaseName = disease.extraInfo == nil ? disease.name : "\(disease.name) • \(disease.extraInfo!)"
            tempDiseasesArray.append(diseaseName)
        }
        
        if let cell = tableView.cellForRow(at: indexPath) as? KospenUserSicknessCell {
            cell.diseasesArrayTemp = tempDiseasesArray
        }
    }
}

extension MyKospenProfileUpdateTVC: KospenQuestionaireDelegate {
    
    func didTappedOnTheSwitch(_ value: Int, type: KospenEtc.Question) {
        print(value, type)
        
        switch type {
        case .Intervention:
            interventionValue = value
        case .Smoking:
            smokingStatusValue = value
        case .QuitSmoking:
            quittingSmokingValue = value
        }
    }
}

extension MyKospenProfileUpdateTVC: ButtonUpdateDelegate {
    
    func didUpdateButtonTapped(_ type: String, button: UIButton) {
        if type == "Update" {
            button.isEnabled = false
            let updatedDiseasesList = ownDiseasesList + familyDiseasesList
            let dashToken = UserDefaults.standard.object(forKey: "SuccessLoggerDashboardToken") as! String
            let networkProcessor = NetworkProcessor.init(DBSettings.kospenAddUpdateDiseaseURL)

            let params: [String: Any] = [
                "intervention_agree" : interventionValue,
                "smoking_status" : smokingStatusValue,
                "want_to_quit_smoking" : quittingSmokingValue,
                "height" : heightValue,
                "measure_waist" : waistValue,
                "disease_history" : updatedDiseasesList,
                "token" : dashToken
            ]

            networkProcessor.postRequestJSONFromUrl(params, completion: { (result, response) in

                guard response == nil else { return }
                guard let result = result else { return }
                
                if let status = result["status"] as? Int, status == 1 {
                    let message = result["message"] as! String
                    
                    DispatchQueue.main.async {
                        self.updatedAlert("Berjaya!", message: message)
                        button.isEnabled = true
                    }
                    
                } else {
                    let message = "Gagal. Sila cuba lagi."
                    DispatchQueue.main.async {
                        self.updatedAlert("Gagal!", message: message)
                        button.isEnabled = true
                    }
                }
            })
            
            print(updatedDiseasesList)
        } else {
            dismiss(animated: true)
        }
    }
}












