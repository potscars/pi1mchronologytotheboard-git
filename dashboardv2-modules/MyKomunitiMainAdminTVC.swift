//
//  MyKomunitiMainAdminTVC.swift
//  dashboardv2
//
//  Created by Mohd Zulhilmi Mohd Zain on 05/01/2017.
//  Copyright © 2017 Ingeniworks Sdn Bhd. All rights reserved.
//

import UIKit

class MyKomunitiMainAdminTVC: UITableViewController {
    
    let dataArrays: NSMutableArray = []
    var detailsToSend: NSDictionary = [:]
    
    var dataLimiter: Int = 10
    var perPage = 10
    
    var isFirstLoad: Bool = true
    var isRefreshing = false
    
    var requiresMoreData: Bool = false
    var canReloadMore: Bool = false
    var haveData: Bool = true
    
    let notificationNameString: String = "MyKomunitiAdminData"
    
    var reloadCell: MyKomunitiLoadMoreDataTVCell? = nil
    
    var indicator: UIActivityIndicatorView!

    override func viewDidLoad() {
        super.viewDidLoad()
        
        // ****** WARNING: IMPLEMENTATION OF LOADMORE, AND INTERNET CONNECTION IS PENDING ****** //

        refreshControl = UIRefreshControl()
        refreshControl?.addTarget(self, action: #selector(refreshed(_:)), for: .valueChanged)
        tableView.separatorStyle = .none
        
        if #available(iOS 10.0, *) {
            
            tableView.refreshControl = refreshControl
        } else {
            
            tableView.addSubview(refreshControl!)
        }
        
        indicator = UIActivityIndicatorView(activityIndicatorStyle: .gray)
        indicator.frame = CGRect(x: 0, y: 0, width: self.view.bounds.width, height: 44)
        
        ZUISetup.setupTableViewWithTabView(tableView: self)
        
        if(DBWebServices.checkConnectionToDashboard(viewController: self) == true) {
            DBWebServices.getMyKomunitiAdminFeed(page: perPage, registeredNotification: notificationNameString)
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        
        NotificationCenter.default.addObserver(self, selector: #selector(populateData(data:)), name: Notification.Name(notificationNameString), object: nil)

    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        
        NotificationCenter.default.removeObserver(self, name: Notification.Name(notificationNameString), object: nil);
        
    }
        
    @objc func refreshed(_ sender: UIRefreshControl) {
        
        if(DBWebServices.checkConnectionToDashboard(viewController: self) == true) {
            
            self.isRefreshing = true
            self.resetData()

            DBWebServices.getMyKomunitiAdminFeed(page: perPage, registeredNotification: notificationNameString)
        } else {
            
            refreshControl?.endRefreshing()
        }
    }
    
    func resetData()
    {
        self.dataLimiter = 10
        self.requiresMoreData = false
        self.canReloadMore = false
        self.perPage = 10
        self.detailsToSend = [:]
    }

    @objc func populateData(data: NSDictionary) {
        
        if isFirstLoad || isRefreshing {
            
            dataArrays.removeAllObjects()
        }
        
        let extractNotificationWrapper: NSDictionary = data.value(forKey: "object") as! NSDictionary
        
        print(extractNotificationWrapper)
        
        if(extractNotificationWrapper.value(forKey: "total") as! Int == 0){
            
            self.haveData = false
            self.isFirstLoad = false
            
            DispatchQueue.main.async {
                
                self.tableView.reloadData()
            }
            
        }
        else {
            
            self.haveData = true
            
            let totalMaxFromAPI: Int = extractNotificationWrapper.value(forKey: "total") as! Int
            let getData: NSArray = extractNotificationWrapper.value(forKey: "data") as! NSArray
            
            for i in 0...getData.count - 1 {
                
                let extractedData: NSDictionary = getData[i] as! NSDictionary
                let getUserData: NSDictionary = extractedData.value(forKey: "user") as! NSDictionary
                
                //print("[MyKomunitiMainTVC] Title: \(extractedData.value(forKey: "title"))")
                
                dataArrays.add(["MESSAGE_LEVEL":"PENTADBIR",
                                "MESSAGE_SENDER":"\(getUserData.value(forKey:"first_name") as! String) \(getUserData.value(forKey:"last_name") as! String)",
                    "MESSAGE_DATE":extractedData.value(forKey: "updated_at") as! String,
                    "MESSAGE_TITLE":extractedData.value(forKey: "title") as! String,
                    "MESSAGE_SUMMARY":extractedData.value(forKey: "content") as! String,
                    "MESSAGE_DESC":extractedData.value(forKey: "content") as! String
                    ])
            }
            
            print("[MyKomunitiMainTVC] \(dataArrays.count) per \(dataLimiter), maximum to \(totalMaxFromAPI)")
            
            if(totalMaxFromAPI <= dataLimiter) { self.canReloadMore = false } else { self.canReloadMore = true }
            
            if isRefreshing {
                
                refreshControl?.endRefreshing()
                isRefreshing = false
            }
            
            DispatchQueue.main.async {
                
                if self.indicator.isAnimating {
                    self.indicator.stopAnimating()
                    self.tableView.tableFooterView = nil
                }
                
                self.reloadCell?.setFinishState()
                self.tableView.reloadData()
                
            }
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        tableView.deselectRow(at: indexPath, animated: true)
        
        /*if(self.canReloadMore == true && indexPath.row == dataArrays.count && DBWebServices.checkConnectionToDashboard(viewController: self) == true) {
            
            self.tabBarController?.navigationItem.rightBarButtonItem?.isEnabled = false
            reloadCell?.setProcessingState()
            
            
            self.perPage += 1
            self.dataLimiter += 10
            DBWebServices.getMyKomunitiAdminFeed(page: perPage, registeredNotification: notificationNameString)
        }
        else */
        if(DBWebServices.checkConnectionToDashboard(viewController: self) == true && self.haveData == true) {
        
            detailsToSend = dataArrays.object(at: indexPath.row) as! NSDictionary
        
            self.performSegue(withIdentifier: "DB_GOTO_MYKOMUNITI_DETAILS", sender: self)
        }
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        
        if(self.canReloadMore == true && indexPath.row == dataArrays.count)
        {
            return 70.0
        }
        else
        {
            return 101.0
        }
    }
    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
        
        let descController: MyKomunitiDetailsTVC = segue.destination as! MyKomunitiDetailsTVC
        
        descController.detailsData = detailsToSend
    }
}

//MARK: - Datasource
extension MyKomunitiMainAdminTVC {
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        
        var dataCount: Int = dataArrays.count
        
        if(self.isFirstLoad == true) { dataCount = 1  }
        
        return dataCount == 0 ? 1 : dataCount
    }
    
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        if(self.isFirstLoad == true)
        {
            let cell: MyKomunitiLoadingTVCell = tableView.dequeueReusableCell(withIdentifier: "MKAdminLoadingCellID") as! MyKomunitiLoadingTVCell
            
            // Configure the cell...
            
            cell.selectionStyle = UITableViewCellSelectionStyle.none
            tableView.allowsSelection = false
            
            isFirstLoad = false
            
            return cell
        }
        else if(self.haveData == false) {
            
            let cell: MyKomunitiMainTVCell = tableView.dequeueReusableCell(withIdentifier: "MKAdminErrorCellID") as! MyKomunitiMainTVCell
            
            // Configure the cell...
            
            return cell
            
        }
        else
        {
            /*if(self.canReloadMore == true && indexPath.row == dataCount)
             {
             print("[MyKomunitiMainTVC] Calling loadmore cell")
             //MKPublicLoadMoreCellID
             reloadCell = tableView.dequeueReusableCell(withIdentifier: "MKAdminLoadMoreCellID") as? MyKomunitiLoadMoreDataTVCell
             
             return reloadCell!
             }
             else
             {*/
            let cell: MyKomunitiMainTVCell = tableView.dequeueReusableCell(withIdentifier: "MyKomunitiMainCellID") as! MyKomunitiMainTVCell
            
            // Configure the cell...
            
            cell.selectionStyle = UITableViewCellSelectionStyle.default
            tableView.allowsSelection = true
            cell.updateCell(data: dataArrays.object(at: indexPath.row) as! NSDictionary)
            
            return cell
            //}
        }
        
    }
}

//MARK: - Delegates
extension MyKomunitiMainAdminTVC {
    
    override func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        
        let index = indexPath.row
        
        if canReloadMore && index == dataLimiter - 1 {
            
            if DBWebServices.checkConnectionToDashboard(viewController: self) {
                
                tableView.tableFooterView = indicator
                indicator.startAnimating()
                
                self.perPage += 1
                self.dataLimiter += 10
                
                DBWebServices.getMyKomunitiAdminFeed(page: perPage, registeredNotification: notificationNameString)
            }
        }
    }
}



























