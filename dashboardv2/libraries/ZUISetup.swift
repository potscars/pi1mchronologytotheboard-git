//
//  ZUISetup.swift
//  dashboardv2
//
//  Created by Mohd Zulhilmi Mohd Zain on 10/01/2017.
//  Copyright © 2017 Ingeniworks Sdn Bhd. All rights reserved.
//

import UIKit

class ZUISetup: NSObject {
    
    static func setupTableViewWithTabView(tableView: UITableViewController)
    {
        tableView.tableView.contentInset = UIEdgeInsetsMake(0, 0, tableView.bottomLayoutGuide.length, 0)
        tableView.edgesForExtendedLayout = []
    }
    
    static func setupTableView(tableView: UITableViewController)
    {
        tableView.edgesForExtendedLayout = []
    }

}
