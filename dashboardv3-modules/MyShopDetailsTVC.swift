//
//  MyShopDetailsTVC.swift
//  dashboardv2
//
//  Created by Hainizam on 07/11/2017.
//  Copyright © 2017 Ingeniworks Sdn Bhd. All rights reserved.
//

import UIKit

class MyShopDetailsTVC: UITableViewController {

    @IBOutlet weak var ownerNameLabel: UILabel!
    @IBOutlet weak var ownerEmailnPhoneNumberLabel: UILabel!
    @IBOutlet weak var productImageView: UIImageView!
    @IBOutlet weak var infoLabel: UILabel!
    @IBOutlet weak var locationLabel: UILabel!
    @IBOutlet weak var categoryLabel: UILabel!
    @IBOutlet weak var headerContentView: UIView!
    @IBOutlet weak var profileImageView: UIImageView!
    
    var Comments = [String]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configureTableView()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        updateUI()
    }
    
    func configureTableView() {
        
        let nibName = UINib(nibName: "MyShopCommentCell", bundle: nil)
        self.tableView.register(nibName, forCellReuseIdentifier: MyShopIdentifier.ProductCommentCell)
        
        let errorNib = UINib(nibName: "ErrorCell", bundle: nil)
        self.tableView.register(errorNib, forCellReuseIdentifier: "errorCell")
        
        tableView.rowHeight = UITableViewAutomaticDimension
        tableView.estimatedRowHeight = 100
    }
    
    private func updateUI() {
        
        ownerNameLabel.backgroundColor = .clear
        ownerEmailnPhoneNumberLabel.backgroundColor = .clear
        infoLabel.backgroundColor = .clear
        profileImageView.roundedCorners(profileImageView.frame.width / 2)
        profileImageView.backgroundColor = .purple
        
        ownerNameLabel.text = "Dwayne Johnson"
        ownerEmailnPhoneNumberLabel.text = "myshop@ingeniworks.com.my・0123654789"
        infoLabel.text = "Manga is the Japanese comics with a unique story line and style. In Japan people of all ages read manga, manga does not target younger audiences like american comics."
        
        if labelNumberOfLines(ownerNameLabel) > 1 {
            headerContentView.frame.size.height += (ownerNameLabel.intrinsicContentSize.height - ownerNameLabel.font.pointSize)
        }
        
        if labelNumberOfLines(ownerEmailnPhoneNumberLabel) > 1 {
            headerContentView.frame.size.height += (ownerEmailnPhoneNumberLabel.intrinsicContentSize.height - ownerEmailnPhoneNumberLabel.font.pointSize)
        }
        
        if labelNumberOfLines(infoLabel) > 1 {
            headerContentView.frame.size.height += (infoLabel.intrinsicContentSize.height - infoLabel.font.pointSize)
        }
        
        tableView.tableHeaderView = headerContentView
    }

    func labelNumberOfLines(_ label: UILabel) -> Int {
        
        let textSize = label.intrinsicContentSize.height
        let textHeight = label.font.pointSize
        
        return Int(textSize / textHeight)
    }
    
    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }
    
    override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return "Comments"
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        let count = Comments.count > 0 ? Comments.count : 1
        
        return count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        if Comments.count > 0 {
        
            let cell = tableView.dequeueReusableCell(withIdentifier: MyShopIdentifier.ProductCommentCell, for: indexPath) as! MyShopCommentCell
        
            return cell
        } else {
            
            let cell = tableView.dequeueReusableCell(withIdentifier: "errorCell", for: indexPath) as! ErrorCell
            
            return cell
        }
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        
        if Comments.count > 0 {
            return UITableViewAutomaticDimension
        } else {
            return 80.0
        }
    }
}














