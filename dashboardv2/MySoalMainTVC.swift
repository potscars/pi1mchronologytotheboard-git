//
//  MySoalMainTVC.swift
//  dashboardv2
//
//  Created by Mohd Zulhilmi Mohd Zain on 18/01/2017.
//  Copyright © 2017 Ingeniworks Sdn Bhd. All rights reserved.
//

import UIKit

class MySoalMainTVC: UITableViewController {
    
    let registeredNotification: String = "MySoalDataNotification"
    let tokenForMySoal: String? = UserDefaults.standard.object(forKey: "SuccessLoggerMySoalToken") as? String ?? "NoToken"
    
    let dataArrays: NSMutableArray = []
    var detailsToSend: NSDictionary = [:]
    var dataLimiter: Int = 10
    var paging: Int = 1
    var canReloadMore: Bool = false
    var requiresMoreData: Bool = false
    var loading: Bool = true
    var haveData: Bool = true
    var refreshButton: UIBarButtonItem = UIBarButtonItem.init()

    
    var cell: MySoalIntegratedTVCell? = nil
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem()
        
        ZGraphics.applyNavigationBarColor(controller: self, setBarTintColor: DBColorSet.mySoalColor, setBackButtonFontColor: UIColor.init(red: 255.0/255.0, green: 255.0/255.0, blue: 255.0/255.0, alpha: 1.0), setBarFontColor: UIColor.init(red: 255.0/255.0, green: 255.0/255.0, blue: 255.0/255.0, alpha: 1.0), setBarFontFace: UIFont.init(name: "Arial-BoldMT", size: CGFloat(17.0))!)
        
        ZUISetup.setupTableView(tableView: self)
        
