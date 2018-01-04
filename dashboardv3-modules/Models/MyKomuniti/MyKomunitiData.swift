//
//  MyKomunitiData.swift
//  dashboardv2
//
//  Created by Mohd Zulhilmi Mohd Zain on 22/11/2017.
//  Copyright © 2017 Ingeniworks Sdn Bhd. All rights reserved.
//

import UIKit

class MyKomunitiKeys: NSObject {
    
    private var dictData: NSDictionary = [:]
    
    init(dictData: NSDictionary) {
        self.dictData = dictData
    }
    
    var pagination: MyKomunitiKeysPagination {
        get {
            return MyKomunitiKeysPagination.init(dictData: self.dictData)
        }
    }
    
    var data: MyKomunitiKeysData {
        get {
            return MyKomunitiKeysData.init(dataArrays: self.dictData.value(forKey: "data") as? NSArray ?? [])
        }
    }
    
    var dataRaw: NSArray {
        get {
            return self.dictData.value(forKey: "data") as? NSArray ?? []
        }
    }

}

class MyKomunitiKeysPagination: NSObject {

    private var dictData: NSDictionary = [:]
    
    init(dictData: NSDictionary) {
        self.dictData = dictData
    }
    
    var total: Int {
        get {
            return dictData.value(forKey: "total") as? Int ?? 0
        }
    }
    var perPage: Int {
        get {
            return dictData.value(forKey: "per_page") as? Int ?? 0
        }
    }
    var currentPage: Int {
        get {
            return dictData.value(forKey: "current_page") as? Int ?? 0
        }
    }
    var lastPage: Int {
        get {
            return dictData.value(forKey: "last_page") as? Int ?? 0
        }
    }
    var from: Int {
        get {
            return dictData.value(forKey: "from") as? Int ?? 0
        }
    }
    var to: Int {
        get {
            return dictData.value(forKey: "to") as? Int ?? 0
        }
    }
    
}

class MyKomunitiKeysData: NSObject {
    
    private var dataArrays: NSArray = []
    
    init(dataArrays: NSArray) {
        self.dataArrays = dataArrays
    }
    
    var totalData: Int {
        get {
            return self.dataArrays.count
        }
    }
    
    func object(atIndex: Int) -> MyKomunitiKeysDataKeys {
        return MyKomunitiKeysDataKeys.init(dataDict: self.dataArrays.object(at: atIndex) as? NSDictionary ?? [:])
    }
}

class MyKomunitiKeysDataKeys: NSObject {
    
    private var dataDict: NSDictionary = [:]
    
    init(dataDict: NSDictionary) {
        self.dataDict = dataDict
        self.user = MyKomunitiKeysDataUserKeys.init(dataDict: self.dataDict.value(forKey: "user") as? NSDictionary ?? [:])
        self.userRaw = dataDict.value(forKey: "user") as? NSDictionary ?? [:]
    }
    
    var id: Int {
        get {
            return self.dataDict.value(forKey: "id") as? Int ?? 0
        }
    }
    
    var userId: Int {
        get {
            return self.dataDict.value(forKey: "user_id") as? Int ?? 0
        }
    }
    
    var siteId: Int {
        get {
            return self.dataDict.value(forKey: "site_id") as? Int ?? 0
        }
    }
    
    var title: String {
        get {
            return self.dataDict.value(forKey: "title") as? String ?? "N/A"
        }
    }
    
    var content: String {
        get {
            return self.dataDict.value(forKey: "content") as? String ?? "N/A"
        }
    }
    
    var excerpt: String {
        get {
            return self.dataDict.value(forKey: "excerpt") as? String ?? "N/A"
        }
    }
    
    var approval: Int {
        get {
            return self.dataDict.value(forKey: "approval") as? Int ?? 0
        }
    }
    
    var createdAt: String {
        get {
            return self.dataDict.value(forKey: "created_at") as? String ?? "0000-00-00 00:00:00"
        }
    }
    
    var updatedAt: String {
        get {
            return self.dataDict.value(forKey: "updated_at") as? String ?? "0000-00-00 00:00:00"
        }
    }
    
    var user: MyKomunitiKeysDataUserKeys
    var userRaw: NSDictionary
}

class MyKomunitiKeysDataUserKeys: NSObject {
    
    private var dataDict: NSDictionary = [:]
    
    init(dataDict: NSDictionary) {
        self.dataDict = dataDict
        self.site = MyKomunitiKeysDataUserSiteKeys.init(dataDict: dataDict.value(forKey: "site") as? NSDictionary ?? [:])
        self.siteRaw = dataDict.value(forKey: "site") as? NSDictionary ?? [:]
    }
    
    var id: Int {
        get {
            return self.dataDict.value(forKey: "id") as? Int ?? 0
        }
    }
    
    var fbId: Int {
        get {
            return self.dataDict.value(forKey: "fb_id") as? Int ?? 0
        }
    }
    
    var fbToken: String {
        get {
            return self.dataDict.value(forKey: "fb_token") as? String ?? "N/A"
        }
    }
    
    var icNumber: String {
        get {
            return self.dataDict.value(forKey: "ic_no") as? String ?? "N/A"
        }
    }
    
    var dateOfBirth: String {
        get {
            return self.dataDict.value(forKey: "dob") as? String ?? "0000-00-00"
        }
    }
    
    var genderId: Int {
        get {
            return self.dataDict.value(forKey: "gender_id") as? Int ?? 0
        }
    }
    
    var occupationId: Int {
        get {
            return self.dataDict.value(forKey: "occupation_id") as? Int ?? 0
        }
    }
    
    var email: String {
        get {
            return self.dataDict.value(forKey: "email") as? String ?? "N/A"
        }
    }
    
