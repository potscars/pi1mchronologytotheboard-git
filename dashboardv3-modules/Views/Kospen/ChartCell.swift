//
//  ChartCell.swift
//  dashboardv2
//
//  Created by Hainizam on 22/11/2017.
//  Copyright © 2017 Ingeniworks Sdn Bhd. All rights reserved.
//

import UIKit
import Charts

class ChartCell: UITableViewCell {
    
    @IBOutlet weak var chartView: LineChartView!
    
    func setupChartView(_ yAxisMinimum: Double, yAxisMaximum: Double, xAxisMinimum: Double, xAxisMaximum: Double) {
        chartView.chartDescription?.enabled = false
        chartView.dragEnabled = true
        chartView.setScaleEnabled(true)
        chartView.pinchZoomEnabled = false
        chartView.rightAxis.enabled = false
        chartView.doubleTapToZoomEnabled = false
        
        let l = chartView.legend
        l.form = .line
        l.font = UIFont(name: "HelveticaNeue-Light", size: 11)!
        l.textColor = .orange
        l.horizontalAlignment = .left
        l.verticalAlignment = .bottom
        l.orientation = .horizontal
        l.drawInside = false
        
        let xAxis = chartView.xAxis
        xAxis.labelFont = .systemFont(ofSize: 11)
        xAxis.labelTextColor = .black
        xAxis.drawAxisLineEnabled = true
        xAxis.axisMinimum = xAxisMinimum
        xAxis.axisMaximum = xAxisMaximum
        xAxis.labelPosition = .bottom
        
        let leftAxis = chartView.leftAxis
        leftAxis.labelTextColor = UIColor(red: 51/255, green: 181/255, blue: 229/255, alpha: 1)
        leftAxis.axisMaximum = yAxisMaximum
        leftAxis.axisMinimum = yAxisMinimum
        leftAxis.drawGridLinesEnabled = true
        leftAxis.granularityEnabled = false
    }
    
    func feedTheChartWithData(_ data: [ChartDataEntry], nameLabel: String) {
        
        let lineChartDataSet = LineChartDataSet(values: data, label: nameLabel)
        let lineChartData = LineChartData(dataSet: lineChartDataSet)
        
        chartView.data = lineChartData
    }
    
    func updateBMICharts(_ bmiData: [GraphData], dateArray: [Int]) {
        
        setupChartView(0, yAxisMaximum: 40, xAxisMinimum: 1, xAxisMaximum: 30)
        
        var dataEntries: [ChartDataEntry] = []

        for (index, value) in bmiData.enumerated() {
            print(dateArray[index])
            let dataEntry = ChartDataEntry(x: Double(dateArray[index]), y: Double(value.bmi!))
            dataEntries.append(dataEntry)
        }
        feedTheChartWithData(dataEntries, nameLabel: "BMI")
    }
    
    func updateGlucoseCharts(_ glucoseData: [GraphData], dateArray: [Int]) {
        
        setupChartView(0, yAxisMaximum: 10, xAxisMinimum: 1, xAxisMaximum: 30)
        
        var dataEntries: [ChartDataEntry] = []
        
        for (index, value) in glucoseData.enumerated() {
            print(dateArray[index])
            let dataEntry = ChartDataEntry(x: Double(dateArray[index]), y: Double(value.glucoseLevel!))
            dataEntries.append(dataEntry)
        }
        feedTheChartWithData(dataEntries, nameLabel: "Glucose Level")
    }
    
    func updateBloodPressureCharts(_ bloodPressureData: [GraphData], dateArray: [Int]) {
        
        setupChartView(50, yAxisMaximum: 200, xAxisMinimum: 40, xAxisMaximum: 100)
        
        var dataEntries: [ChartDataEntry] = []
        
        for (index, value) in bloodPressureData.enumerated() {
            let dataEntry = ChartDataEntry(x: Double(value.dys!), y: Double(value.sys!))
            dataEntries.append(dataEntry)
        }
        feedTheChartWithData(dataEntries, nameLabel: "Blood Pressure")
    }
}













