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
}

class MyKospenTVC: UITableViewController {
    
    @IBOutlet weak var myKospenHeaderView: MyKospenHeaderView!
    
    let nameArrays = ["Blood Sugar Level","Body Weight","Body Height","Blood Pressure","Smoking Status"]
    let unitArrays = ["mg","kg","cm","mm/Hg",""]
    
    let sectionName = ["Body Mass Index (BMI)", "Blood Sugar Level", "Blood Pressure"]
    
    var statusTableView: MyKospenStatusTV!
    var isExpanded = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationController?.changeKospenNavigationBarColor()
        
        configureTableView()
        updateChart()
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
        
        myKospenHeaderView.bmiCharts.noDataText = "No data"
        myKospenHeaderView.bmiCharts.holeRadiusPercent = 0.95
        myKospenHeaderView.bmiCharts.rotationAngle = 0.7
        myKospenHeaderView.bmiCharts.rotationEnabled = false
        
        // see referral for more info: http://github.com/danielgindi/Charts/issues/2441
        
        let paraStyle: NSMutableParagraphStyle = NSMutableParagraphStyle.init()
        paraStyle.alignment = NSTextAlignment.center
        let attrib: [NSAttributedStringKey : Any] = [NSAttributedStringKey.font: UIFont.init(name: "ArialMT", size: 16.0)!, NSAttributedStringKey.paragraphStyle: paraStyle]
        let centerFontAttrib: NSAttributedString = NSAttributedString.init(string: "20.49\nBMI", attributes: attrib)
        
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
        
        let count = tableView == statusTableView ? nameArrays.count : 7
        
        if tableView == self.tableView && section == 0 {
            return 1
        }
        
        return count
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
            
            let cell = tableView.dequeueReusableCell(withIdentifier: KospenIdentifier.StatusValueCell, for: indexPath) as! MyKospenStatusCell
            
            cell.selectionStyle = .none
            cell.updateUI(nameArrays[indexPath.row])
            
            return cell
        } else {
            
            
            if indexPath.section == 0 {
                
                let cell = tableView.dequeueReusableCell(withIdentifier: KospenIdentifier.DescriptionCell, for: indexPath)
                cell.selectionStyle = .none
                
                return cell
            } else if indexPath.section == 1 {
                
                if index == 0 {
                    let cell = tableView.dequeueReusableCell(withIdentifier: KospenIdentifier.ChartCell, for: indexPath) as! ChartCell
                    cell.selectionStyle = .none
                    return cell
                } else if index == 1 {
                    
                    let cell = tableView.dequeueReusableCell(withIdentifier: KospenIdentifier.StringCell, for: indexPath)
                    cell.selectionStyle = .none
                    return cell
                } else if index == 2 {
                    let cell = tableView.dequeueReusableCell(withIdentifier: KospenIdentifier.RecordTitleCell, for: indexPath)
                    cell.selectionStyle = .none
                    return cell
                } else {
                    let cell = tableView.dequeueReusableCell(withIdentifier: KospenIdentifier.BMIRecordCell, for: indexPath)
                    cell.selectionStyle = .none
                    return cell
                }
                
            } else if indexPath.section == 2 {
                if index == 0 {
                    let cell = tableView.dequeueReusableCell(withIdentifier: KospenIdentifier.ChartCell, for: indexPath) as! ChartCell
                    cell.selectionStyle = .none
                    return cell
                } else if index == 1 {
                    
                    let cell = tableView.dequeueReusableCell(withIdentifier: KospenIdentifier.StringCell, for: indexPath)
                    cell.selectionStyle = .none
                    return cell
                } else if index == 2 {
                    let cell = tableView.dequeueReusableCell(withIdentifier: KospenIdentifier.RecordTitleCell, for: indexPath)
                    cell.selectionStyle = .none
                    return cell
                } else {
                    let cell = tableView.dequeueReusableCell(withIdentifier: KospenIdentifier.RecordCell, for: indexPath)
                    cell.selectionStyle = .none
                    return cell
                }
            } else {
                if index == 0 {
                    let cell = tableView.dequeueReusableCell(withIdentifier: KospenIdentifier.ChartCell, for: indexPath) as! ChartCell
                    cell.selectionStyle = .none
                    return cell
                } else if index == 1 {
                    
                    let cell = tableView.dequeueReusableCell(withIdentifier: KospenIdentifier.StringCell, for: indexPath)
                    cell.selectionStyle = .none
                    return cell
                } else if index == 2 {
                    let cell = tableView.dequeueReusableCell(withIdentifier: KospenIdentifier.RecordTitleCell, for: indexPath)
                    cell.selectionStyle = .none
                    return cell
                } else {
                    let cell = tableView.dequeueReusableCell(withIdentifier: KospenIdentifier.RecordCell, for: indexPath)
                    cell.selectionStyle = .none
                    return cell
                }
            }
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














