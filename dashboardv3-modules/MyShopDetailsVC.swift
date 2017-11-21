//
//  MyShopDetailsVC.swift
//  dashboardv2
//
//  Created by Hainizam on 10/11/2017.
//  Copyright © 2017 Ingeniworks Sdn Bhd. All rights reserved.
//

import UIKit
import SDWebImage

class MyShopDetailsVC: UIViewController {
    
    @IBOutlet weak var ownerNameLabel: UILabel!
    @IBOutlet weak var ownerEmailnPhoneNumberLabel: UILabel!
    @IBOutlet weak var productImageView: UIImageView!
    @IBOutlet weak var infoLabel: UILabel!
    @IBOutlet weak var producNameLabel: UILabel!
    @IBOutlet weak var locationLabel: UILabel!
    @IBOutlet weak var categoryLabel: UILabel!
    @IBOutlet weak var productHeaderView: ProductHeaderView!
    @IBOutlet weak var profileImageView: UIImageView!
    @IBOutlet weak var tableView: UITableView!
    
    //IBOutlet for comment section
    @IBOutlet weak var commentView: UIView!
    @IBOutlet weak var sendCommentButton: UIButton!
    @IBOutlet weak var commentTextview: UITextView!
    @IBOutlet weak var commentViewHeightConstraint: NSLayoutConstraint!
    
    private var productImagePageVC: ProductImagePageVC!
    var comments = [Comment]()
    var commentPlaceHolder = "Tulis sesuatu.."
    var placeHolderLabel: UILabel!
    var myShopDetailsID = 0
    var imageURLStrings = [String]()
    var isPerformSegue = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configureNotification()
        configureTableView()
        configureTextviewPlaceholder()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        populateData()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        self.tabBarController?.tabBar.isHidden = false
        NotificationCenter.default.removeObserver(self)
    }
    
    func populateData() {
        
        let urlString = "\(DBSettings.myShopProductDetailsURL)/\(myShopDetailsID)"
        let productDetails = ProductDetails.init(urlString)
        
        productDetails.fetchData { (result, response) in
            
            guard let resultData = result else { return }
            
            DispatchQueue.main.async {
                self.updateUI(resultData)
                self.comments = resultData.productComments
                self.tableView.reloadData()
                self.isPerformSegue = true
            }
        }
    }
    
    func configureTableView() {
        
        //hides tabbar
        self.tabBarController?.tabBar.isHidden = true
        
        let nibName = UINib(nibName: "MyShopCommentCell", bundle: nil)
        self.tableView.register(nibName, forCellReuseIdentifier: MyShopIdentifier.ProductCommentCell)
        
        let errorNib = UINib(nibName: "ErrorCell", bundle: nil)
        self.tableView.register(errorNib, forCellReuseIdentifier: "errorCell")
        
        tableView.dataSource = self
        tableView.delegate = self
        
        tableView.keyboardDismissMode = .interactive
        tableView.rowHeight = UITableViewAutomaticDimension
        tableView.estimatedRowHeight = 100
    }
    
    func configureNotification() {
        
        NotificationCenter.default.addObserver(self, selector: #selector(MyShopDetailsVC.keyboardWillShow), name: NSNotification.Name.UIKeyboardWillShow, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(MyShopDetailsVC.keyboardWillHide), name: NSNotification.Name.UIKeyboardWillHide, object: nil)
    }
    
    //Code untuk letak placeholder kat uitextview.
    func configureTextviewPlaceholder() {
        
        commentTextview.text = ""
        commentTextview.textColor = .black
        
        //buat label, untuk hold text act as placeholder.
        commentTextview.delegate = self
        placeHolderLabel = UILabel()
        placeHolderLabel.text = "Tulis sesuatu..."
        placeHolderLabel.font = UIFont.italicSystemFont(ofSize: (commentTextview.font?.pointSize)!)
        placeHolderLabel.sizeToFit()
        commentTextview.addSubview(placeHolderLabel)
        placeHolderLabel.frame.origin = CGPoint(x: 5, y: (commentTextview.font?.pointSize)! / 2)
        placeHolderLabel.textColor = UIColor.lightGray
        placeHolderLabel.isHidden = !commentTextview.text.isEmpty
    }
    
    private func updateUI(_ data: ProductDetails) {
        
        //headerview ui setup
        ownerNameLabel.backgroundColor = .clear
        ownerEmailnPhoneNumberLabel.backgroundColor = .clear
        producNameLabel.backgroundColor = .clear
        infoLabel.backgroundColor = .clear
        profileImageView.roundedCorners(profileImageView.frame.width / 2)
        profileImageView.backgroundColor = .purple
        
        //comment ui setup
        commentView.backgroundColor = DBColorSet.backgroundGray
        sendCommentButton.tintColor = DBColorSet.myShopColor
        
        //load data into the outlet
        ownerNameLabel.text = data.productOwnerName
        ownerEmailnPhoneNumberLabel.text = "\(data.productOwnerEmail!)・\(data.productOwnerPhone!)"
        producNameLabel.text = data.productName
        
        //check kalau ada satu je image, guna imageview if not guna pageviewcontroller.
        if let imageString = data.productImageURLs {
            
            guard imageString.count > 1 else {
                productImageView.isHidden = false
                productImageView.sd_setImage(with: URL(string: imageString[0]))
                return
            }
            productHeaderView.pageControl.isHidden = false
            productImagePageVC.productImagePageVCDelegate = productHeaderView
            productImagePageVC.imageURLStrings = data.productImageURLs
        }
        
        //remove the html tags.
        infoLabel.text = (data.productDescription.replacingOccurrences(of: "<[^>]+>", with: "", options: .regularExpression, range: nil)).replacingOccurrences(of: "&[^;]+;", with: "", options: .regularExpression, range: nil)
        
        locationLabel.text = "Lokasi: \(data.productLocation!)"
        categoryLabel.text = "Kategori: \(data.productCategory!)"
        
        
        //calculate the expanded or shrunk label.
        if labelNumberOfLines(ownerNameLabel) > 1 {
            productHeaderView.frame.size.height += (ownerNameLabel.intrinsicContentSize.height - ownerNameLabel.font.pointSize)
        }
        
        if labelNumberOfLines(ownerEmailnPhoneNumberLabel) > 1 {
            productHeaderView.frame.size.height += (ownerEmailnPhoneNumberLabel.intrinsicContentSize.height - ownerEmailnPhoneNumberLabel.font.pointSize)
        }
        
        if labelNumberOfLines(infoLabel) > 1 {
            productHeaderView.frame.size.height += (infoLabel.intrinsicContentSize.height - infoLabel.font.pointSize)
        }
        
        tableView.tableHeaderView = productHeaderView
    }
    
    func labelNumberOfLines(_ label: UILabel) -> Int {
        
        let textSize = label.intrinsicContentSize.height
        let textHeight = label.font.pointSize
        
        return Int(textSize / textHeight)
    }
    
    @objc func keyboardWillShow(notification: NSNotification) {
        if let keyboardSize = (notification.userInfo?[UIKeyboardFrameBeginUserInfoKey] as? NSValue)?.cgRectValue {
            if self.view.frame.origin.y == 0{
                self.view.frame.origin.y -= keyboardSize.height
            }
        }
    }
    
    @objc func keyboardWillHide(notification: NSNotification) {
        if let keyboardSize = (notification.userInfo?[UIKeyboardFrameBeginUserInfoKey] as? NSValue)?.cgRectValue {
            if self.view.frame.origin.y != 0{
                self.view.frame.origin.y += keyboardSize.height
            }
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        if segue.identifier == MyShopIdentifier.productImagePageVC {
            
            if let vc = segue.destination as? ProductImagePageVC {
                productImagePageVC = vc
            }
        }
    }
}

extension MyShopDetailsVC: UITableViewDataSource {
    
    // MARK: - Table view data source
    
    func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return "Comments"
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        let count = comments.count > 0 ? comments.count : 1
        return count
    }
}

