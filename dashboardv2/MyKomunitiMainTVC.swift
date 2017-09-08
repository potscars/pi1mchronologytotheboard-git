//
//  MyKomunitiMainTVC.swift
//  dashboardv2
//
//  Created by Mohd Zulhilmi Mohd Zain on 04/01/2017.
//  Copyright © 2017 Ingeniworks Sdn Bhd. All rights reserved.
//

import UIKit

class MyKomunitiMainTVC: UITableViewController {
    
    let dataArrays: NSMutableArray = []
    var detailsToSend: NSDictionary = [:]
    
    var dataLimiter: Int = 5
    var paging = 1
    
    var requiresMoreData: Bool = false
    var canReloadMore: Bool = false
    var haveData: Bool = true
    
    var isFirstLoad: Bool = true
    var isRefreshing = false
    var isLoadMore = false
    
    var indicator: UIActivityIndicatorView!
    
    let registeredNotification: String = "MyKomunitiPublicData"
    
    var reloadCell: MyKomunitiLoadMoreDataTVCell? = nil
    

    override func viewDidLoad() {
        super.viewDidLoad()

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
            
            DBWebServices.getMyKomunitiPublicFeed(page: paging, registeredNotification: registeredNotification)
        }
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        let composeButton = UIBarButtonItem(barButtonSystemItem: .compose, target: self, action: #selector(composeButtonTapped))
        
        self.tabBarController?.navigationController?.navigationBar.tintColor = .white
        self.tabBarController?.navigationItem.rightBarButtonItem = composeButton
        
        NotificationCenter.default.addObserver(self, selector: #selector(populateData(data:)), name: Notification.Name(registeredNotification), object: nil)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        
        NotificationCenter.default.removeObserver(self, name: Notification.Name(registeredNotification), object: nil);
        
    }
    
    func composeButtonTapped(_ sender: UIBarButtonItem) {
        
        let viewControllerIdentifier = "myKomunitiPostVC"
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        
        if let viewController = storyboard.instantiateViewController(withIdentifier: viewControllerIdentifier) as? MyKomunitiPostVC {
            
            self.navigationController?.pushViewController(viewController, animated: true)
        }
    }
    
    func refreshed(_ sender: UIRefreshControl) {
        
        if(DBWebServices.checkConnectionToDashboard(viewController: self) == true) {
            
            self.isRefreshing = true
            self.resetData()
            
            self.tableView.separatorStyle = UITableViewCellSeparatorStyle.none
            DBWebServices.getMyKomunitiPublicFeed(page: paging, registeredNotification: registeredNotification)
        } else {
            
            refreshControl?.endRefreshing()
        }
    }
    
    func resetData()
    {
        self.isLoadMore = false
        self.dataLimiter = 5
        self.requiresMoreData = false
        self.canReloadMore = false
        self.paging = 1
        self.detailsToSend = [:]
    }
    
    func populateData(data: NSDictionary)
    {
        
        if isRefreshing || isFirstLoad {
            dataArrays.removeAllObjects()
        }
        
        let extractNotificationWrapper: NSDictionary = data.value(forKey: "object") as! NSDictionary
        
        print("NSDICTIONARY FOR DATA : \(extractNotificationWrapper)")
        
        let pagingMaxFromAPI: Int = extractNotificationWrapper.value(forKey: "last_page") as! Int
        let getData: NSArray = extractNotificationWrapper.value(forKey: "data") as! NSArray
        //let perPageFromAPI: Int = extractNotificationWrapper.value(forKey: "per_page") as! Int
        //let totalPageFromAPI: Int = extractNotificationWrapper.value(forKey: "to") as! Int
        
        //if(totalPageFromAPI <= perPageFromAPI) { dataLimiter = totalPageFromAPI }
        
        for i in 0...getData.count - 1 {
            
            let extractedData: NSDictionary = getData[i] as! NSDictionary
            let getUserData: NSDictionary = extractedData.value(forKey: "user") as! NSDictionary
            
            print("Extracted Data NSDictionary\(extractedData)")
            
            print("[MyKomunitiMainTVC] Title: \(String(describing: extractedData.value(forKey: "title")))")
            
            dataArrays.add(["MESSAGE_LEVEL":"AWAM",
                            "MESSAGE_SENDER":getUserData.value(forKey: "full_name") as! String,
                            "MESSAGE_DATE":extractedData.value(forKey: "updated_at") as! String,
                            "MESSAGE_TITLE":extractedData.value(forKey: "title") as! String,
                            "MESSAGE_SUMMARY":extractedData.value(forKey: "excerpt") as! String,
                            "MESSAGE_DESC":extractedData.value(forKey: "content") as! String
                ])
            
            print("UPDATED DATE: \(getUserData.value(forKey: "updated_at"))")
            
        }
        
        
        
        print("[MyKomunitiMainTVC] \(dataArrays.count) per \(dataLimiter), maximum to \(pagingMaxFromAPI)")
        
        if(dataArrays.count == pagingMaxFromAPI) {
            
            self.canReloadMore = false
        } else {
            
            self.canReloadMore = true
        }
        
        if isRefreshing {
            
            refreshControl?.endRefreshing()
            isRefreshing = false
        }
        
        
        DispatchQueue.main.async {
            
            if self.indicator.isAnimating {
                
                self.indicator.stopAnimating()
                self.tableView.tableFooterView = nil
            }

            self.tableView.reloadData()
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Table view data source
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        tableView.deselectRow(at: indexPath, animated: true)
        
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

extension MyKomunitiMainTVC {
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        
        var dataCount: Int = dataArrays.count
        
        //if(self.canReloadMore == true) { dataCount += 1 }
        
        if(self.isFirstLoad == true) { dataCount = 1 }
        
        print("[MyKomunitiMainTVC] Data count is \(dataCount)")
        
        return dataCount == 0 ? 1 : dataCount
        
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        // Configure the cell...
        
        let dataCount: Int = dataArrays.count
        //if(self.canReloadMore == true) { dataCount += 1 }
        
        if(self.isFirstLoad == true)
        {
            print("First Load")
            
            let cell: MyKomunitiLoadingTVCell = tableView.dequeueReusableCell(withIdentifier: "MKPublicLoadingCellID") as! MyKomunitiLoadingTVCell
            
            // Configure the cell...
            
            cell.selectionStyle = UITableViewCellSelectionStyle.none
            tableView.allowsSelection = false
            
            self.isFirstLoad = false
            
            return cell
        }
        else if(self.haveData == false) {
            
            let cell: MyKomunitiMainTVCell = tableView.dequeueReusableCell(withIdentifier: "MKPublicErrorCellID") as! MyKomunitiMainTVCell
            
            return cell
            
        }
        else
        {
            
            print("Data showed!")
            
            /*if(self.canReloadMore == true && indexPath.row == dataCount)
            {
                print("[MyKomunitiMainTVC] Calling loadmore cell")
                //MKPublicLoadMoreCellID
                reloadCell = tableView.dequeueReusableCell(withIdentifier: "MKPublicLoadMoreCellID") as? MyKomunitiLoadMoreDataTVCell
                
                return reloadCell!
            }
            else {
                let cell: MyKomunitiMainTVCell = tableView.dequeueReusableCell(withIdentifier: "MyKomunitiMainCellID") as! MyKomunitiMainTVCell
                
                cell.selectionStyle = UITableViewCellSelectionStyle.default
                tableView.allowsSelection = true
                cell.updateCell(data: dataArrays.object(at: indexPath.row) as! NSDictionary)
                
                return cell
            }*/
            
            let cell: MyKomunitiMainTVCell = tableView.dequeueReusableCell(withIdentifier: "MyKomunitiMainCellID") as! MyKomunitiMainTVCell
            
            cell.selectionStyle = UITableViewCellSelectionStyle.default
            tableView.allowsSelection = true
            cell.updateCell(data: dataArrays.object(at: indexPath.row) as! NSDictionary)
            
            return cell
        }
    }
}


//MARK: - Delegates

extension MyKomunitiMainTVC {
    
    override func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        
        let index = indexPath.row
        
        if canReloadMore && index == dataLimiter - 1 {
            
            if DBWebServices.checkConnectionToDashboard(viewController: self) {
                
                tableView.tableFooterView = indicator
                indicator.startAnimating()
                
                self.isLoadMore = true
                self.paging += 1
                self.dataLimiter += 5
                
                DBWebServices.getMyKomunitiPublicFeed(page: paging, registeredNotification: registeredNotification)
            }
        }
    }
}
































