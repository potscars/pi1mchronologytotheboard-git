//
//  GamesScoreboardController.swift
//  dashboardv2
//
//  Created by Hainizam on 20/07/2017.
//  Copyright © 2017 Ingeniworks Sdn Bhd. All rights reserved.
//

import UIKit

class GamesScoreboardController: UITableViewController {

    struct Storyboard {
        
        static let RankInfoCell = "rankInfoCell"
        static let LeaderboardCell = "leaderboardCell"
        static let GamesID = 1
        static let EventID = 1
    }
    
    var topScorerList: [TopScorer]?
    
    var isError = false
    var errorMessage = "Ops! Error detected!"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        topScorerList = [TopScorer]()
        
        //["Rookie Stalion", "Kim Hee Chul", "Karim", "Sadiy Pomade", "Kei", "Dwayne Johnson", "Scarlett"]
        
        let playButton = UIBarButtonItem(title: "Play", style: .plain, target: self, action: #selector(playTapped(_:)))
        navigationItem.rightBarButtonItem = playButton
        navigationItem.title = "MyGames"
        
        tableView.rowHeight = UITableViewAutomaticDimension
        tableView.estimatedRowHeight = 100.0
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "errorCell")
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        let loadingSpinner = LoadingSpinner.init(view: self.view, isNavBar: true)
        loadingSpinner.setLoadingScreen()
        
        if DBWebServices.checkConnectionToDashboard(viewController: self) {
            
            isError = false
            let topScorer = TopScorer.init()
            
            topScorer.fetchTopScorer(Storyboard.GamesID, eventID: Storyboard.EventID, completion: { (result, responses) in
                
                DispatchQueue.main.async {
                    
                    guard responses == nil else {
                        
                        self.isError = true
                        self.errorMessage = responses!
                        loadingSpinner.removeLoadingScreen()
                        self.tableView.reloadData()
                        return
                    }
                    
                    if let result = result {
                        
                        self.topScorerList = result
                        loadingSpinner.removeLoadingScreen()
                        self.tableView.reloadData()
                    }
                }
                
            })
        } else {
            
            isError = true
            errorMessage = "There is no network connection.."
            loadingSpinner.removeLoadingScreen()
            
        }
    }

    @objc func playTapped(_ sender: UIBarButtonItem) {
        
        AlertController().alertController(self, title: "Warning!", message: "Under maintainance. Sorry for the inconvenience.")
    }
}

//MARK: - Datasource 

extension GamesScoreboardController {
    
    // MARK: - Table view data source
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        if isError {
            
            return 2
        } else {
          
            let rowCount = (topScorerList?.count)! + 1
            
            return rowCount
        }
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let index = indexPath.row
        
        if index == 0 {
            
            let cell = tableView.dequeueReusableCell(withIdentifier: Storyboard.RankInfoCell, for: indexPath)
            cell.selectionStyle = .none
            
            return cell
            
        } else {
            
            if isError {
                
                let cell = tableView.dequeueReusableCell(withIdentifier: "errorCell", for: indexPath)
                
                cell.selectionStyle = .none
                cell.textLabel?.text = errorMessage
                cell.textLabel?.textAlignment = .center
                cell.textLabel?.textColor = .darkGray
                cell.textLabel?.font = UIFont.boldSystemFont(ofSize: 15.0)
                
                return cell
            } else {
                
                let cell = tableView.dequeueReusableCell(withIdentifier: Storyboard.LeaderboardCell, for: indexPath) as! GamesScoreboardCell
                
                let scoreString = "\(index). \((topScorerList?[index - 1].fullname)!)"
                
                cell.updateScoreboardList(scoreString, topScorerScore: (topScorerList?[index - 1].score)!)
                cell.selectionStyle = .none
                
                return cell
            }
        }
    }
}











