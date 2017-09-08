//
//  AccomodationMenuTVC.swift
//  dashboardKB
//
//  Created by Hainizam on 14/06/2017.
//  Copyright © 2017 Ingeniworks Sdn Bhd. All rights reserved.
//

import UIKit

protocol CategoryMenuDelegate: class {
    
    func getCategory(_ category: [String: Int]?);
}

class CategoryMenuTVC: UITableViewController {

    var delegates: CategoryMenuDelegate!
    var categoryList: [Catergory]?
    
    var catergorySelected: [String: Int]?
    
    var indicator = UIActivityIndicatorView(activityIndicatorStyle: UIActivityIndicatorViewStyle.gray)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        catergorySelected = nil
        
        indicator.center = CGPoint(x: (view.bounds.width/2) - (indicator.frame.width/2) , y: (view.bounds.height/2) - 64 - (indicator.frame.height / 2))
        view.addSubview(indicator)
        
        tableView.dataSource = self
        tableView.delegate = self
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "categoryCell")
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        self.indicator.startAnimating()
        self.fetchCatergory()
    }
    
    private func fetchCatergory() {
        
        let catergory = Catergory.init(self)
        catergory.fetchCategory { (result) in
            
            DispatchQueue.main.async {
                
                self.indicator.stopAnimating()
                self.categoryList = result
                self.tableView.reloadData()
            }
        }
    }
}

//MARK: - TableView Datasource

extension CategoryMenuTVC {
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        if categoryList != nil {
            
            return (categoryList?.count)!
        } else {
            
            return 0
        }
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "categoryCell", for: indexPath)
        
        cell.textLabel?.text = categoryList?[indexPath.item].name
        cell.selectionStyle = .none
        
        return cell
    }
}

//MARK: - TableView Delegates

extension CategoryMenuTVC {
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        if let cell = tableView.cellForRow(at: indexPath) {
            
            let name = (categoryList?[indexPath.item].name)!
            let id = (categoryList?[indexPath.item].id)!
            
            if cell.accessoryType == .none {
                
                cell.accessoryType = .checkmark
                
                if let item = catergorySelected {
                    
                    for (key, _) in item {
                        
                        if name != key {
                            catergorySelected?[name] = id
                        }
                    }
                } else {
                    
                    catergorySelected = [name : id]
                }
                
                print(catergorySelected ?? "Hey world!")
                
                self.delegates.getCategory(catergorySelected)
            } else {
                
                cell.accessoryType = .none
                
                if let item = catergorySelected {
                    
                    for (key, _) in item {
                        
                        if name == key {
                            _ = catergorySelected?.removeValue(forKey: key)
                            self.delegates.getCategory(catergorySelected)
                            return
                        }
                    }
                }
            }
        }
    }
}














































