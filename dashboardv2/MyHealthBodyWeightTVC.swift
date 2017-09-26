//
//  MyHealthBodyWeightTVC.swift
//  dashboardv2
//
//  Created by Mohd Zulhilmi Mohd Zain on 24/01/2017.
//  Copyright © 2017 Ingeniworks Sdn Bhd. All rights reserved.
//

import UIKit

class MyHealthBodyWeightTVC: UITableViewController {
    
    let registeredNotification: String = "MyHealthBodyWeightData"
    
    let dataArrays: NSMutableArray = []
    var detailsToSend: NSDictionary = [:]
    
    var paging = 1
    var loading: Bool = true
    var canReloadMore: Bool = false
    var haveData: Bool = true

    var reloadCell: MyHealthIntegratedTVCell? = nil
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem()
        
        ZUISetup.setupTableViewWithTabView(tableView: self)
        
        if(DBWebServices.checkConnectionToDashboard(viewController: self) == true) {
            
            DBWebServices.getMyHealthBWFeed(page: 1, registeredNotification: registeredNotification)
            
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        let refreshButton: UIBarButtonItem = UIBarButtonItem.init(barButtonSystemItem: UIBarButtonSystemItem.refresh, target: self, action: #selector(setRefresh(sender:)))
        self.tabBarController?.navigationItem.rightBarButtonItem = refreshButton
        
        NotificationCenter.default.addObserver(self, selector: #selector(populateData(data:)), name: Notification.Name(registeredNotification), object: nil)
    }

    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        
        NotificationCenter.default.removeObserver(self, name: Notification.Name(registeredNotification), object: nil);
        
    }
    
    func resetData() {
        
        self.loading = true
        self.canReloadMore = false
        self.paging = 1
        self.detailsToSend = [:]
        self.dataArrays.removeAllObjects()
        self.tableView.reloadData()
    }
    
    func setRefresh(sender: UIBarButtonItem) {
        
        if(DBWebServices.checkConnectionToDashboard(viewController: self) == true) {
            
            self.resetData()
            self.tableView.separatorStyle = UITableViewCellSeparatorStyle.none
            DBWebServices.getMyHealthBWFeed(page: 1, registeredNotification: registeredNotification)
        }
    }
    
    func reloadPresets(inLoadingState: Bool)
    {
        if(inLoadingState == false) {
            self.tabBarController?.navigationItem.rightBarButtonItem?.isEnabled = true
        }
        else{
            self.tabBarController?.navigationItem.rightBarButtonItem?.isEnabled = false
        }
        
    }
    
    func populateData(data: NSDictionary) {
        
        self.reloadPresets(inLoadingState: true)
        
        let extractNotificationWrapper: NSDictionary = data.value(forKey: "object") as! NSDictionary
        
        if(extractNotificationWrapper.value(forKey: "status") as! String == "User Record Not Available") {
            
            self.haveData = false
            self.loading = false
            self.reloadPresets(inLoadingState: false)
            
            DispatchQueue.main.async {
                
                self.tableView.reloadData()
                
            }
            
        }
        else {
            
            self.haveData = true
            
            let unwrapBPData: NSDictionary = extractNotificationWrapper.value(forKey: "W_data") as! NSDictionary
            let pagingMaxFromAPI: Int = unwrapBPData.value(forKey: "last_page") as! Int
            
            let getData: NSArray = unwrapBPData.value(forKey: "data") as! NSArray
            
            
            for data in getData {
                
                if let data = data as? NSDictionary {
                    
                    let bmiInDouble: Double = Double(data.value(forKey: "WeightValue") as! String)!
                    
                    dataArrays.add(["MYHEALTH_BW_BMI":"\(data.value(forKey: "BMI")) mata",
                        "MYHEALTH_BW_BMI_RAW":"\(data.value(forKey: "BMI"))",
                        "MYHEALTH_BW_WEIGHT":"\(Int(bmiInDouble)) kg",
                        "MYHEALTH_BW_WEIGHT_RAW":data.value(forKey: "WeightValue"),
                        "MYHEALTH_BW_BONEMASS":"\(data.value(forKey: "BoneValue"))",
                        "MYHEALTH_BW_FATWEIGHT":data.value(forKey: "FatValue"),
                        "MYHEALTH_BW_LEANWEIGHT":data.value(forKey: "LeanWeight"),
                        "MYHEALTH_BW_MUSCLEMASS":data.value(forKey: "MuscaleValue"),
                        "MYHEALTH_BW_WATERWEIGHT":data.value(forKey: "WaterValue"),
                        "MYHEALTH_BW_CHECKEDDATE":data.value(forKey: "MdateTime")
                        ])
                }
            }
            
//            for i in 0...getData.count - 1 {
//                
//                let extractedData: NSDictionary = getData[i] as! NSDictionary
//                
//                let bmiInDouble: Double = Double(String(describing:extractedData.value(forKey: "WeightValue")!))!
//                
//                dataArrays.add(["MYHEALTH_BW_BMI":"\(String(describing:extractedData.value(forKey: "BMI")!)) mata",
//                    "MYHEALTH_BW_BMI_RAW":"\(String(describing:extractedData.value(forKey: "BMI")!))",
//                    "MYHEALTH_BW_WEIGHT":"\(Int(bmiInDouble)) kg",
//                    "MYHEALTH_BW_WEIGHT_RAW":String(describing:extractedData.value(forKey: "WeightValue")!),
//                    "MYHEALTH_BW_BONEMASS":"\(String(describing:extractedData.value(forKey: "BoneValue")!))",
//                    "MYHEALTH_BW_FATWEIGHT":String(describing:extractedData.value(forKey: "FatValue")!),
//                    "MYHEALTH_BW_LEANWEIGHT":String(describing:extractedData.value(forKey: "LeanWeight")!),
//                    "MYHEALTH_BW_MUSCLEMASS":String(describing:extractedData.value(forKey: "MuscaleValue")!),
//                    "MYHEALTH_BW_WATERWEIGHT":String(describing:extractedData.value(forKey: "WaterValue")!),
//                    "MYHEALTH_BW_CHECKEDDATE":String(describing:extractedData.value(forKey: "MdateTime")!)
//                    ])
//                
//            }
            
            print("[MyHealthBodyWeightTVC] \(paging) to \(pagingMaxFromAPI)")
            
            if(paging == pagingMaxFromAPI) { self.canReloadMore = false } else { self.canReloadMore = true }
            
            DispatchQueue.main.async {
                
                self.loading = false
                self.reloadCell?.updateReloadCell(isLoading: false, forCellID: "MyHealthBWLoadMoreCellID")
                self.reloadPresets(inLoadingState: false)
                self.tableView.separatorStyle = UITableViewCellSeparatorStyle.singleLine
                self.tableView.reloadData()
            }
            
        }
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        
        if(self.haveData == false) {
            
            return 1
            
        }
        else {
            var dataCount: Int = dataArrays.count
        
            if(self.canReloadMore == true) { dataCount += 1 }
        
            if(self.loading == true) { dataCount = 1 }
        
            return dataCount
        }
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let dataCount: Int = dataArrays.count
    
        if(self.loading == true)
        {
            self.tabBarController?.navigationItem.rightBarButtonItem?.isEnabled = false
            
            let cell: MyHealthIntegratedTVCell = tableView.dequeueReusableCell(withIdentifier: "MyHealthBWLoadingCellID") as! MyHealthIntegratedTVCell
            
            // Configure the cell...
            cell.selectionStyle = UITableViewCellSelectionStyle.none
            tableView.allowsSelection = false
            
            return cell
        }
        else if(self.haveData == false) {
            //MyHealthBWErrorCellID
            
            let cell: MyHealthIntegratedTVCell = tableView.dequeueReusableCell(withIdentifier: "MyHealthBWErrorCellID") as! MyHealthIntegratedTVCell
            
            return cell
        }
        else
        {
            if(self.canReloadMore == true && indexPath.row == dataCount)
            {
                print("[MyKomunitiMainTVC] Calling loadmore cell")
                //MKPublicLoadMoreCellID
                reloadCell = tableView.dequeueReusableCell(withIdentifier: "MyHealthBWLoadMoreCellID") as? MyHealthIntegratedTVCell
                reloadCell?.backgroundColor = DBColorSet.myHealthColor
                reloadCell?.uilMHITVCLoadMore.textColor = UIColor.white
                
                return reloadCell!
            }
            else {
                let cell: MyHealthIntegratedTVCell = tableView.dequeueReusableCell(withIdentifier: "MyHealthBWInfoCellID") as! MyHealthIntegratedTVCell
    
                // Configure the cell...
                cell.updateBodyWeightInfo(data: dataArrays.object(at: indexPath.row) as! NSDictionary)
                cell.selectionStyle = UITableViewCellSelectionStyle.default
                tableView.allowsSelection = true
                
                return cell
            }
        }

    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        tableView.deselectRow(at: indexPath, animated: true)
        
        if(self.canReloadMore == true && indexPath.row == dataArrays.count && DBWebServices.checkConnectionToDashboard(viewController: self) == true) {
            
            self.reloadCell?.updateReloadCell(isLoading: true, forCellID: "MyHealthBWLoadMoreCellID")
            self.paging += 1
            
            DBWebServices.getMyHealthBPFeed(page: paging, registeredNotification: registeredNotification)
            
        }
        else if(DBWebServices.checkConnectionToDashboard(viewController: self) == true) {
            
            detailsToSend = dataArrays.object(at: indexPath.row) as! NSDictionary
            self.performSegue(withIdentifier: "DB_GOTO_MYHEALTH_BW_DETAILS", sender: self)
            
        }
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        
        if(self.canReloadMore == true && indexPath.row == dataArrays.count)
        {
            return 70.0
        }
        else
        {
            return 130.0
        }
        
    }

    /*
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

    /*
    // Override to support rearranging the table view.
    override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
        
        let descController: MyHealthBWDetailsTVC = segue.destination as! MyHealthBWDetailsTVC
        
        descController.detailsData = detailsToSend
    }
    

}
