//
//  MyHealthGlucoseTVC.swift
//  dashboardv2
//
//  Created by Mohd Zulhilmi Mohd Zain on 15/11/2017.
//  Copyright © 2017 Ingeniworks Sdn Bhd. All rights reserved.
//

import UIKit
import Charts



struct KospenIdentifier {
    
    static let SummaryReviewCell = "SummaryReviewCell"
    static let StatusValueCell = "StatusValueCell"
    static let ChartCell = "chartCell"
    static let RecordCell = "recordCell"
    static let DescriptionCell = "descriptionCell"
    static let StringCell = "stringCell" //record from your last checkup
    static let RecordTitleCell = "recordTitleCell" //cell untuk letak date ngn value title
    static let KospenQuestionaireCell = "kospenQuestionCell" //identier untuk cell yang ada soalan(details)
    static let BMIRecordCell = "bmiRecordCell"
    static let ProfileDetailsCell = "profileDetailsCell"
    static let KospenUserMeasureCell = "kospenUserMeasureCell"
    static let MedicalHistoryCell = "medicalHistoryCell"
    static let ImageViewCell = "imageViewCell"
}

class MyKospenTVC: UITableViewController {
    
    @IBOutlet weak var myKospenHeaderView: MyKospenHeaderView!
    @IBOutlet weak var updateButton: UIBarButtonItem!
    
    let nameArrays = ["Blood Sugar Level","Body Weight","Body Height","Blood Pressure","Smoking Status"]
    let unitArrays = ["mg","kg","cm","mm/Hg",""]
    
    let sectionName = ["Body Mass Index (BMI)", "Blood Sugar Level", "Blood Pressure"]
    
    var profileData: [String: Any] = [:]
    var bmiData = [GraphData]()
    var glucoseData = [GraphData]()
    var bloodPressureData = [GraphData]()
    
    var statusTableView: MyKospenStatusTV!
    var totalStatus = 0
    var isExpanded = false
    var spinner: LoadingSpinner!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        spinner = LoadingSpinner.init(view: self.view, isNavBar: true)
        configureNavBar()
        configureTableView()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        let kospenProfile = KospenProfile()
        spinner.setLoadingScreen()
        
