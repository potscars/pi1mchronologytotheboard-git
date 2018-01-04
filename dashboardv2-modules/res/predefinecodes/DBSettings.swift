//
//  DBSettings.swift
//  dashboardv2
//
//  Created by Mohd Zulhilmi Mohd Zain on 06/12/2016.
//  Copyright © 2016 Ingeniworks Sdn Bhd. All rights reserved.
//

import UIKit

class DBSettings: NSObject {
    
    // refer to api worksheet
    
    //Global Settings goes here
    
    static let dbLoginOS: String = "ios"
    
    //Main URLS
    
    static let mainURL: String = "http://dashboard.pi1m.my"
    static let mySoalMainURL: String = "http://mysoal.pi1m.my"
    static let mySkoolMainURL: String = "http://myskool.pi1m.my"
    static let myShopMainURL: String = "http://myshop.pi1m.my"
    static let adminMainURL: String = "http://admin.pi1m.my"
    
    //Main URL - Debug
    static let myAppURL: String = "http://dashboard.myapp.my"
    static let adminMyAppURL: String = "http://admin.myapp.my"
    
    //Sub URLS
    
    static let loginURL: String = "\(mainURL)/mobile/session/login"
    static let myKomunitiAdminURL: String = "\(mainURL)/api/announcement/hq-announcements/"
    static let myKomunitiPublicURL: String = "\(mainURL)/api/announcement/user-announcements/"
    static let mySoalTokenRetrievalURL: String = "\(mySoalMainURL)/messages/login_dashboardv2/"
    static let mySoalPetiMasukURL: String = "\(mySoalMainURL)/messages/dashboardv2_json_message/inbox/"
    static let mySkoolTokenRetrievalURL: String = "\(mySkoolMainURL)/users/dashboardv2_login/"
    static let mySkoolPetiMasukURL: String = "\(mySkoolMainURL)/walls/dashboardv2_json_wall/"
    static let myHealthBPURL: String = "\(mainURL)/api/myhealth/bp-records/"
    static let myHealthBWURL: String = "\(mainURL)/api/myhealth/weight-records/"
    static let myHealthKospenVerifyURL: String = "\(mainURL)/api/myhealth/test-module"
    static let myHealthKospenDataURL: String = "\(mainURL)/api/myhealth/myhealth-details"
    static let myShopProductDetailsURL: String = "\(myShopMainURL)/api/product/find-product-detail"
    static let myShopLatestProductURL: String = "\(myShopMainURL)/api/product/latest-product-myshop"
    static let myShopPopularProductURL: String = "\(myShopMainURL)/api/product/popular"
    static let myShopHiRatingProductURL: String = "\(myShopMainURL)/api/product/all-product-review"
    static let myShopLocalProductURL: String = "\(myShopMainURL)/api/product/product-by-site"
    static let myShopProductImageThumbURL: String = "\(myShopMainURL)/productImage/thumbs"
    static let myShopProductImageLargeURL: String = "\(myShopMainURL)/productImage/large"
    static let myKomunitiPostAnnouncement = "\(mainURL)/api/announcement/add-announcement"
    static let myQuizGetQuestionURL: String = "\(mainURL)/api/promo/quiz/questions" //should ended with token
    static let myQuizSendAnswerURL: String = "\(mainURL)/api/promo/quiz/answer-question" //should ended with token
    static let myQuizTNCUrl: String = "\(mainURL)/api/promo/TnC/term-and-condition"
    static let myQuizVerifyUserAndEvent: String = "\(mainURL)/api/promo/verify/verified-event" // POST AND GET
    
    static let myGamesTopScorerByRegionURL: String = "\(myAppURL)/api/promo/games/top-ten-score-by-region/"
    
    static let myHealthKospenConfirmation: String = String.init(format: "%@%@", mainURL,"/api/myhealth/test-module")
    static let myHealthKospenDetails: String = String.init(format: "%@%@", mainURL,"/api/myhealth/myhealth-details")
    
    //YTPlayer
    
    static let ytEmbeddedVideo: String = "-S3HyuE368Y"
    
    //Kospen
    static let kospenUserDetailsURL = "\(mainURL)/api/myhealth/myhealth-details"
    static let kospenGrapghDetailsURL = "\(mainURL)/api/myhealth/myhealth-record-graph"
    static let kospenDiseaseListURL = "\(mainURL)/api/myhealth/disease-list"
    
}











