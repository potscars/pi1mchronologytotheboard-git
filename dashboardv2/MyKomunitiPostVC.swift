//
//  MyKomunitiPostVC.swift
//  dashboardv2
//
//  Created by Hainizam on 13/07/2017.
//  Copyright © 2017 Ingeniworks Sdn Bhd. All rights reserved.
//

import UIKit

class MyKomunitiPostVC: UIViewController {

    struct Storyboard {
        
        static let TitleCell = "titleCell"
        static let SenderCell = "senderCell"
        static let ContentCell = "contentCell"
    }
    
    @IBOutlet weak var tableView: UITableView!
    
    var postButton: UIBarButtonItem!
    
    var titleTextView: String?
    var contentTextView: String?
    
    var isTitleFilled = false
    var isContentFilled = false
    
    override func viewDidLoad() {
        super.viewDidLoad()

        setupTableView()
        setupBarButton()
    }

    func setupTableView() {
        
        tableView.dataSource = self
        tableView.keyboardDismissMode = .interactive
        tableView.allowsSelection = false
        
        tableView.estimatedRowHeight = 200.0
        tableView.rowHeight = UITableViewAutomaticDimension
    }
    
    func setupBarButton() {
        
        postButton = UIBarButtonItem(title: "Post", style: .done, target: self, action: #selector(postButtonTapped(_:)))
        postButton.isEnabled = false
        
        self.navigationItem.rightBarButtonItem = postButton
    }
    
    func postButtonTapped(_ sender: UIBarButtonItem) {
        
        print("Title\(titleTextView) Content\(contentTextView)")
        
        let alertController = AlertController()
        
        if DBWebServices.checkConnectionToDashboard(viewController: self) {
            DBWebServices.postMyKomunitiPostAnnouncement(viewController: self, title: titleTextView!, contentMessage: contentTextView!)
        } else {
            
            alertController.alertController(self, title: "Error", message: "Please check your network connection..")
        }
    }
}

extension MyKomunitiPostVC: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 2
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let index = indexPath.item
        
        if index == 0 {
            
            let cell = tableView.dequeueReusableCell(withIdentifier: Storyboard.TitleCell, for: indexPath) as! MyKomunitiPostTitleCell

            cell.titleTextView.delegate = self
            
            return cell
        } else if index == 1 {
            
            let cell = tableView.dequeueReusableCell(withIdentifier: Storyboard.ContentCell, for: indexPath) as! MyKomunitiPostContentCell
            
            cell.contentTextView.delegate = self
            
            return cell
        }
    
        return UITableViewCell()
    }
}

extension MyKomunitiPostVC: UITextViewDelegate {
    
    func textViewDidBeginEditing(_ textView: UITextView) {
        
        if textView.textColor == UIColor.lightGray {
            
            textView.text = nil
            textView.textColor = .black
        }
        
        if textView.text == nil || textView.text == "" {
            
            if textView.tag == 1 {
                
                isTitleFilled = false
            } else if textView.tag == 2 {
                
                isContentFilled = false
            }
        } else {
            
            if textView.tag == 1 {
                
                isTitleFilled = true
            } else if textView.tag == 2 {
                
                isContentFilled = true
            }
        }
    }
    
    func textViewDidEndEditing(_ textView: UITextView) {
        
        if textView.text == nil || textView.text == ""{
            
            textView.textColor = .lightGray
            
            if textView.tag == 1 {
                
                textView.text = "What's on your mind?"
                isTitleFilled = false
            } else if textView.tag == 2 {
                
                textView.text = "What's about it?"
                isContentFilled = false
            }
        }
    }
    
    func textViewDidChange(_ textView: UITextView) {
        let currentOffset = tableView.contentOffset
        UIView.setAnimationsEnabled(false)
        tableView.beginUpdates()
        tableView.endUpdates()
        UIView.setAnimationsEnabled(true)
        tableView.setContentOffset(currentOffset, animated: false)
        
        if isTitleFilled && isContentFilled && textView.textColor == .black {
            
            postButton.isEnabled = true
        }
        
        if textView.tag == 1 {
            
            self.titleTextView = textView.text
        } else {
            
            self.contentTextView = textView.text
        }
        
        if textView.text == nil || textView.text == "" {
            
            postButton.isEnabled = false
        }
    }
}

































