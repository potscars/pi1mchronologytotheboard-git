//
//  MyShopMainMenuTVC.swift
//  dashboardv2
//
//  CellId: MyShopBannerCellID, MyShopMenuNormalCellID
//
//  Created by Mohd Zulhilmi Mohd Zain on 01/02/2017.
//  Copyright © 2017 Ingeniworks Sdn Bhd. All rights reserved.
//

import UIKit

class MyShopMainMenuTVC: UITableViewController {
    
    let requestProduct: NSArray = ["LATEST_PROD","POPULAR_PROD","HI_RATING_PROD","LOCAL_PROD"]
    var requestProductPathRow: Int = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem()
        
        ZGraphics.applyNavigationBarColor(controller: self, setBarTintColor: DBColorSet.myShopColor, setBackButtonFontColor: UIColor.init(red: 255.0/255.0, green: 255.0/255.0, blue: 255.0/255.0, alpha: 1.0), setBarFontColor: UIColor.init(red: 255.0/255.0, green: 255.0/255.0, blue: 255.0/255.0, alpha: 1.0), setBarFontFace: UIFont.init(name: "Arial-BoldMT", size: CGFloat(17.0))!)
        
        self.tableView.rowHeight = UITableViewAutomaticDimension
        self.tableView.estimatedRowHeight = 100.0
        self.tableView.backgroundColor = DBColorSet.myShopColor
        
    }
    
    func setupMenu() -> NSArray
    {
        let latestProd: NSDictionary = ["MENU_NAME":"Produk Terkini","MENU_BG_COLOR":DBColorSet.myShopMenuOddColor,"MENU_LABEL_COLOR":UIColor.white]
        let popularProd: NSDictionary = ["MENU_NAME":"Produk Popular","MENU_BG_COLOR":DBColorSet.myShopMenuEvenColor,"MENU_LABEL_COLOR":UIColor.white]
        let highRatingProd: NSDictionary = ["MENU_NAME":"Produk Tinggi Penilaian","MENU_BG_COLOR":DBColorSet.myShopMenuOddColor,"MENU_LABEL_COLOR":UIColor.white]
        let localProd: NSDictionary = ["MENU_NAME":"Produk Tempatan","MENU_BG_COLOR":DBColorSet.myShopMenuEvenColor,"MENU_LABEL_COLOR":UIColor.white]
        
        let myShopMenu: NSArray = ["dummy",latestProd,popularProd,highRatingProd,localProd]
        
        return myShopMenu
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
        return setupMenu().count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        if(indexPath.row == 0) {
            let cell: MyShopIntegratedTVCell = tableView.dequeueReusableCell(withIdentifier: "MyShopBannerCellID") as! MyShopIntegratedTVCell
        
            // Configure the cell...
            cell.setUpdateBanner(backgroundColor: DBColorSet.myShopColor)
            cell.selectionStyle = UITableViewCellSelectionStyle.none
        
            return cell
        }
        else {
            let cell: MyShopIntegratedTVCell = tableView.dequeueReusableCell(withIdentifier: "MyShopMenuNormalCellID") as! MyShopIntegratedTVCell

            // Configure the cell...
            let extractedArray: NSDictionary = setupMenu().object(at: indexPath.row) as! NSDictionary
            
            cell.setUpdateMenuLabel(menuString: extractedArray.object(forKey: "MENU_NAME") as! String, backgroundColor: extractedArray.object(forKey: "MENU_BG_COLOR") as! UIColor, labelTextColor: extractedArray.object(forKey: "MENU_LABEL_COLOR") as! UIColor)

            return cell
        }
    }
 
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        tableView.deselectRow(at: indexPath, animated: true)
        
        requestProductPathRow = indexPath.row - 1
        
        //if(indexPath.row == 1)
        //{
            self.performSegue(withIdentifier: "DB_GOTO_MYSHOP_LATEST", sender: self)
        //}
        
    }

    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
        
        let descController: MyShopLatestProdTVC = segue.destination as! MyShopLatestProdTVC
        
        descController.requestProduct = requestProduct.object(at: requestProductPathRow) as! String
        
    }
    

}
