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
}

class MyKospenTVC: UITableViewController {
    
    @IBOutlet weak var myKospenHeaderView: MyKospenHeaderView!
    @IBOutlet weak var profileTableView: UITableView!
    
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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationController?.changeKospenNavigationBarColor()
        
        configureTableView()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        let kospenProfile = KospenProfile()
        
        kospenProfile.fetchProfileData { (result, responses) in
            
            guard responses == nil else { return }
            
            guard let dataResult = result else { return }
            
            DispatchQueue.main.async {
                self.profileData = dataResult
                self.totalStatus = 5
                self.statusTableView.reloadData()
                self.updateChart()
                self.updateGraphView(self.profileData["MYHEALTH_ID"] as! Int)
            }
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
                self.tableView.reloadSections(IndexSet(integer: 1), with: .automatic)
            }
        }
        
        glucoseGraphData.fetchData { (result) in
            guard let dataResult = result else { return }
            
            DispatchQueue.main.async {
                self.glucoseData = dataResult
                print(self.glucoseData.count)
                self.tableView.reloadSections(IndexSet(integer: 2), with: .automatic)
            }
        }
        
        bloodPressureGraph.fetchData { (result) in
            guard let dataResult = result else { return }
            
            DispatchQueue.main.async {
                self.bloodPressureData = dataResult
                print(self.bloodPressureData.count)
                self.tableView.reloadSections(IndexSet(integer: 3), with: .automatic)
            }
        }
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
}

extension MyKospenTVC {
    
