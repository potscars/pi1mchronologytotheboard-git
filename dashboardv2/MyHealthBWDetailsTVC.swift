//
//  MyHealthBWDetailsTVC.swift
//  dashboardv2
//
//  Created by Mohd Zulhilmi Mohd Zain on 27/01/2017.
//  Copyright © 2017 Ingeniworks Sdn Bhd. All rights reserved.
//

import UIKit

class MyHealthBWDetailsTVC: UITableViewController {
    
    var detailsData: NSDictionary = [:]

    override func viewDidLoad() {
        super.viewDidLoad()

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem()
        
        self.tableView.rowHeight = UITableViewAutomaticDimension
        self.tableView.estimatedRowHeight = 85.0
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
        return 9
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        if(indexPath.row == 0) {
            
            let cell: MyHealthBWDetailsTVCell = tableView.dequeueReusableCell(withIdentifier: "MHBWDTVCDetailsTitleCellID") as! MyHealthBWDetailsTVCell

            // Configure the cell...
            
            cell.setBWTitle(data: detailsData)

            return cell
        }
        else if(indexPath.row == 1) {
            
            let cell: MyHealthBWDetailsTVCell = tableView.dequeueReusableCell(withIdentifier: "MHBWDTVCDetailsBWWeightCellID") as! MyHealthBWDetailsTVCell
            
            // Configure the cell...
            
            cell.setBWData(data: detailsData)
            
            return cell
        }
        else if(indexPath.row == 2) {
            
            let cell: MyHealthBWDetailsTVCell = tableView.dequeueReusableCell(withIdentifier: "MHBWDTVCDetailsBWBMICellID") as! MyHealthBWDetailsTVCell
            
            // Configure the cell...
            
            cell.setBMIData(data: detailsData)
            
            return cell
        }
        else if(indexPath.row == 3) {
            
            let cell: MyHealthBWDetailsTVCell = tableView.dequeueReusableCell(withIdentifier: "MHBWDTVCDetailsBWFatCellID") as! MyHealthBWDetailsTVCell
            
            // Configure the cell...
            
            cell.setFatData(data: detailsData)
            
            return cell
        }
        else if(indexPath.row == 4) {
            
            let cell: MyHealthBWDetailsTVCell = tableView.dequeueReusableCell(withIdentifier: "MHBWDTVCDetailsBWBoneCellID") as! MyHealthBWDetailsTVCell
            
            // Configure the cell...
            
            cell.setBoneData(data: detailsData)
            
            return cell
        }
        else if(indexPath.row == 5) {
            
            let cell: MyHealthBWDetailsTVCell = tableView.dequeueReusableCell(withIdentifier: "MHBWDTVCDetailsBWNettWeightCellID") as! MyHealthBWDetailsTVCell
            
            // Configure the cell...
            
            cell.setLeanWeightData(data: detailsData)
            
            return cell
        }
        else if(indexPath.row == 6) {
            
            let cell: MyHealthBWDetailsTVCell = tableView.dequeueReusableCell(withIdentifier: "MHBWDTVCDetailsBWMuscleCellID") as! MyHealthBWDetailsTVCell
            
            // Configure the cell...
            
            cell.setMuscleData(data: detailsData)
            
            return cell
        }
        else if(indexPath.row == 7) {
            
            let cell: MyHealthBWDetailsTVCell = tableView.dequeueReusableCell(withIdentifier: "MHBWDTVCDetailsBWStatusCellID") as! MyHealthBWDetailsTVCell
            
            // Configure the cell...
            
            cell.setBWStatusData(data: detailsData)
            
            return cell
        }
        else {
            
            let cell: MyHealthBWDetailsTVCell = tableView.dequeueReusableCell(withIdentifier: "MHBWDTVCDetailsBWDescCellID") as! MyHealthBWDetailsTVCell
            
            // Configure the cell...
            
            cell.setBWDescData(data: detailsData)
            
            return cell
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