extension MyShopDetailsVC: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        if comments.count > 0 {
            
            let cell = tableView.dequeueReusableCell(withIdentifier: MyShopIdentifier.ProductCommentCell, for: indexPath) as! MyShopCommentCell
            cell.comment = comments[indexPath.row]
            
            return cell
        } else {
            
            let cell = tableView.dequeueReusableCell(withIdentifier: "errorCell", for: indexPath) as! ErrorCell
            
            return cell
        }
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        
        if comments.count > 0 {
            return UITableViewAutomaticDimension
        } else {
            return 80.0
        }
    }
}

extension MyShopDetailsVC: UITextViewDelegate {
    
    func textViewDidChange(_ textView: UITextView) {
        placeHolderLabel.isHidden = !commentTextview.text.isEmpty
        expandAndShrinkingTheContentView()
    }
    
    //handle expanding and shrinking replyview.
    func expandAndShrinkingTheContentView() {
        
        let scrollableFrameSize = commentTextview.intrinsicContentSize.height
        print("Intrinsic size : \(scrollableFrameSize)")
        let scrollableContentSize = commentTextview.contentSize.height
        
        if scrollableFrameSize >= commentViewHeightConstraint.constant {
            
            commentTextview.isScrollEnabled = true
        } else if scrollableContentSize < commentViewHeightConstraint.constant {
            
            commentTextview.isScrollEnabled = false
        }
        
        commentView.sizeToFit()
    }
}













