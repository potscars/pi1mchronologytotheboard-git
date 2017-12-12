//
//  KospenProfile.swift
//  dashboardv2
//
//  Created by Hainizam on 04/12/2017.
//  Copyright © 2017 Ingeniworks Sdn Bhd. All rights reserved.
//

import UIKit

struct KospenProfileIdentifier {
    
    static let Intervensi = "Setuju intervensi"
    static let WaistMeasure = "Ukur lilit pinggang"
    static let Height = "Tinggi"
    static let OwnDiseases = "Sejarah penyakit sendiri"
    static let FamilyDiseases = "Sejarah penyakit keluarga"
    static let SmokingStatus = "Status merokok"
    static let isQuittingSmoke = "Ingin berhenti merokok"
    static let UpdatedAt = "Dikemaskini pada"
}

class KospenProfile {
    
    func fetchProfileData(completion: @escaping ([String: Any]?, String?) -> ()) {
        
        let dashToken = UserDefaults.standard.object(forKey: "SuccessLoggerDashboardToken") as! String
        
        let networkProcessor = NetworkProcessor.init(DBSettings.kospenUserDetailsURL)
        
        let params = ["token" : dashToken]
        var dataTemp: [String: Any] = [:]
        
        var intervensiTemp = "Tiada data"
        var waistMeasureTemp: CGFloat = 0.0
        var heightTemp = "Tiada data"
        var smokingStatusTemp = "Tiada data"
        var smokingQuittingStatusTemp = "Tiada data"
        var ownDiseasesTemp: NSArray = []
        var familyDiseasesTemp: NSArray = []
        
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd HH:mm:ss"
        var updatedAtTemp = "Tiada data"
        
        networkProcessor.postRequestJSONFromUrl(params) { (result, responses) in
            
            guard responses == nil else {
                return
            }

            guard let result = result else { return }
            print(result)
            if let status = result["status"] as? Int, status == 1 {

                if let data = result["data"] as? NSDictionary {
                    print(data)
                    if let intervensi_agree = data["intervention_agree"] as? Int {

                        if intervensi_agree == 1 {
                            intervensiTemp = "Setuju"
                        } else {
                            intervensiTemp = "Tidak setuju"
                        }
                    }

                    if let waist_measure = data.object(forKey: "measure_waist") as? Int {
                        waistMeasureTemp = CGFloat(waist_measure)
                    }

                    if let height = data.object(forKey: "height") {
                        heightTemp = "\(height) m"
                    }

                    if let smoking_status = data["smoking_status"] as? Int {

                        if smoking_status == 1 {
                            smokingStatusTemp = "Ya"
                        } else {
                            smokingStatusTemp = "Tidak"
                        }
                    }

                    if let smokeQuittingStatus = data["want_to_quit_smoking"] as? Int {
                        if smokeQuittingStatus == 1 {
                            smokingQuittingStatusTemp = "Ya"
                        } else {
                            smokingQuittingStatusTemp = "Tidak"
                        }
                    }

                    if let ownDiseases = data["disease_self"] as? NSArray {
                        ownDiseasesTemp = ownDiseases
                    }

                    if let familyDiseases = data["disease_family"] as? NSArray {
                        familyDiseasesTemp = familyDiseases
                    }

                    if let updatedAt = data["updated_at"] as? String {

                        let date: Date = dateFormatter.date(from: updatedAt)!

                        let dateFormatterString = DateFormatter()
                        dateFormatterString.dateFormat = "MMM dd, yyyy"

                        updatedAtTemp = dateFormatterString.string(from: date)
                    }

                    dataTemp = self.addingToDictionary(intervensiTemp, waistMeasure: waistMeasureTemp, height: heightTemp, smokingStatus: smokingStatusTemp, ownDiseases: ownDiseasesTemp, inheritedDiseases: familyDiseasesTemp, isWillingToQuitSmoking: smokingQuittingStatusTemp, updatedAt: updatedAtTemp)

                    completion(dataTemp, nil)
                } else {
                    dataTemp = self.addingToDictionary(intervensiTemp, waistMeasure: waistMeasureTemp, height: heightTemp, smokingStatus: smokingStatusTemp, ownDiseases: ownDiseasesTemp, inheritedDiseases: familyDiseasesTemp, isWillingToQuitSmoking: smokingQuittingStatusTemp, updatedAt: updatedAtTemp)

                    completion(dataTemp, nil)
                }
            }
        }
    }
    
    
    func addingToDictionary(_ intervensi: String, waistMeasure: CGFloat, height: String, smokingStatus: String, ownDiseases: NSArray, inheritedDiseases: NSArray, isWillingToQuitSmoking: String, updatedAt: String) -> [String: Any] {
        
        var tempProfileData: [String: Any] = [:]
        
        tempProfileData.updateValue(intervensi, forKey: KospenProfileIdentifier.Intervensi)
        tempProfileData.updateValue(waistMeasure, forKey: KospenProfileIdentifier.WaistMeasure)
        tempProfileData.updateValue(height, forKey: KospenProfileIdentifier.Height)
        tempProfileData.updateValue(smokingStatus, forKey: KospenProfileIdentifier.SmokingStatus)
        tempProfileData.updateValue(isWillingToQuitSmoking, forKey: KospenProfileIdentifier.isQuittingSmoke)
        tempProfileData.updateValue(ownDiseases, forKey: KospenProfileIdentifier.OwnDiseases)
        tempProfileData.updateValue(inheritedDiseases, forKey: KospenProfileIdentifier.FamilyDiseases)
        tempProfileData.updateValue(updatedAt, forKey: KospenProfileIdentifier.UpdatedAt)
        
        return tempProfileData
    }
}
















