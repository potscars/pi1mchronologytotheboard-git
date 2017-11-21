//
//  MyHealthData.swift
//  dashboardv2
//
//  Created by Mohd Zulhilmi Mohd Zain on 15/11/2017.
//  Copyright © 2017 Ingeniworks Sdn Bhd. All rights reserved.
//

import UIKit

class MyHealthData: NSObject {

}

class MyHealthKospenData: NSObject {
    
    private var resultFromServer: NSDictionary = [:]
    private var data: NSDictionary = [:]
    private var gluRecData: NSDictionary = [:]
    
    /// Initializing all data from MyHealth Kospen
    init(resultFromServer: NSDictionary) {
        self.resultFromServer = resultFromServer
        self.data = self.resultFromServer.value(forKey: "data") as? NSDictionary ?? [:]
        self.glucoseRecord = MyHealthKospenGlucoseArrays.init(gdArray: self.data.value(forKey: "glu_records") as? NSArray ?? [])
        self.weightRecord = MyHealthKospenWeightArrays.init(wtArray: self.data.value(forKey: "wt_records") as? NSArray ?? [])
        self.bloodPressureRecord = MyHealthKospenBloodPressureArrays.init(bpArray: self.data.value(forKey: "bp_records") as? NSArray ?? [])
    }
    
    var dataStatus: Int {
        get {
            return (self.resultFromServer.value(forKey: "status") as? Int ?? 0)!
        }
    }
    
    var status: Int {
        get {
            return (self.data.value(forKey: "status") as? Int ?? 0)!
        }
    }
    
    var id: Int {
        get {
            return (self.data.value(forKey: "id") as? Int ?? 0)!
        }
    }
    
    var userId: Int {
        get {
            return (self.data.value(forKey: "user_id") as? Int ?? 0)!
        }
    }
    
    var diseaseHistory: String {
        get {
            return (self.data.value(forKey: "disease_history") as? String ?? nil)!
        }
    }
    
    var diseaseFamilyHistory: String {
        get {
            return (self.data.value(forKey: "disease_family_history") as? String ?? nil)!
        }
    }
    
    var height: Float {
        get {
            return (self.data.value(forKey: "height") as? Float ?? 0.0)!
        }
    }
    
    var intervention: Bool {
        get {
            return (self.data.value(forKey: "intervention_agree") as? Bool ?? false)!
        }
    }
    
    var measureWaist: Int {
        get {
            return (self.data.value(forKey: "measure_waist") as? Int ?? 0)!
        }
    }
    
    var smokingStatus: Int {
        get {
            return (self.data.value(forKey: "smoking_status") as? Int ?? 0)!
        }
    }
    
    var wantToQuitSmoking: Int {
        get {
            return (self.data.value(forKey: "want_to_quit_smoking") as? Int ?? 0)!
        }
    }
    
    var stress: Bool {
        get {
            return (self.data.value(forKey: "stress") as? Bool ?? false)!
        }
    }
    
    var depression: Bool {
        get {
            return (self.data.value(forKey: "depression") as? Bool ?? false)!
        }
    }
    
    var anxiety: Bool {
        get {
            return (self.data.value(forKey: "anxiety") as? Bool ?? false)!
        }
    }
    
    var hyperTensionStatus: Int {
        get {
            return (self.data.value(forKey: "myhealth_hypertension_status_id") as? Int ?? 0)!
        }
    }
    
    var bmiStatus: Int {
        get {
            return (self.data.value(forKey: "myhealth_bmi_status_id") as? Int ?? 0)!
        }
    }
    
    var diabetesStatus: Int {
        get {
            return (self.data.value(forKey: "myhealth_diabetes_status_id") as? Int ?? 0)!
        }
    }
    
    var glucoseRecord: MyHealthKospenGlucoseArrays
    var weightRecord: MyHealthKospenWeightArrays
    var bloodPressureRecord: MyHealthKospenBloodPressureArrays
}

class MyHealthKospenGlucoseArrays: NSObject {
    
    private var gdArray: NSArray = []
    
    /// Initializing Glucose Data in arrays
    init(gdArray: NSArray) {
        self.gdArray = gdArray
        super.init()
    }
    
    /// Read-only. Return count of Glucose data
    var totalData: Int {
        get {
            return self.gdArray.count
        }
    }
    
    /// Return Glucose data on specific index of arrays
    func object(atIndex: Int) -> MyHealthKospenGlucoseData {
        
        let gdData: MyHealthKospenGlucoseData = MyHealthKospenGlucoseData.init(gdData: self.gdArray.object(at: atIndex) as! NSDictionary)
        
        return gdData
    }
    
}

class MyHealthKospenGlucoseData: NSObject {
    
    private var gData: NSDictionary = [:]
    
    /// Initializing Glucose Data.
    init(gdData: NSDictionary){
        self.gData = gdData
        super.init()
    }
    
