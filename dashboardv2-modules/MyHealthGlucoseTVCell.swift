//
//  MyHealthGlucoseTVCell.swift
//  dashboardv2
//
//  Created by Mohd Zulhilmi Mohd Zain on 15/11/2017.
//  Copyright © 2017 Ingeniworks Sdn Bhd. All rights reserved.
//

import UIKit
import Charts

class MyHealthGlucoseTVCell: UITableViewCell, UITableViewDataSource, UITableViewDelegate {
 
    @IBOutlet weak var pcvMHGTVCPieChart: PieChartView!
    @IBOutlet weak var pvcMHGTVCListOfHealth: MyHealthGlucoseInfoGTV!
    
    let nameArrays: NSArray = ["Blood Sugar Level","Body Weight","Body Height","Blood Pressure","Smoking Status"]
    let unitArrays: NSArray = ["mg","kg","cm","mm/Hg",""]
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

    func updateChart() {
        
        pcvMHGTVCPieChart.noDataText = "No data"
        pcvMHGTVCPieChart.holeRadiusPercent = 0.95
        pcvMHGTVCPieChart.rotationAngle = 0.7
        pcvMHGTVCPieChart.rotationEnabled = false
        
        // see referral for more info: http://github.com/danielgindi/Charts/issues/2441
        
        let paraStyle: NSMutableParagraphStyle = NSMutableParagraphStyle.init()
        paraStyle.alignment = NSTextAlignment.center
        let attrib: [NSAttributedStringKey : Any] = [NSAttributedStringKey.font: UIFont.init(name: "ArialMT", size: 16.0)!, NSAttributedStringKey.paragraphStyle: paraStyle]
        let centerFontAttrib: NSAttributedString = NSAttributedString.init(string: "20.49\nBMI", attributes: attrib)
        
        pcvMHGTVCPieChart.centerAttributedText = centerFontAttrib
        
        // Disable chart description
        let desc: Description = pcvMHGTVCPieChart.chartDescription!
        desc.enabled = false
        
        // Disable chart legend
        let legend: Legend = pcvMHGTVCPieChart.legend
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
        
        pcvMHGTVCPieChart.data = chartData
        
        // nexttable
        pvcMHGTVCListOfHealth.delegate = self
        pvcMHGTVCListOfHealth.dataSource = self
        
    }
    
    //uitableview
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 5
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell2 = UITableViewCell.init(style: UITableViewCellStyle.default, reuseIdentifier: "MyHealthKGListOfHealth2CellID")
        
        // settings label
        let leftLabel: UILabel = UILabel.init(frame: CGRect.init(x: 0, y: 0, width: 40, height: 40))
        leftLabel.textAlignment = NSTextAlignment.center
        leftLabel.font = UIFont.init(name: "ArialMT", size: 12.0)
        leftLabel.lineBreakMode = NSLineBreakMode(rawValue: 0)!
        leftLabel.textColor = UIColor.white
        leftLabel.layer.backgroundColor = UIColor.purple.cgColor
        leftLabel.layer.cornerRadius = 20
        leftLabel.attributedText = NSAttributedString.init(string: "70", attributes: nil)
        
        let anotherlabel: UILabel = UILabel.init(frame: CGRect.init(x: 0, y: 5, width: 30, height: 35))
        anotherlabel.textAlignment = NSTextAlignment.center
        anotherlabel.font = UIFont.init(name: "ArialMT", size: 8.0)
        anotherlabel.textColor = UIColor.white
        anotherlabel.attributedText = NSAttributedString.init(string: unitArrays.object(at: indexPath.row) as! String, attributes: nil)
        
        let attribText: [NSAttributedStringKey: Any] = [NSAttributedStringKey.font : UIFont.init(name: "ArialMT", size: 9.0)!]
        
        cell2.imageView?.image = UIImage.imageWithLabel(label: leftLabel)
        cell2.textLabel?.attributedText = NSAttributedString.init(string: nameArrays.object(at: indexPath.row) as! String, attributes: attribText)
        cell2.imageView?.addSubview(anotherlabel)
        
        return cell2
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        // iphone 5 30.0
        
        return 30.0
     }

    
}

class MyHealthGlucoseInfoGTVCell: UITableViewCell {
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
}
