//
//  DiseasesListVC.swift
//  dashboardv2
//
//  Created by Hainizam on 03/01/2018.
//  Copyright © 2018 Ingeniworks Sdn Bhd. All rights reserved.
//

import UIKit

class DiseasesListVC: UIViewController {

    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var customView: UIView!
    
    var diseases = [Disease]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.dataSource = self
        tableView.delegate = self
        customView.roundedCorners(5)
    }
    
    @IBAction func doneButtonTapped(_ sender: UIButton) {
        
    }
    
    @IBAction func cancelButtonTapped(_ sender: UIButton) {
        self.dismiss(animated: true, completion: nil)
    }
}

extension DiseasesListVC: UITableViewDataSource, UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return diseases.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "diseaseCell", for: indexPath)
        
        let titleLabel = cell.viewWithTag(1) as! UILabel
        titleLabel.text = diseases[indexPath.row].name
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 44.0
    }
}














