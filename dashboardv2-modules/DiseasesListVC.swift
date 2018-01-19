//
//  DiseasesListVC.swift
//  dashboardv2
//
//  Created by Hainizam on 03/01/2018.
//  Copyright © 2018 Ingeniworks Sdn Bhd. All rights reserved.
//

import UIKit

protocol DiseaseListDelegate {
    func didSelectDiseases(diseases: DiseaseType)
}

struct DiseaseType {
    var type: String
    var diseases: [DiseaseInfo]
}

struct DiseaseInfo {
    var id: Int
    var name: String
    var slug: String
    var extraInfo: String?
}

class DiseasesListVC: UIViewController {

    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var customView: UIView!
    @IBOutlet weak var doneButton: UIButton!
    
    var diseases = [Disease]()
    var newDiseases: DiseaseType?
    var diseasesType: String!
    var diseasesDelegate: DiseaseListDelegate?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.dataSource = self
        tableView.delegate = self
        
        doneButton.isUserInteractionEnabled = false
        newDiseases = DiseaseType(type: diseasesType, diseases: [])
        customView.roundedCorners(5)
    }
    
    @IBAction func doneButtonTapped(_ sender: UIButton) {
        guard let newDiseases = newDiseases else { return }
        diseasesDelegate?.didSelectDiseases(diseases: newDiseases)
        dismiss(animated: true)
    }
    
    @IBAction func cancelButtonTapped(_ sender: UIButton) {
        self.dismiss(animated: true, completion: nil)
    }
}

extension DiseasesListVC: UITableViewDataSource, UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return diseases.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "diseaseCell", for: indexPath)
        cell.selectionStyle = .none
        let titleLabel = cell.viewWithTag(1) as! UILabel
        titleLabel.text = diseases[indexPath.row].name
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 44.0
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        guard let cell = tableView.cellForRow(at: indexPath) else { return }
        let diseaseTemp = diseases[indexPath.row]
        
        if cell.accessoryType == .checkmark {
            cell.accessoryType = .none
            
            for (index, disease) in (newDiseases?.diseases.enumerated())! {
                
                if diseaseTemp.name == disease.name {
                    newDiseases?.diseases.remove(at: index)
                    return
                }
            }
            
        } else {
            cell.accessoryType = .checkmark
            
            if diseaseTemp.isExtraInfo == 1 {
                let alertController = UIAlertController(title: diseaseTemp.name, message: "Sila nyatakan.", preferredStyle: .alert)
                let okayButton = UIAlertAction(title: "Okay", style: .default, handler: { (alert) in
                    let textField = alertController.textFields![0] as! UITextField
                    
                    self.newDiseases?.diseases.append(DiseaseInfo(id: diseaseTemp.id!, name: diseaseTemp.name!, slug: diseaseTemp.slug!, extraInfo: textField.text))
                })
                let cancelButton = UIAlertAction(title: "Batal", style: .destructive, handler: { (alert) in
                    
                    self.newDiseases?.diseases.append(DiseaseInfo(id: diseaseTemp.id!, name: diseaseTemp.name!, slug: diseaseTemp.slug!, extraInfo: nil))
                })
                
                alertController.addTextField(configurationHandler: { (textField) in
                    textField.placeholder = "Nyatakan info"
                })
                
                alertController.addAction(okayButton)
                alertController.addAction(cancelButton)
                
                present(alertController, animated: true)
            } else {
                
                newDiseases?.diseases.append(DiseaseInfo(id: diseaseTemp.id!, name: diseaseTemp.name!, slug: diseaseTemp.slug!, extraInfo: nil))
            }
        }
        
        guard let tempDiseases = newDiseases else { return }
        let enableButton = tempDiseases.diseases.count > 0 ? true : false
        doneButton.isUserInteractionEnabled = enableButton
    }
}