        if DBWebServices.checkConnectionToDashboard(viewController: self) {
            
            kospenProfile.fetchProfileData { (result, responses) in
                
                guard responses == nil else { return }
                
                guard let dataResult = result else { return }
                
                DispatchQueue.main.async {
                    self.profileData = dataResult
                    self.totalStatus = 5
                    self.statusTableView.reloadData()
                    self.updateButton.isEnabled = true
                    self.updateChart()
                    self.updateGraphView(self.profileData["MYHEALTH_ID"] as! Int)
                    self.spinner.removeLoadingScreen()
                }
            }
        } else {
            self.spinner.removeLoadingScreen()
        }
    }
    
    func updateGraphView(_ myhealthID: Int) {
        
        let bmiGraphData = GraphData.init("wt")
        let glucoseGraphData = GraphData.init("glu")
        let bloodPressureGraph = GraphData.init("bp")
        
        bmiGraphData.fetchData { (result) in
            guard let dataResult = result else { return }
            
            DispatchQueue.main.async {
                self.bmiData = dataResult
                print(self.bmiData.count)
                self.tableView.reloadSections(IndexSet(integer: 0), with: .automatic)
            }
        }
        
        glucoseGraphData.fetchData { (result) in
            guard let dataResult = result else { return }
            
            DispatchQueue.main.async {
                self.glucoseData = dataResult
                print(self.glucoseData.count)
                self.tableView.reloadSections(IndexSet(integer: 1), with: .automatic)
            }
        }
        
        bloodPressureGraph.fetchData { (result) in
            guard let dataResult = result else { return }
            
            DispatchQueue.main.async {
                self.bloodPressureData = dataResult
                print(self.bloodPressureData.count)
                self.tableView.reloadSections(IndexSet(integer: 2), with: .automatic)
            }
        }
    }
    
    func configureNavBar() {
        updateButton.isEnabled = false
        navigationController?.changeKospenNavigationBarColor()
        navigationItem.title = "Kospen"
    }
    
    func configureTableView() {
        
        //setting for main tableview
        tableView.separatorStyle = .none
        self.tableView.rowHeight = UITableViewAutomaticDimension
        self.tableView.estimatedRowHeight = 150.0
        
        let chartNib = UINib(nibName: "ChartCell", bundle: nil)
        self.tableView.register(chartNib, forCellReuseIdentifier: KospenIdentifier.ChartCell)
        
        let recordNib = UINib(nibName: "RecordCell", bundle: nil)
        self.tableView.register(recordNib, forCellReuseIdentifier: KospenIdentifier.RecordCell)
        
        let bmirecordNib = UINib(nibName: "BMIRecordCell", bundle: nil)
        self.tableView.register(bmirecordNib, forCellReuseIdentifier: KospenIdentifier.BMIRecordCell)
        
        //setting for status value tableview
        statusTableView = myKospenHeaderView.statusValueTableView as! MyKospenStatusTV!
        statusTableView.dataSource = self
        statusTableView.delegate = self
        statusTableView.separatorStyle = .none
    }
    
    func updateChart() {
        
        let bmiTemp = profileData[KospenProfileIdentifier.BMI] as! Double
        let dateTemp = profileData[KospenProfileIdentifier.UpdatedAt] as! String
        myKospenHeaderView.dateLabel.text = "Last Updated: \(dateTemp)"
        
        myKospenHeaderView.bmiCharts.noDataText = "No data"
        myKospenHeaderView.bmiCharts.holeRadiusPercent = 0.95
        myKospenHeaderView.bmiCharts.rotationAngle = 0.7
        myKospenHeaderView.bmiCharts.rotationEnabled = false
        
        // see referral for more info: http://github.com/danielgindi/Charts/issues/2441
        
        let paraStyle: NSMutableParagraphStyle = NSMutableParagraphStyle.init()
        paraStyle.alignment = NSTextAlignment.center
        let attrib: [NSAttributedStringKey : Any] = [NSAttributedStringKey.font: UIFont.init(name: "ArialMT", size: 16.0)!, NSAttributedStringKey.paragraphStyle: paraStyle]
        let centerFontAttrib: NSAttributedString = NSAttributedString.init(string: "\(bmiTemp)\nBMI", attributes: attrib)
        
        myKospenHeaderView.bmiCharts.centerAttributedText = centerFontAttrib

        // Disable chart description
        let desc: Description = myKospenHeaderView.bmiCharts.chartDescription!
        desc.enabled = false
        
        // Disable chart legend
        let legend: Legend = myKospenHeaderView.bmiCharts.legend
        legend.enabled = false
        
        var dataEntries: [PieChartDataEntry] = []
        
        var dataEntry: PieChartDataEntry = PieChartDataEntry.init(value: 20)
        dataEntries.append(dataEntry)
        
        dataEntry = PieChartDataEntry.init(value: 80)
        dataEntries.append(dataEntry)
        
        let chartDataSet: PieChartDataSet = PieChartDataSet.init(values: dataEntries, label: "Last updated")
        chartDataSet.drawValuesEnabled = false
        chartDataSet.colors = [UIColor.lightGray, UIColor.gray]
        
        let chartData: PieChartData = PieChartData.init(dataSet: chartDataSet)
        
        myKospenHeaderView.bmiCharts.data = chartData
    }
    
    @IBAction func homeButtonTapped(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        if segue.identifier == "GOTO_KOSPEN_UPDATE" {
            
            if let updateVC = segue.destination as? MyKospenProfileUpdateTVC {
                updateVC.profileData = profileData
            }
        }
    }
}