    var fullName: String {
        get {
            return self.dataDict.value(forKey: "full_name") as? String ?? "N/A"
        }
    }
    
    var verified: Int {
        get {
            return self.dataDict.value(forKey: "verified") as? Int ?? 0
        }
    }
    
    var emailVerified: Int {
        get {
            return self.dataDict.value(forKey: "email_verified") as? Int ?? 0
        }
    }
    
    var eventVerified: Int {
        get {
            return self.dataDict.value(forKey: "event_verified") as? Int ?? 0
        }
    }
    
    var phone: String {
        get {
            return self.dataDict.value(forKey: "phone") as? String ?? "N/A"
        }
    }
    
    var userTypeId: Int {
        get {
            return self.dataDict.value(forKey: "usertype_id") as? Int ?? 0
        }
    }
    
    var appName: Int {
        get {
            return self.dataDict.value(forKey: "app_name") as? Int ?? 0
        }
    }
    
    var isAdmin: Int {
        get {
            return self.dataDict.value(forKey: "is_admin") as? Int ?? 0
        }
    }
    
    var isVolunteer: Int {
        get {
            return self.dataDict.value(forKey: "is_volunteer") as? Int ?? 0
        }
    }
    
    var siteId: Int {
        get {
            return self.dataDict.value(forKey: "site_id") as? Int ?? 0
        }
    }
    
    var posterGroupId: Int {
        get {
            return self.dataDict.value(forKey: "poster_group_id") as? Int ?? 0
        }
    }
    
    var posterGroupOwnership: String {
        get {
            return self.dataDict.value(forKey: "poster_group_ownership") as? String ?? "N/A"
        }
    }
    
    var rememberToken: String {
        get {
            return self.dataDict.value(forKey: "remember_token") as? String ?? "N/A"
        }
    }
    
    var createdAt: String {
        get {
            return self.dataDict.value(forKey: "created_at") as? String ?? "0000-00-00 00:00:00"
        }
    }
    
    var updatedAt: String {
        get {
            return self.dataDict.value(forKey: "updated_at") as? String ?? "0000-00-00 00:00:00"
        }
    }
    
    var site: MyKomunitiKeysDataUserSiteKeys
    var siteRaw: NSDictionary
    
}

class MyKomunitiKeysDataUserSiteKeys: NSObject {
    
    private var dataDict: NSDictionary = [:]
    
    init(dataDict: NSDictionary) {
        self.dataDict = dataDict
    }
    
    var id: Int {
        get {
            return self.dataDict.value(forKey: "id") as? Int ?? 0
        }
    }
    
    var code: String {
        get {
            return self.dataDict.value(forKey: "code") as? String ?? "N/A"
        }
    }
    
    var address: String {
        get {
            return self.dataDict.value(forKey: "address") as? String ?? "N/A"
        }
    }
    
    var regionId: Int {
        get {
            return self.dataDict.value(forKey: "region_id") as? Int ?? 0
        }
    }
    
    var state: String {
        get {
            return self.dataDict.value(forKey: "state") as? String ?? "N/A"
        }
    }
    
    var clusterId: Int {
        get {
            return self.dataDict.value(forKey: "cluster_id") as? Int ?? 0
        }
    }
    
    var email: String {
        get {
            return self.dataDict.value(forKey: "email") as? String ?? "N/A"
        }
    }
    
    var stateId: Int {
        get {
            return self.dataDict.value(forKey: "state_id") as? Int ?? 0
        }
    }
    
    var phaseId: Int {
        get {
            return self.dataDict.value(forKey: "phase_id") as? Int ?? 0
        }
    }
    
    var appName: Int {
        get {
            return self.dataDict.value(forKey: "app_name") as? Int ?? 0
        }
    }
    
    var status: Int {
        get {
            return self.dataDict.value(forKey: "status") as? Int ?? 0
        }
    }
    
    var createdAt: String {
        get {
            return self.dataDict.value(forKey: "created_at") as? String ?? "0000-00-00 00:00:00"
        }
    }
    
    var updatedAt: String {
        get {
            return self.dataDict.value(forKey: "updated_at") as? String ?? "0000-00-00 00:00:00"
        }
    }
    
    var ipv4: String {
        get {
            return self.dataDict.value(forKey: "ipv4") as? String ?? "N/A"
        }
    }
}

class MyKomunitiAnnouncementListing: NSObject {
    
    private var data: NSDictionary = [:]
    private var gatherData: NSArray = []
    
    override init() {
        super.init()
    }
    
    func addData(data: NSDictionary) {
        self.data = data
        self.gatherData.adding(self.data)
    }
    
    var totalData: Int {
        get {
            return self.gatherData.count
        }
    }
    
    func retrieveData(fromIndex: Int) -> MyKomunitiAnnouncementListingKeys {
        
        let splittedData: NSDictionary = self.gatherData.object(at: fromIndex) as! NSDictionary
        let listKeys: MyKomunitiAnnouncementListingKeys = MyKomunitiAnnouncementListingKeys.init()
        
        listKeys.title = splittedData.value(forKey: "title") as? String ?? "N/A"
        listKeys.summaryArticle = splittedData.value(forKey: "excerpt") as? String ?? "N/A"
        
        return listKeys
    }
    
}

class MyKomunitiAnnouncementListingKeys: NSObject {
    
    private var titleKeys: String = "N/A"
    private var summaryArticleKeys: String = "N/A"
    
    var title: String {
        get {
            return titleKeys
        } set (newTitle) {
            titleKeys = newTitle
        }
    }
    
    var summaryArticle: String {
        get {
            return summaryArticleKeys
        } set (newSummaryArticle) {
            summaryArticleKeys = newSummaryArticle
        }
    }
    
}
