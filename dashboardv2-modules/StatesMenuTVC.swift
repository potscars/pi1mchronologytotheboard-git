//
//  StatesMenuTVC.swift
//  dashboardKB
//
//  Created by Hainizam on 13/06/2017.
//  Copyright © 2017 Ingeniworks Sdn Bhd. All rights reserved.
//

import UIKit

protocol StatesMenuDelegates: class {
    
    func getStateName(_ state: (String, Int)?);
}

class StatesMenuTVC: UITableViewController {

    var delegates: StatesMenuDelegates!
    var statesList: [State]?
    
    var indicator = UIActivityIndicatorView(activityIndicatorStyle: UIActivityIndicatorViewStyle.gray)
    
    override func viewDidLoad() {
        super.viewDidLoad()

        statesList = [State]()
        
        indicator.center = CGPoint(x: (view.bounds.width/2) - (indicator.frame.width/2) , y: (view.bounds.height/2) - 64 - (indicator.frame.height / 2))
        view.addSubview(indicator)
        
        tableView.allowsMultipleSelection = false
        tableView.dataSource = self
        tableView.delegate = self
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "statesCell")
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        self.indicator.startAnimating()
        self.fetchState()
    }
    
    private func fetchState() {
        
        let state = State.init(self)
        state.fetchState({ (result) in
            DispatchQueue.main.async {
                
                self.indicator.stopAnimating()
                self.statesList = result
                self.tableView.reloadData()
            }
        })
    }
}

//MARK: - TableView datasource

extension StatesMenuTVC {
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return statesList!.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell
    {
        let cell = tableView.dequeueReusableCell(withIdentifier: "statesCell", for: indexPath)
        
        cell.textLabel?.text = statesList?[indexPath.item].name
        cell.selectionStyle = .none
        
        return cell
    }
}

//MARK: - Tableview delegates

extension StatesMenuTVC {
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        if let cell = tableView.cellForRow(at: indexPath) {
            
            if cell.accessoryType == .none {
            
                cell.accessoryType = .checkmark
                self.delegates.getStateName(((statesList?[indexPath.row].name)!, (statesList?[indexPath.row].id)!))
            }  else {
                
                cell.accessoryType = .none
                self.delegates.getStateName(("", 0))
            }
        }
    }
    
    override func tableView(_ tableView: UITableView, didDeselectRowAt indexPath: IndexPath) {
        
        if let cell = tableView.cellForRow(at: indexPath) {
            
            cell.accessoryType = .none
            self.delegates.getStateName(("", 0))
        }
    }
}