    // MARK: - Table view data source
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        let sectionCount = tableView == self.tableView ? sectionName.count + 1 : 1
        return sectionCount
    }
    
    override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        
        guard tableView == self.tableView else { return nil }
        
        if section != 0 {
            
            return sectionName[section - 1]
        }
        
        return nil
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        if tableView == self.tableView {
            if section == 0 {
                return 1
            } else if section == 1 {
                return bmiData.count > 0 ? bmiData.count + 2 : 0
            } else if section == 2 {
                return glucoseData.count > 0 ? glucoseData.count + 2 : 0
            } else {
                return bloodPressureData.count > 0 ? bloodPressureData.count + 2 : 0
            }
        } else if tableView == statusTableView {
            return totalStatus
        } else {
            return 7
        }
        
    }
    
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        /*
         section 0 - description
         section 1 - bmi value
         section 2 - blood sugar level
         section 3 - blood pressure
         */
        
        let index = indexPath.row
        
        if tableView == statusTableView {
            
            /*
             0 - intervensi
             1 - lilit pinggang
             2 - tinggi
             3 - penyakit sendiri
             4 - status merokok
             5 - penyakit keluarga
             6 - ingin berhenti merokok
             7 - dikemaskini
             */
            
            return populateStatusDataIntoCell(tableView, indexPath: indexPath)
            
        } else {
            
            
            if indexPath.section == 0 {
                
                let cell = tableView.dequeueReusableCell(withIdentifier: KospenIdentifier.DescriptionCell, for: indexPath)
                cell.selectionStyle = .none
                
                return cell
            } else if indexPath.section == 1 {
                
                if index == 0 {
                    let cell = tableView.dequeueReusableCell(withIdentifier: KospenIdentifier.ChartCell, for: indexPath) as! ChartCell
                    
                    let dateArray = getDateArray(bmiData)
                    cell.selectionStyle = .none
                    cell.updateBMICharts(bmiData, dateArray: dateArray)
                    return cell
                } else if index == 1 {
                    
                    let cell = tableView.dequeueReusableCell(withIdentifier: KospenIdentifier.StringCell, for: indexPath)
                    cell.selectionStyle = .none
                    return cell
                } else {
                    let cell = tableView.dequeueReusableCell(withIdentifier: KospenIdentifier.BMIRecordCell, for: indexPath) as! BMIRecordCell
                    cell.selectionStyle = .none
                    cell.updateUI(bmiData[indexPath.row - 2])
                    
                    return cell
                }
                
            } else if indexPath.section == 2 {
                if index == 0 {
                    let cell = tableView.dequeueReusableCell(withIdentifier: KospenIdentifier.ChartCell, for: indexPath) as! ChartCell
                    let dateArray = getDateArray(glucoseData)
                    cell.selectionStyle = .none
                    cell.updateGlucoseCharts(glucoseData, dateArray: dateArray)
                    return cell
                } else if index == 1 {
                    
                    let cell = tableView.dequeueReusableCell(withIdentifier: KospenIdentifier.StringCell, for: indexPath)
                    cell.selectionStyle = .none
                    return cell
                } else {
                    let cell = tableView.dequeueReusableCell(withIdentifier: KospenIdentifier.RecordCell, for: indexPath) as! RecordCell
                    cell.selectionStyle = .none
                    cell.updateUI(glucoseData[indexPath.row - 2])
                    return cell
                }
            } else {
                if index == 0 {
                    let cell = tableView.dequeueReusableCell(withIdentifier: KospenIdentifier.ChartCell, for: indexPath) as! ChartCell
                    cell.selectionStyle = .none
                    cell.updateBloodPressureCharts(bloodPressureData, dateArray: [])
                    return cell
                } else if index == 1 {
                    
                    let cell = tableView.dequeueReusableCell(withIdentifier: KospenIdentifier.StringCell, for: indexPath)
                    cell.selectionStyle = .none
                    return cell
                } else {
                    let cell = tableView.dequeueReusableCell(withIdentifier: KospenIdentifier.RecordCell, for: indexPath) as! RecordCell
                    cell.selectionStyle = .none
                    cell.updateUI(bloodPressureData[indexPath.row - 2])
                    return cell
                }
            }
        }
    }
    
    //make an array for date indicator for each section.
    private func getDateArray(_ graphData: [GraphData]) -> [Int] {
        
        var intTemp = [Int]()
        
        for data in graphData {
            
            let formatter = DateFormatter()
            formatter.dateFormat = "yyyy-MM-dd HH:mm:ss"
            let date = formatter.date(from: data.createdDate!)!
            let components = Calendar.current.dateComponents([.day], from: date)
            intTemp.append(components.day!)
        }
        
        return intTemp
    }
    
    private func getDateTitle(_ dateString: String) -> String {
        
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd HH:mm:ss"
        let date = formatter.date(from: dateString)!
        
        formatter.dateFormat = "MMMM yyyy"
        let newDateString = formatter.string(from: date)
        
        return newDateString
    }
    
    private func setupTitleCell(_ cell: UITableViewCell, dateString: String, titleString: String = "") {
        
        cell.selectionStyle = .none
        let monthName = cell.viewWithTag(1) as! UILabel
        let bmiLabel = cell.viewWithTag(2) as! UILabel
        monthName.text = dateString
        bmiLabel.text = ""
    }
    
    func populateStatusDataIntoCell(_ tableView: UITableView, indexPath: IndexPath) -> UITableViewCell {
        
        let index = indexPath.row
        
        if index == 0 {
            let cell = tableView.dequeueReusableCell(withIdentifier: KospenIdentifier.StatusValueCell, for: indexPath) as! MyKospenStatusCell
            
            cell.selectionStyle = .none
            cell.updateUIWithString(KospenProfileIdentifier.BloodSugarLevel, value: "\(profileData[KospenProfileIdentifier.BloodSugarLevel] ?? "-")")
            
            return cell
        } else if index == 1 {
            let cell = tableView.dequeueReusableCell(withIdentifier: KospenIdentifier.StatusValueCell, for: indexPath) as! MyKospenStatusCell
            
            cell.selectionStyle = .none
            cell.updateUIWithIntValue(KospenProfileIdentifier.BeratBadan, value: profileData[KospenProfileIdentifier.BeratBadan] as! Int, indicator: "kg")
            
            return cell
        } else if index == 2 {
            let cell = tableView.dequeueReusableCell(withIdentifier: KospenIdentifier.StatusValueCell, for: indexPath) as! MyKospenStatusCell
            
            cell.selectionStyle = .none
            cell.updateUIWithCGFloatValue(KospenProfileIdentifier.Height, value: profileData[KospenProfileIdentifier.Height] as! CGFloat, indicator: "m")
            
            return cell
        } else if index == 3 {
            let cell = tableView.dequeueReusableCell(withIdentifier: KospenIdentifier.StatusValueCell, for: indexPath) as! MyKospenStatusCell
            
            cell.selectionStyle = .none
            cell.updateUIWithString(KospenProfileIdentifier.BloodPressure, value: profileData[KospenProfileIdentifier.BloodPressure] as! String, fontSize: 10)
            
            return cell
        } else {
            let cell = tableView.dequeueReusableCell(withIdentifier: KospenIdentifier.StatusValueCell, for: indexPath) as! MyKospenStatusCell
            
            cell.selectionStyle = .none
            cell.updateUIWithString(KospenProfileIdentifier.SmokingStatus, value: profileData[KospenProfileIdentifier.SmokingStatus] as! String)
            
            return cell
        }
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        //ip5 175.0
        
        if tableView == statusTableView {
            return 35.0
        } else {
            //let height: CGFloat = UIScreen.main.nativeBounds.height <= 1136 ? 180.0 : 200.0
            
            return UITableViewAutomaticDimension
        }
    }
}












