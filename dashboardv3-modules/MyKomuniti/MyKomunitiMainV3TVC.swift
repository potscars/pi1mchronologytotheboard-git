//
//  MyKomunitiV3TVC.swift
//  dashboardv2
//
//  Created by Mohd Zulhilmi Mohd Zain on 21/11/2017.
//  Copyright © 2017 Ingeniworks Sdn Bhd. All rights reserved.
//

import UIKit

class MyKomunitiMainV3TVC: UITableViewController {
    
    var refControl: UIRefreshControl!
    var pageCount: Int = 0
    var dataCount: Int = 0
    var totalPageCount: Int = 0
    var totalDataCount: Int = 0
    var myKomunitiData: MyKomunitiKeys? = nil
    var tableDataArrays: MyKomunitiAnnouncementListing? = nil

    override func viewDidLoad() {
        super.viewDidLoad()

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem
        
        self.tableView.rowHeight = UITableViewAutomaticDimension
        self.tableView.estimatedRowHeight = 90.0
        
        self.refControl = UIRefreshControl.init()
        self.refControl.addTarget(self, action: #selector(refreshPopulatedData), for: .valueChanged)
        
        if #available(iOS 10.0, *) {
            self.tableView.refreshControl = self.refControl
        } else {
            self.tableView.addSubview(self.refControl)
        }
        
        self.refreshPopulatedData(sender: nil)
    }
    
    @objc func refreshPopulatedData(sender: UIRefreshControl?) {
        
        if sender != nil {
            self.pageCount = 1
            
            DispatchQueue.main.async {
                
                self.myKomunitiData = MyKomunitiProcess.getAnnoucement(page: self.pageCount)
                self.totalPageCount = self.myKomunitiData!.pagination.lastPage
                self.totalDataCount = self.myKomunitiData!.pagination.total
                self.dataCount = self.myKomunitiData!.pagination.to
                
                print("totalp: \(self.myKomunitiData!.pagination.total), current: \(self.myKomunitiData!.pagination.currentPage), pageinternal: \(self.pageCount), datacount \(self.dataCount), pagecount: \(self.pageCount)")
                
                //self.tableDataArrays?.addData(data: self.myKomunitiData?.dataRaw)
                
                self.tableView.reloadData()
                self.refControl.endRefreshing()
            }
            
        } else {
            
            self.pageCount += 1
            
            DispatchQueue.main.async {
                
                self.myKomunitiData = MyKomunitiProcess.getAnnoucement(page: self.pageCount)
                self.totalPageCount = self.myKomunitiData!.pagination.lastPage
                self.totalDataCount = self.myKomunitiData!.pagination.total
                self.dataCount += self.myKomunitiData!.pagination.to
                
                print("totalp: \(self.myKomunitiData!.pagination.total), current: \(self.myKomunitiData!.pagination.currentPage), pageinternal: \(self.pageCount), datacount \(self.dataCount), pagecount: \(self.pageCount)")
                
                //self.tableDataArrays?.addData(data: self.myKomunitiData?.dataRaw)
                
                self.tableView.reloadData()
                self.refControl.endRefreshing()
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
        return self.myKomunitiData?.data.totalData ?? 0
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell: UITableViewCell = UITableViewCell.init(style: UITableViewCellStyle.subtitle, reuseIdentifier: "MyKomunitiMainV3AllListCellID")
        
        // Settings label
        let leftLabel: UILabel = UILabel.init(frame: CGRect.init(x: 0, y: 0, width: 40, height: 40))
        leftLabel.textAlignment = NSTextAlignment.center
        leftLabel.font = UIFont.init(name: "ArialMT", size: 12.0)
        leftLabel.lineBreakMode = NSLineBreakMode(rawValue: 0)!
        leftLabel.textColor = UIColor.white
        leftLabel.layer.backgroundColor = UIColor.purple.cgColor
        leftLabel.layer.cornerRadius = 20
        leftLabel.attributedText = NSAttributedString.init(string: "JK", attributes: nil)
        cell.imageView?.image = UIImage.imageWithLabel(label: leftLabel)
        
        let titleLabelAttribText: [NSAttributedStringKey: Any] = [NSAttributedStringKey.font : UIFont.init(name: "ArialMT", size: 15.0)!]
        cell.textLabel?.attributedText = NSAttributedString.init(string: "Lorem ipsum dolor sit amet", attributes: titleLabelAttribText)
        
        let paraStyle: NSMutableParagraphStyle = NSMutableParagraphStyle.init()
        //paraStyle.lineSpacing = 0.50
        let descLabelAttribText: [NSAttributedStringKey: Any] = [NSAttributedStringKey.font : UIFont.init(name: "ArialMT", size: 12.0)!, NSAttributedStringKey.paragraphStyle : paraStyle ]
        cell.detailTextLabel?.attributedText = NSAttributedString.init(string: "Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum.", attributes: descLabelAttribText)
        cell.detailTextLabel?.lineBreakMode = NSLineBreakMode.byTruncatingTail
        cell.detailTextLabel?.numberOfLines = 3
        cell.detailTextLabel?.textAlignment = NSTextAlignment.justified
        
        // Configure the cell...

        return cell
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 90.0
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
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
