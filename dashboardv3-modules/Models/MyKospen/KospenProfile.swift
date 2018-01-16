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
    static let BloodPressure = "Tekanan Darah"
    static let BloodSugarLevel = "Tahap Gula"
    static let OwnDiseases = "Sejarah penyakit sendiri"
    static let FamilyDiseases = "Sejarah penyakit keluarga"
    static let SmokingStatus = "Status merokok"
    static let isQuittingSmoke = "Ingin berhenti merokok"
    static let UpdatedAt = "Dikemaskini pada"
    static let BeratBadan = "Berat Badan"
    static let BMI = "BMI"
}

class KospenProfile {
    
    func fetchProfileData(completion: @escaping ([String: Any]?, String?) -> ()) {
        
        let dashToken = UserDefaults.standard.object(forKey: "SuccessLoggerDashboardToken") as! String
        
        let networkProcessor = NetworkProcessor.init(DBSettings.kospenUserDetailsURL)
        
        let params = ["token" : dashToken]
        var dataTemp: [String: Any] = [:]
        
        var intervensiTemp = "-"
        var waistMeasureTemp: CGFloat = 0.0
        var heightTemp: CGFloat = 0.0
        var smokingStatusTemp = "-"
        var smokingQuittingStatusTemp = "-"
        var bloodSugarLevel = 0
        var sysDysTemp = "-"
        var weightTemp = 0
        var idTemp = 0
        var hBMITemp = 0.0
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

            if let status = result["status"] as? Int, status == 1 {

                if let data = result["data"] as? NSDictionary {
                    
                    if let id = data["id"] as? Int {
                        idTemp = id
                    }
                    
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

                    if let height = data.object(forKey: "height") as? CGFloat {
                        heightTemp = height
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
                    
                    if let wtRecords = data.object(forKey: "wt_records") as? NSArray {
                        
                        for wtRecord in wtRecords {
                            
                            if let bodyWeight = (wtRecord as AnyObject).object(forKey: "weight") as? Int {
                                weightTemp = bodyWeight
                            }
                            
                            if let bmi = (wtRecord as AnyObject).object(forKey: "bmi") as? Double {
                                let bmiTemp = round(bmi * 100) / 100
                                hBMITemp = bmiTemp
                            }
                        }
                    }
                    
                    if let gluRecords = data.object(forKey: "glu_records") as? NSArray {
                        
                        for gluRecord in gluRecords {
                            
                            if let glucoseLevel = (gluRecord as AnyObject).object(forKey: "glucose_level") as? Int {
                                bloodSugarLevel = glucoseLevel
                            }
                        }
                    }
                    
                    if let bpRecords = data.object(forKey: "bp_records") as? NSArray {
                        
                        for bpRecord in bpRecords {
                            
                            var sysDys = ""
                            
                            if let sys = (bpRecord as AnyObject).object(forKey: "sys") as? Int {
                                sysDys = "\(sys)/"
                            }
                            
                            if let dys = (bpRecord as AnyObject).object(forKey: "dys") as? Int {
                                sysDys += "\(dys)"
                                sysDysTemp = sysDys
                            }
                        }
                    }

                    dataTemp = self.addingToDictionary(intervensiTemp, waistMeasure: waistMeasureTemp, height: heightTemp, smokingStatus: smokingStatusTemp, ownDiseases: ownDiseasesTemp, inheritedDiseases: familyDiseasesTemp, isWillingToQuitSmoking: smokingQuittingStatusTemp, updatedAt: updatedAtTemp, bloodSugarLevel: bloodSugarLevel, bloodPressure: sysDysTemp, weight: weightTemp, id: idTemp, bmi: hBMITemp)

                    completion(dataTemp, nil)
                } else {
                    dataTemp = self.addingToDictionary(intervensiTemp, waistMeasure: waistMeasureTemp, height: heightTemp, smokingStatus: smokingStatusTemp, ownDiseases: ownDiseasesTemp, inheritedDiseases: familyDiseasesTemp, isWillingToQuitSmoking: smokingQuittingStatusTemp, updatedAt: updatedAtTemp, bloodSugarLevel: bloodSugarLevel, bloodPressure: sysDysTemp, weight: weightTemp, id: idTemp, bmi: hBMITemp)

                    completion(dataTemp, nil)
                }
            }
        }
    }
    
    
    func addingToDictionary(_ intervensi: String, waistMeasure: CGFloat, height: CGFloat, smokingStatus: String, ownDiseases: NSArray, inheritedDiseases: NSArray, isWillingToQuitSmoking: String, updatedAt: String, bloodSugarLevel: Int, bloodPressure: String, weight: Int, id: Int, bmi: Double) -> [String: Any] {
        
        var tempProfileData: [String: Any] = [:]
        
        tempProfileData.updateValue(intervensi, forKey: KospenProfileIdentifier.Intervensi)
        tempProfileData.updateValue(waistMeasure, forKey: KospenProfileIdentifier.WaistMeasure)
        tempProfileData.updateValue(height, forKey: KospenProfileIdentifier.Height)
        tempProfileData.updateValue(smokingStatus, forKey: KospenProfileIdentifier.SmokingStatus)
        tempProfileData.updateValue(isWillingToQuitSmoking, forKey: KospenProfileIdentifier.isQuittingSmoke)
        tempProfileData.updateValue(ownDiseases, forKey: KospenProfileIdentifier.OwnDiseases)
        tempProfileData.updateValue(inheritedDiseases, forKey: KospenProfileIdentifier.FamilyDiseases)
        tempProfileData.updateValue(updatedAt, forKey: KospenProfileIdentifier.UpdatedAt)
        tempProfileData.updateValue(bloodSugarLevel, forKey: KospenProfileIdentifier.BloodSugarLevel)
        tempProfileData.updateValue(bloodPressure, forKey: KospenProfileIdentifier.BloodPressure)
        tempProfileData.updateValue(weight, forKey: KospenProfileIdentifier.BeratBadan)
        tempProfileData.updateValue(id, forKey: "MYHEALTH_ID")
        tempProfileData.updateValue(bmi, forKey: KospenProfileIdentifier.BMI)
        
        return tempProfileData
    }
}
















