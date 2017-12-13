//
//  MyKospenProfileTVC.swift
//  dashboardv2
//
//  Created by Hainizam on 23/11/2017.
//  Copyright © 2017 Ingeniworks Sdn Bhd. All rights reserved.
//

import UIKit

class MyKospenProfileTVC: UITableViewController {

    var tempTupple = [("Setuju intervensi", "Tidak"),
                      ("Ukur lilit pinggang", "71 cm"),
                      ("Tinggi", "1.68 m"),
                      ("Sejarah penyakit sendiri", "-"),
                      ("Status merokok", "Tidak"),
                      ("Sejarah penyakit keluarga", "-"),
                      ("Ingin berhenti merokok", "Tidak"),
                      ("Dikemaskini pada", "20 December 2016"),]
    
    var profileData: [String: Any] = [:]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationController?.changeKospenNavigationBarColor()
        
        tableView.separatorStyle = .none
        tableView.backgroundColor = DBColorSet.backgroundGray
    }
    
    override func viewDidAppear(_ animated: Bool) {
        
        let kospenProfile = KospenProfile()
        
        kospenProfile.fetchProfileData { (result, responses) in
            
            guard responses == nil else { return }
            
            guard let dataResult = result else { return }
            
            DispatchQueue.main.async {
                self.profileData = dataResult
                self.tableView.reloadData()
            }
        }
    }
    
    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return profileData.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        /*
         0 - intervensi
         1 - lilit pinggang
         2 - tinggi
         3 - penyakit sendiri
         4 - status merokok
         5 - penyakit keluarga
         6 - ingin berhenti merokok
         7 - dikemaskini
         */
        
        let index = indexPath.row
        
        if index == 0 {
            let cell = createCustomCell(tableView, indexPath: indexPath) as! MyKospenProfileCell
            
            cell.updateUI( KospenProfileIdentifier.Intervensi, content: "\(String(describing: profileData[KospenProfileIdentifier.Intervensi]!))")
            
            return cell
        } else if index == 1 {
            let cell = createCustomCell(tableView, indexPath: indexPath) as! MyKospenProfileCell
            
            cell.updateUI( KospenProfileIdentifier.WaistMeasure, content: "\(String(describing: profileData[KospenProfileIdentifier.WaistMeasure]!)) cm")
            
            return cell
        } else if index == 2 {
            let cell = createCustomCell(tableView, indexPath: indexPath) as! MyKospenProfileCell
            
            cell.updateUI( KospenProfileIdentifier.Height, content: "\(String(describing: profileData[KospenProfileIdentifier.Height]!))")
            
            return cell
        } else if index == 3 {
            let cell = createCustomCell(tableView, indexPath: indexPath) as! MyKospenProfileCell
            
            cell.updateUIWithArray(KospenProfileIdentifier.OwnDiseases, contents: profileData[KospenProfileIdentifier.OwnDiseases] as! NSArray, keyPath: "disease_self")
            
            return cell
        } else if index == 4 {
            let cell = createCustomCell(tableView, indexPath: indexPath) as! MyKospenProfileCell
            
            cell.updateUI( KospenProfileIdentifier.SmokingStatus, content: "\(String(describing: profileData[KospenProfileIdentifier.SmokingStatus]!))")
            
            return cell
        } else if index == 5 {
            let cell = createCustomCell(tableView, indexPath: indexPath) as! MyKospenProfileCell
            
            cell.updateUIWithArray(KospenProfileIdentifier.FamilyDiseases, contents: profileData[KospenProfileIdentifier.FamilyDiseases] as! NSArray, keyPath: "disease_family")
            
            return cell
        } else if index == 6 {
            let cell = createCustomCell(tableView, indexPath: indexPath) as! MyKospenProfileCell
            
            cell.updateUI( KospenProfileIdentifier.isQuittingSmoke, content: "\(String(describing: profileData[KospenProfileIdentifier.isQuittingSmoke]!))")
            
            return cell
        } else {
            let cell = createCustomCell(tableView, indexPath: indexPath) as! MyKospenProfileCell
            
            cell.updateUI( KospenProfileIdentifier.UpdatedAt, content: "\(String(describing: profileData[KospenProfileIdentifier.UpdatedAt]!))")
            
            return cell
        }
        
    }
    
    func createCustomCell(_ tableView: UITableView, indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: KospenIdentifier.ProfileDetailsCell, for: indexPath) as! MyKospenProfileCell
        
        cell.backgroundColor = .clear
        cell.selectionStyle = .none
        
        return cell
    }
}

extension MyKospenProfileTVC {
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 73.0
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        performSegue(withIdentifier: "gotoProfileUpdate", sender: self)
    }
}











