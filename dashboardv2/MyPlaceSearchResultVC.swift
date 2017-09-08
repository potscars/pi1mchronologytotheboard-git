//
//  MyPlaceSearchResultVC.swift
//  dashboardKB
//
//  Created by Hainizam on 13/06/2017.
//  Copyright © 2017 Ingeniworks Sdn Bhd. All rights reserved.
//

import UIKit

class MyPlaceSearchResultVC: UIViewController {

    struct Storyboard {
        
        static let GotoSearchDetails = "GOTO_SEARCHDETAILS"
    }
    
    @IBOutlet weak var tableView: UITableView!
    
    var searchResultText: String!
    var placeList = [Place]()
    var placeDataToPass: Place!
    
    var isError = false
    var errorMessage = "Well! Error spotted!"
    
    var loadingSpinner: LoadingSpinner!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        print(searchResultText ?? "Hey World!")
        
        self.configureTableView()
        self.configureNavBar()
        
        loadingSpinner = LoadingSpinner.init(view: self.view, isNavBar: true)
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        if DBWebServices.checkConnectionToDashboard(viewController: self) {
            
            if placeList.count == 0 {
                loadingSpinner.setLoadingScreen()
                self.fetchSearchedResult()
            }
        } else {
            self.isError = true
            self.errorMessage = "Please check your network connection."
            self.tableView.reloadData()
        }
        

    }
    
    //MARK: - Fetch data model
    func fetchSearchedResult() {
        
        let place = Place.init()
        
        //Discard the whitespace, gonna be added to url.
        guard let escapedResultString = searchResultText.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed) else { print("Cant add percent to string"); return }
        
        place.fetchPlace(escapedResultString) { (result, error) in
            
            DispatchQueue.main.async {
                
                guard error == nil else {
                    self.isError = true
                    self.loadingSpinner.removeLoadingScreen()
                    self.errorMessage = error!
                    self.tableView.reloadData()
                    return
                }
                
                if let result = result {
                    self.isError = false
                    self.loadingSpinner.removeLoadingScreen()
                    self.placeList = result
                    self.tableView.reloadData()
                }
            }
        }
    }
    
    func configureTableView() {
        
        self.tableView.dataSource = self
        self.tableView.delegate = self
        
        self.tableView.rowHeight = UITableViewAutomaticDimension
        self.tableView.estimatedRowHeight = 320
    }
    
    func configureNavBar() {
        
        self.navigationController?.navigationBar.tintColor = UIColor.white
        self.navigationController?.navigationBar.isTranslucent = false
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        if segue.identifier == Storyboard.GotoSearchDetails {
            
            if let vc = segue.destination as? MyPlaceSearchedResultDetails {
                
                vc.placeDetails = placeDataToPass
            }
        }
    }
}

//MARK - Datasource and Delegates
extension MyPlaceSearchResultVC: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        if isError {
            return 1
        } else {
            return placeList.count
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        if isError {
            let cell = tableView.dequeueReusableCell(withIdentifier: "searchedErrorCell", for: indexPath)
            cell.selectionStyle = .none
            
            let errorMessageLabel = cell.viewWithTag(1) as! UILabel
            
            errorMessageLabel.text = errorMessage
            
            return cell
        } else {
            
            let cell = tableView.dequeueReusableCell(withIdentifier: "searchedResultCell", for: indexPath) as! SearchedResultCell
            cell.selectionStyle = .none
            
            if indexPath.item % 2 == 0 {
                cell.isImage = true
            } else {
                cell.isImage = false
            }
            cell.place = placeList[indexPath.item]
            
            return cell
        }
    }
}

extension MyPlaceSearchResultVC: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        
        if isError {
            return self.view.bounds.height
        } else {
            return UITableViewAutomaticDimension
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        if let _ = tableView.cellForRow(at: indexPath) {
            
            placeDataToPass = placeList[indexPath.item]
            performSegue(withIdentifier: Storyboard.GotoSearchDetails, sender: self)
        }
    }
}



