        if(DBWebServices.checkConnectionToDashboard(viewController: self) == true) {
        
            print("MySoal token : \(tokenForMySoal!)")
            
            DBWebServices.getMySoalFeed(tokenForMySoal: tokenForMySoal!, page: 1, registeredNotification: registeredNotification)
            
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        self.refreshButton = UIBarButtonItem.init(barButtonSystemItem: UIBarButtonSystemItem.refresh, target: self, action: #selector(setRefresh(sender:)))
        self.navigationItem.rightBarButtonItem = self.refreshButton
        self.reloadPresets(inLoadingState: true)
        
        NotificationCenter.default.addObserver(self, selector: #selector(populateData(data:)), name: Notification.Name(registeredNotification), object: nil)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        
        NotificationCenter.default.removeObserver(self, name: Notification.Name(registeredNotification), object: nil);
    }
    
    func resetData()
    {
        self.reloadPresets(inLoadingState: true)
        self.haveData = true
        self.loading = true
        self.dataLimiter = 10
        self.requiresMoreData = false
        self.canReloadMore = false
        self.paging = 1
        self.detailsToSend = [:]
        self.dataArrays.removeAllObjects()
        self.tableView.reloadData()
    }
    
    func setRefresh(sender: UIBarButtonItem)
    {
        if(DBWebServices.checkConnectionToDashboard(viewController: self) == true) {
            
            self.resetData()
            self.tableView.separatorStyle = UITableViewCellSeparatorStyle.none
            DBWebServices.getMySoalFeed(tokenForMySoal: tokenForMySoal!, page: 1, registeredNotification: registeredNotification)
        }
    }
    
    func reloadPresets(inLoadingState: Bool)
    {
        if(inLoadingState == false) {
            self.navigationItem.rightBarButtonItem?.isEnabled = true
        }
        else{
            self.navigationItem.rightBarButtonItem?.isEnabled = false
        }
        
    }
    
    func populateData(data: NSDictionary)
    {
        let extractNotificationWrapper: NSDictionary = data.value(forKey: "object") as! NSDictionary
        
        print("Final data check: \(extractNotificationWrapper)")
        
        let response: Bool? = extractNotificationWrapper.value(forKey: "GET_RESPONDED") as? Bool ?? true
        
        print("Check response: \(String(describing: response))")
        
        if(response! == false) {
            
            self.haveData = false
            self.loading = false
            
            DispatchQueue.main.async {
                
                self.tableView.reloadData()
                self.reloadPresets(inLoadingState: false)
                self.refreshButton.isEnabled = true
                
            }
            
        } else {
            
            let extractPaging: NSArray = extractNotificationWrapper.value(forKey: "paging") as! NSArray
            
            let pagingMaxFromAPIArray: NSArray = extractPaging.value(forKey: "pageCount") as! NSArray
            
            let pagingMaxFromAPI: Int = Int.init(String.init(describing: pagingMaxFromAPIArray.componentsJoined(by: "")))!
            
            let getData: NSArray? = extractNotificationWrapper.value(forKey: "mail") as? NSArray
            
            if(getData != nil) {
            
                for i in 0...getData!.count - 1 {
                
                    let extractedData: NSDictionary = getData![i] as! NSDictionary
                
                    let dateStacked: String = "\(extractedData.value(forKey: "ori_date") as! String) \(extractedData.value(forKey: "ori_time") as! String)"
                    let convertedDate: String = "\(ZDateTime.dateFormatConverter(valueInString: dateStacked, dateTimeFormatFrom: "dd/MM/yyyy h:mm a", dateTimeFormatTo: ZDateTime.DateInShort))"
                    print("[MyKomunitiMainTVC] date: \(convertedDate)")
                
                
                    dataArrays.add(["MESSAGE_SENDER":extractedData.value(forKey: "sender") as! String,
                                    "MESSAGE_DATE":extractedData.value(forKey: "ori_date") as! String,
                                    "MESSAGE_TIME":extractedData.value(forKey: "ori_time") as! String,
                                    "MESSAGE_DATE_LONG": ZDateTime.dateFormatConverter(valueInString: dateStacked, dateTimeFormatFrom: "dd/MM/yyyy h:mm a", dateTimeFormatTo: ZDateTime.DateInLong),
                                    "MESSAGE_DATE_SHORT": ZDateTime.dateFormatConverter(valueInString: dateStacked, dateTimeFormatFrom: "dd/MM/yyyy h:mm a", dateTimeFormatTo: ZDateTime.DateInShort),
                                    "MESSAGE_TITLE":extractedData.value(forKey: "title") as! String,
                                    "MESSAGE_SUMMARY":extractedData.value(forKey: "summary") as! String,
                                    "MESSAGE_DESC":extractedData.value(forKey: "content") as! String
                        ])
                }
            
                print("[MySoalMainTVC] \(dataArrays.count) per \(dataLimiter), paging \(paging) to \(pagingMaxFromAPI)")
            
                //if(paging == pagingMaxFromAPI) { self.canReloadMore = false } else { self.canReloadMore = true }
            
                if(dataArrays.count >= dataLimiter) { self.canReloadMore = false } else { self.canReloadMore = true }
            
                if(dataArrays.count <= dataLimiter)
                {
                    print("[MySoalMainTVC] More data required, increment to page \(paging)")
                    self.requiresMoreData = true
                    paging += 1
                
                    DBWebServices.getMySoalFeed(tokenForMySoal:tokenForMySoal!, page:paging, registeredNotification: registeredNotification)
                }
                else
                {
                    print("[MySoalMainTVC] Data maxed")
                
                    DispatchQueue.main.async {
                    
                        self.loading = false
                        //self.cell?.setLoadMoreState(isLoadingMore: false)
                        self.reloadPresets(inLoadingState: false)
                        self.tableView.separatorStyle = UITableViewCellSeparatorStyle.singleLine
                        self.tableView.reloadData()
                    }
                
                
                }
        
            }
            else {
                
                
                self.haveData = false
                self.loading = false
                
                
                DispatchQueue.main.async {
                    
                    self.tableView.reloadData()
                    self.reloadPresets(inLoadingState: false)
                    
                }
                
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
        
            print("[MySoalMainTVC] Data count is \(dataCount)")
        
            return dataCount
        }
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let dataCount: Int = dataArrays.count
        
        if(self.loading == true) {
            
            let cell: MySoalIntegratedTVCell = tableView.dequeueReusableCell(withIdentifier: "MySoalLoadingCellID") as! MySoalIntegratedTVCell
            
            // Configure the cell...
            
            cell.setLoadingState(isLoading: true)
            
            return cell
            
        }
        else if(self.haveData == false) {
            
            let cell: MySoalIntegratedTVCell = tableView.dequeueReusableCell(withIdentifier: "MySoalErrorCellID") as! MySoalIntegratedTVCell
            
            // Configure the cell...
            
            return cell
            
        }
        else {
            
            if(self.canReloadMore == true && indexPath.row == dataCount) {
                
                cell = tableView.dequeueReusableCell(withIdentifier: "MySoalLoadMoreCellID") as? MySoalIntegratedTVCell
                
                cell?.setLoadMoreState(isLoadingMore: false)
                
                // Configure the cell...
                
                return cell!
                
            }
            else {
                
                let cell: MySoalIntegratedTVCell = tableView.dequeueReusableCell(withIdentifier: "MySoalMainCellID") as! MySoalIntegratedTVCell
                
                cell.updateFeedData(data: dataArrays.object(at: indexPath.row) as! NSDictionary)
                
                // Configure the cell...
                
                return cell
            }
            
        }
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        tableView.deselectRow(at: indexPath, animated: true)
        
        if(self.canReloadMore == true && indexPath.row == dataArrays.count && DBWebServices.checkConnectionToDashboard(viewController: self) == true) {
            
            self.tabBarController?.navigationItem.rightBarButtonItem?.isEnabled = false
            cell?.setLoadMoreState(isLoadingMore: true)
            
            self.dataLimiter += 10
            DBWebServices.getMySoalFeed(tokenForMySoal:tokenForMySoal!, page:paging, registeredNotification: registeredNotification)
            
        }
        else if(DBWebServices.checkConnectionToDashboard(viewController: self) == true && self.haveData == true) {
            
            detailsToSend = dataArrays.object(at: indexPath.row) as! NSDictionary
            self.performSegue(withIdentifier: "DB_GOTO_MYSOAL_DETAILS", sender: self)
            
        }
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        
        if(self.canReloadMore == true && indexPath.row == dataArrays.count)
        {
            return 70.0
        }
        else
        {
            return 100.0
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
        
        let descController: MySoalDetailsTVC = segue.destination as! MySoalDetailsTVC
        
        descController.detailsData = detailsToSend
        
    }
    

}
