//
//  MyKospenTVC+datasource:delegate.swift
//  dashboardv2
//
//  Created by Hainizam on 16/01/2018.
//  Copyright © 2018 Ingeniworks Sdn Bhd. All rights reserved.
//

import UIKit

extension MyKospenTVC {
    
    // MARK: - Table view data source
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        let sectionCount = tableView == self.tableView ? sectionName.count : 1
        return sectionCount
    }
    
    override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        
        guard tableView == self.tableView else { return nil }
        
        return sectionName[section]
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        if tableView == self.tableView {
            if section == 0 {
                return bmiData.count > 0 ? bmiData.count + 2 : 0
            } else if section == 1 {
                return glucoseData.count > 0 ? glucoseData.count + 2 : 0
            } else {
                return bloodPressureData.count > 0 ? bloodPressureData.count + 2 : 0
            }
        } else {
            return totalStatus
        }
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        /*
         section 0 - description
         section 1 - bmi value
         section 2 - blood sugar level
         section 3 - blood pressure
         */
        
        let index = indexPath.row
        
        if tableView == statusTableView {
            
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
            
            return populateStatusDataIntoCell(tableView, indexPath: indexPath)
            
        } else {
            if indexPath.section == 0 {
                
                if index == 0 {
                    let cell = tableView.dequeueReusableCell(withIdentifier: KospenIdentifier.ChartCell, for: indexPath) as! ChartCell
                    
                    let dateArray = getDateArray(bmiData)
                    cell.selectionStyle = .none
                    cell.updateBMICharts(bmiData, dateArray: dateArray)
                    return cell
                } else if index == 1 {
                    
                    let cell = tableView.dequeueReusableCell(withIdentifier: KospenIdentifier.StringCell, for: indexPath)
                    cell.selectionStyle = .none
                    return cell
                } else {
                    let cell = tableView.dequeueReusableCell(withIdentifier: KospenIdentifier.BMIRecordCell, for: indexPath) as! BMIRecordCell
                    cell.selectionStyle = .none
                    cell.height = "\(profileData[KospenProfileIdentifier.Height] as! CGFloat) m"
                    cell.updateUI(bmiData[indexPath.row - 2])
                    
                    return cell
                }
                
            } else if indexPath.section == 1 {
                if index == 0 {
                    let cell = tableView.dequeueReusableCell(withIdentifier: KospenIdentifier.ChartCell, for: indexPath) as! ChartCell
                    let dateArray = getDateArray(glucoseData)
                    cell.selectionStyle = .none
                    cell.updateGlucoseCharts(glucoseData, dateArray: dateArray)
                    return cell
                } else if index == 1 {
                    
                    let cell = tableView.dequeueReusableCell(withIdentifier: KospenIdentifier.StringCell, for: indexPath)
                    cell.selectionStyle = .none
                    return cell
                } else {
                    let cell = tableView.dequeueReusableCell(withIdentifier: KospenIdentifier.RecordCell, for: indexPath) as! RecordCell
                    cell.selectionStyle = .none
                    cell.updateUI(glucoseData[indexPath.row - 2])
                    return cell
                }
            } else {
                if index == 0 {
                    let cell = tableView.dequeueReusableCell(withIdentifier: KospenIdentifier.ImageViewCell, for: indexPath)
                    
                    cell.selectionStyle = .none
                    let imageView = cell.viewWithTag(1) as! UIImageView
                    imageView.contentMode = .scaleToFill
                    imageView.image = #imageLiteral(resourceName: "myhealth-bp-guide")
                    
                    return cell
                } else if index == 1 {
                    
                    let cell = tableView.dequeueReusableCell(withIdentifier: KospenIdentifier.StringCell, for: indexPath)
                    cell.selectionStyle = .none
                    return cell
                } else {
                    let cell = tableView.dequeueReusableCell(withIdentifier: KospenIdentifier.RecordCell, for: indexPath) as! RecordCell
                    cell.selectionStyle = .none
                    cell.updateUI(bloodPressureData[indexPath.row - 2])
                    return cell
                }
            }
        }
    }
    
    //make an array for date indicator for each section.
    private func getDateArray(_ graphData: [GraphData]) -> [Int] {
        
        var intTemp = [Int]()
        
        for data in graphData {
            
            let formatter = DateFormatter()
            formatter.dateFormat = "yyyy-MM-dd HH:mm:ss"
            let date = formatter.date(from: data.createdDate!)!
            let components = Calendar.current.dateComponents([.day], from: date)
            intTemp.append(components.day!)
        }
        
        return intTemp
    }
    
    private func getDateTitle(_ dateString: String) -> String {
        
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd HH:mm:ss"
        let date = formatter.date(from: dateString)!
        
        formatter.dateFormat = "MMMM yyyy"
        let newDateString = formatter.string(from: date)
        
        return newDateString
    }
    
    private func setupTitleCell(_ cell: UITableViewCell, dateString: String, titleString: String = "") {
        
        cell.selectionStyle = .none
        let monthName = cell.viewWithTag(1) as! UILabel
        let bmiLabel = cell.viewWithTag(2) as! UILabel
        monthName.text = dateString
        bmiLabel.text = ""
    }
    
    func populateStatusDataIntoCell(_ tableView: UITableView, indexPath: IndexPath) -> UITableViewCell {
        
        let index = indexPath.row
        
        if index == 0 {
            let cell = tableView.dequeueReusableCell(withIdentifier: KospenIdentifier.StatusValueCell, for: indexPath) as! MyKospenStatusCell
            
            cell.selectionStyle = .none
            cell.updateUIWithString(KospenProfileIdentifier.BloodSugarLevel, value: "\(profileData[KospenProfileIdentifier.BloodSugarLevel] ?? "-")")
            
            return cell
        } else if index == 1 {
            let cell = tableView.dequeueReusableCell(withIdentifier: KospenIdentifier.StatusValueCell, for: indexPath) as! MyKospenStatusCell
            
            cell.selectionStyle = .none
            cell.updateUIWithIntValue(KospenProfileIdentifier.BeratBadan, value: profileData[KospenProfileIdentifier.BeratBadan] as! Int, indicator: "kg")
            
            return cell
        } else if index == 2 {
            let cell = tableView.dequeueReusableCell(withIdentifier: KospenIdentifier.StatusValueCell, for: indexPath) as! MyKospenStatusCell
            
            cell.selectionStyle = .none
            cell.updateUIWithCGFloatValue(KospenProfileIdentifier.Height, value: profileData[KospenProfileIdentifier.Height] as! CGFloat, indicator: "m")
            
            return cell
        } else if index == 3 {
            let cell = tableView.dequeueReusableCell(withIdentifier: KospenIdentifier.StatusValueCell, for: indexPath) as! MyKospenStatusCell
            
            cell.selectionStyle = .none
            cell.updateUIWithString(KospenProfileIdentifier.BloodPressure, value: profileData[KospenProfileIdentifier.BloodPressure] as! String, fontSize: 10)
            
            return cell
        } else {
            let cell = tableView.dequeueReusableCell(withIdentifier: KospenIdentifier.StatusValueCell, for: indexPath) as! MyKospenStatusCell
            
            cell.selectionStyle = .none
            cell.updateStatusMerokokCell(KospenProfileIdentifier.SmokingStatus, value: profileData[KospenProfileIdentifier.SmokingStatus] as! Int)
            
            return cell
        }
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        //ip5 175.0
        
        if tableView == statusTableView {
            return 35.0
        } else {
            //let height: CGFloat = UIScreen.main.nativeBounds.height <= 1136 ? 180.0 : 200.0
            
            if indexPath.section == 2 && indexPath.row == 0 {
                return 200
            }
            
            return UITableViewAutomaticDimension
        }
    }
}