    var id: Int {
        get {
            return (self.gData.value(forKey: "id") as? Int ?? 0)!
        }
    }
    
    var level: Int {
        get {
            return (self.gData.value(forKey: "glucose_level") as? Int ?? 0)!
        }
    }
    
    var diabetes: Int {
        get {
            return (self.gData.value(forKey: "diabetes") as? Int ?? 0)!
        }
    }
    
    var myHealthId: Int {
        get {
            return (self.gData.value(forKey: "myhealth_id") as? Int ?? 0)!
        }
    }
    
    var myHealthVendor: Int {
        get {
            return (self.gData.value(forKey: "myhealth_vendor_id") as? Int ?? 0)!
        }
    }
    
}

class MyHealthKospenWeightArrays: NSObject {
    
    private var wtArray: NSArray = []
    
    /// Initializing Weight Data in arrays
    init(wtArray: NSArray) {
        self.wtArray = wtArray
        super.init()
    }
    
    /// Read-only. Return count of Weight Data
    var totalData: Int {
        get {
            return self.wtArray.count
        }
    }
    
    /// Return Weight Data on specific index of arrays
    func object(atIndex: Int) -> MyHealthKospenWeightData {
        
        let wtData: MyHealthKospenWeightData = MyHealthKospenWeightData.init(wtData: self.wtArray.object(at: atIndex) as! NSDictionary)
        
        return wtData
    }
    
}

class MyHealthKospenWeightData: NSObject {
    
    private var wtData: NSDictionary = [:]
    
    init(wtData: NSDictionary) {
        self.wtData = wtData
        super.init()
    }
    
    var id: Int {
        get {
            return (self.wtData.value(forKey: "id") as? Int ?? 0)!
        }
    }
    
    var weight: Int {
        get {
            return (self.wtData.value(forKey: "weight") as? Int ?? 0)!
        }
    }
    
    var bmi: Float {
        get {
            return (self.wtData.value(forKey: "bmi") as? Float ?? 0.0)!
        }
    }
    
    var fat: Int {
        get {
            return (self.wtData.value(forKey: "fat") as? Int ?? 0)!
        }
    }
    
    var muscle: Int {
        get {
            return (self.wtData.value(forKey: "muscale") as? Int ?? 0)!
        }
    }
    
    var water: Int {
        get {
            return (self.wtData.value(forKey: "water") as? Int ?? 0)!
        }
    }
    
    var bone: Int {
        get {
            return (self.wtData.value(forKey: "bone") as? Int ?? 0)!
        }
    }
    
    var leanWeight: Int {
        get {
            return (self.wtData.value(forKey: "lean_weight") as? Int ?? 0)!
        }
    }
    
    var myHealthId: Int {
        get {
            return (self.wtData.value(forKey: "myhealth_id") as? Int ?? 0)!
        }
    }
    
    var myHealthVendorId: Int {
        get {
            return (self.wtData.value(forKey: "myhealth_vendor_id") as? Int ?? 0)!
        }
    }
    
}

class MyHealthKospenBloodPressureArrays: NSObject {
    
    private var bpArray: NSArray = []
    
    /// Initializing Blood Pressure Data in arrays
    init(bpArray: NSArray) {
        self.bpArray = bpArray
        super.init()
    }
    
    /// Read-only. Return count of Blood Pressure Data
    var totalData: Int {
        get {
            return self.bpArray.count
        }
    }
    
    /// Return Blood Pressure Data on specific index of arrays
    func object(atIndex: Int) -> MyHealthKospenBloodPressureData {
        
        let bpData: MyHealthKospenBloodPressureData = MyHealthKospenBloodPressureData.init(bpData: self.bpArray.object(at: atIndex) as! NSDictionary)
        
        return bpData
    }
    
}

class MyHealthKospenBloodPressureData: NSObject {
    
    private var bpData: NSDictionary = [:]
    
    init(bpData: NSDictionary) {
        self.bpData = bpData
        super.init()
    }
    
    var id: Int {
        get {
            return (self.bpData.value(forKey: "id") as? Int ?? 0)!
        }
    }
    
    var systolic: Int {
        get {
            return (self.bpData.value(forKey: "sys") as? Int ?? 0)!
        }
    }
    
    var dyastolic: Int {
        get {
            return (self.bpData.value(forKey: "dys") as? Int ?? 0)!
        }
    }
    
    var pulse: Int {
        get {
            return (self.bpData.value(forKey: "pulse") as? Int ?? 0)!
        }
    }
    
    var hypertension: Int {
        get {
            return (self.bpData.value(forKey: "hypertension") as? Int ?? 0)!
        }
    }
    
    var myHealthId: Int {
        get {
            return (self.bpData.value(forKey: "myhealth_id") as? Int ?? 0)!
        }
    }
    
    var myHealthVendorId: Int {
        get {
            return (self.bpData.value(forKey: "myhealth_vendor_id") as? Int ?? 0)!
        }
    }
}
