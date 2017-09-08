//
//  MyShopProductDetailsTVC.swift
//  dashboardv2
//
//  Created by Mohd Zulhilmi Mohd Zain on 06/02/2017.
//  Copyright © 2017 Ingeniworks Sdn Bhd. All rights reserved.
//

import UIKit

class MyShopProductDetailsTVC: UITableViewController {
    
    let registeredNotification: String = "MyShopDetaisProductData"
    
    var detailsData: NSDictionary = [:]
    var moreDetailedData: [String:Any] = [:]
    var reviews: NSArray = []
    
    var loading: Bool = true

    override func viewDidLoad() {
        super.viewDidLoad()

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem()
        
        self.tableView.rowHeight = UITableViewAutomaticDimension
        self.tableView.estimatedRowHeight = 100.0
        
        if(DBWebServices.checkConnectionToDashboard(viewController: self) == true) {
            
            DBWebServices.getMyShopProductDetails(productID: Int(detailsData.value(forKey: "MYSHOP_PROD_ID") as! String)!, registeredNotification: registeredNotification)
            //DBWebServices.getMyShopProductDetails(productID: 42, registeredNotification: registeredNotification)
        }
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        NotificationCenter.default.addObserver(self, selector: #selector(populateData(data:)), name: Notification.Name(registeredNotification), object: nil)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        
        NotificationCenter.default.removeObserver(self, name: Notification.Name(registeredNotification), object: nil);
        
    }
    
    func populateData(data: NSDictionary) {
        
        print("[MyShopProductDetails] Data: \(data)")
        
        let notiWrap: NSDictionary = data.value(forKey: "object") as! NSDictionary
            
        moreDetailedData = ["MYSHOP_PROD_ID":nullCheckerReturnToString(string: String(describing: notiWrap.value(forKey: "id")!)),
                            "MYSHOP_PROD_TITLE":nullCheckerReturnToString(string: String(describing: notiWrap.value(forKey: "title")!)),
                            "MYSHOP_PROD_DESCRIPTION":nullCheckerReturnToString(string: String(describing: notiWrap.value(forKey: "description")!)),
                            "MYSHOP_PROD_RATING_COUNT":nullCheckerReturnToString(string: String(describing: notiWrap.value(forKey: "rating_count")!)),
                            "MYSHOP_PROD_VIEWER_COUNT":nullCheckerReturnToString(string: String(describing: notiWrap.value(forKey: "viewer_count")!)),
                            "MYSHOP_PROD_VIEWER_COUNT_WEEKLY":nullCheckerReturnToString(string: String(describing: notiWrap.value(forKey: "viewer_count_by_week")!)),
                            "MYSHOP_PROD_SEARCH_COUNT_WEEKLY":nullCheckerReturnToString(string: String(describing: notiWrap.value(forKey: "search_count_by_week")!)),
                            "MYSHOP_PROD_WEEK_VIEWER":nullCheckerReturnToString(string: String(describing: notiWrap.value(forKey: "week_viewer")!)),
                            "MYSHOP_PROD_COMMENT_COUNT":nullCheckerReturnToString(string: String(describing: notiWrap.value(forKey: "comment_count")!)),
                            "MYSHOP_PROD_PRICE":nullCheckerReturnToString(string: String(describing: notiWrap.value(forKey: "price")!)),
                            "MYSHOP_PROD_QUANTITY":nullCheckerReturnToString(string: String(describing: notiWrap.value(forKey: "quantity")!)),
                            "MYSHOP_PROD_SKU":nullCheckerReturnToString(string: String(describing: notiWrap.value(forKey: "sku")!)),
                            "MYSHOP_PROD_PER_ITEM_SHIPPING_ID":nullCheckerReturnToString(string: String(describing: notiWrap.value(forKey: "per_item_shipping_id")!)),
                            "MYSHOP_PROD_OPTION":nullCheckerReturnToString(string: String(describing: notiWrap.value(forKey: "option")!)),
                            "MYSHOP_PROD_DATE":nullCheckerReturnToString(string: String(describing: notiWrap.value(forKey: "date")!)),
                            "MYSHOP_PROD_TERM":nullCheckerReturnToString(string: String(describing: notiWrap.value(forKey: "term")!)),
                            "MYSHOP_PROD_UPDATE_DATE":nullCheckerReturnToString(string: String(describing: notiWrap.value(forKey: "updated_at")!)),
                            "MYSHOP_PROD_CREATED_DATE":nullCheckerReturnToString(string: String(describing: notiWrap.value(forKey: "created_at")!)),
                            "MYSHOP_PROD_PHOTO_THUMB":nullCheckerReturnToString(string: String(describing: notiWrap.value(forKey: "url_photo_thumb")!)),
                            "MYSHOP_PROD_PHOTO_LARGE":nullCheckerReturnToString(string: String(describing: notiWrap.value(forKey: "url_photo_large")!)),
                            "MYSHOP_PROD_PHOTO_ARRAYS":notiWrap.value(forKey: "photos") as? NSArray ?? [],
                            "MYSHOP_PROD_SELLER_INFO":notiWrap.value(forKey: "user") as? NSDictionary ?? [:]
        ]

        reviews = notiWrap.value(forKey: "reviews") as? NSArray ?? []
        
        DispatchQueue.main.async {
            
            self.loading = false
            self.tableView.reloadData()
        }
        
    }

    func nullCheckerReturnToString(string: String?) -> String {
        
        var stringCheck = ""
        
        if(string == nil) {
            
            stringCheck = "N/A"
            
        }
        else {
            
            stringCheck = string!
            
        }
        
        return stringCheck
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
        
        if(moreDetailedData.count == 0 && self.loading == false) { return 0 }
        else if(self.loading == true) { return 1 }
        else if(moreDetailedData.count != 0) && (reviews.count != 0) { return 6 + reviews.count }
        else { return 7 }
        
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        //MyShopPDProductPicCellID, MyShopPDProdLocationCellID, MyShopPDProdSellerInfoCellID, MyShopPDProdDescCellID, MyShopPDProdRatingTitleCellID, MyShopPDProdRatingCommentCellID, MyShopPDProdRatingMoreCellID, MyShopPDProdLoadingCellID
        
        if(self.loading == true) {
        
            let cell: MyShopIntegratedTVCell = tableView.dequeueReusableCell(withIdentifier: "MyShopPDProdLoadingCellID") as! MyShopIntegratedTVCell
            
            // Configure the cell...
            //cell.updateProductDetailsProductName(data: moreDetailedData as NSDictionary)
            
            return cell
            
        }
        else {
            if(indexPath.row == 0)
            {
                let cell: MyShopIntegratedTVCell = tableView.dequeueReusableCell(withIdentifier: "MyShopPDProductNameCellID") as! MyShopIntegratedTVCell

                // Configure the cell...
                cell.updateProductDetailsProductName(data: moreDetailedData as NSDictionary)

                return cell
            }
            else if(indexPath.row == 1)
            {
                let cell: MyShopIntegratedTVCell = tableView.dequeueReusableCell(withIdentifier: "MyShopPDProductPicCellID") as! MyShopIntegratedTVCell
            
                // Configure the cell...
                cell.updateProductDetailsProductPicture(data: moreDetailedData["MYSHOP_PROD_PHOTO_ARRAYS"] as! NSArray, withViewController: self)
            
            
                return cell
            }
            else if(indexPath.row == 2)
            {
                let cell: MyShopIntegratedTVCell = tableView.dequeueReusableCell(withIdentifier: "MyShopPDProdLocationCellID") as! MyShopIntegratedTVCell
            
                // Configure the cell...
                cell.updateProductDetailsProductCategory(data: moreDetailedData as NSDictionary)
            
            
                return cell
            }
            else if(indexPath.row == 3)
            {
                let cell: MyShopIntegratedTVCell = tableView.dequeueReusableCell(withIdentifier: "MyShopPDProdSellerInfoCellID") as! MyShopIntegratedTVCell
            
                // Configure the cell...
                cell.updateProductDetailsProductSellerInfo(data: moreDetailedData as NSDictionary)
            
                return cell
            }
            else if(indexPath.row == 4)
            {
                let cell: MyShopIntegratedTVCell = tableView.dequeueReusableCell(withIdentifier: "MyShopPDProdDescCellID") as! MyShopIntegratedTVCell
            
                // Configure the cell...
                cell.updateProductDetailsProductDescription(data: moreDetailedData as NSDictionary)
            
                return cell
            }
            else if(indexPath.row == 5)
            {
                let cell: MyShopIntegratedTVCell = tableView.dequeueReusableCell(withIdentifier: "MyShopPDProdRatingTitleCellID") as! MyShopIntegratedTVCell
            
                // Configure the cell...
                //cell.updateProductDetailsProductDescription(data: moreDetailedData as NSDictionary)
            
                return cell
            }
            else if(indexPath.row >= 6) && (reviews.count != 0)
            {
                let cell: MyShopIntegratedTVCell = tableView.dequeueReusableCell(withIdentifier: "MyShopPDProdRatingCommentCellID") as! MyShopIntegratedTVCell
            
                // Configure the cell...
                cell.updateProductDetailsProductComment(data: reviews.object(at: indexPath.row - 6) as! NSDictionary)
            
                return cell
            }
            else //if(indexPath.row == 3)
            {
                let cell: MyShopIntegratedTVCell = tableView.dequeueReusableCell(withIdentifier: "MyShopPDProdNoRatingCellID") as! MyShopIntegratedTVCell
            
                // Configure the cell...
                //cell.updateProductDetailsProductComment(data: reviews.object(at: indexPath.row - 6) as! NSDictionary)
            
                return cell
            }
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

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
