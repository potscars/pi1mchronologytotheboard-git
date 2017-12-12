//
//  MyKospenProfileUpdateTVC.swift
//  dashboardv2
//
//  Created by Hainizam on 24/11/2017.
//  Copyright © 2017 Ingeniworks Sdn Bhd. All rights reserved.
//

import UIKit

class MyKospenProfileUpdateTVC: UITableViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupTableView()
    }
    
    func setupTableView() {
        
        tableView.rowHeight = UITableViewAutomaticDimension
        tableView.estimatedRowHeight = 220.0
        
        let questionaireNib = UINib(nibName: "KospenQuestionaireCell", bundle: nil)
        tableView.register(questionaireNib, forCellReuseIdentifier: KospenIdentifier.KospenQuestionaireCell)
        let measureNib = UINib(nibName: "KospenUserMeasureCell", bundle: nil)
        tableView.register(measureNib, forCellReuseIdentifier: KospenIdentifier.KospenUserMeasureCell)
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return 4
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let index = indexPath.row

        if index == 0 || index == 1 {
            
            let cell = tableView.dequeueReusableCell(withIdentifier: KospenIdentifier.KospenQuestionaireCell, for: indexPath) as! KospenQuestionaireCell
            
            cell.selectionStyle = .none
            
            return cell
        } else {
            
            let cell = tableView.dequeueReusableCell(withIdentifier: KospenIdentifier.KospenUserMeasureCell, for: indexPath) as! KospenUserMeasureCell
            
            cell.selectionStyle = .none
            
            return cell
        }

    }    
}


















