//
//  NumberPickerVC.swift
//  dashboardv2
//
//  Created by Hainizam on 27/12/2017.
//  Copyright © 2017 Ingeniworks Sdn Bhd. All rights reserved.
//

import UIKit

class NumberPickerVC: UIViewController {

    @IBOutlet weak var numberPickerView: UIPickerView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var customView: UIView!
    
    var pickerData: [[String]]!
    
    var isHeight = false
    
    override func viewDidLoad() {
        super.viewDidLoad()

        numberPickerView.dataSource = self
        numberPickerView.delegate = self
        
        customView.roundedCorners(5)
        
        setupPickerView()
    }
    
    func setupPickerView() {
        
        if isHeight {
            pickerData = [["1", "2", "3", "4", "5", "6", "7", "8", "9", "0"],
                          ["."],
                          ["1", "2", "3", "4", "5", "6", "7", "8", "9", "0"],
                          ["1", "2", "3", "4", "5", "6", "7", "8", "9", "0"]]
            titleLabel.text = "Sila pilih tinggi anda dalam meter(m)."
        } else {
            pickerData = [["1", "2", "3", "4", "5", "6", "7", "8", "9", "0"],
                          ["1", "2", "3", "4", "5", "6", "7", "8", "9", "0"],
                          ["."],
                          ["1", "2", "3", "4", "5", "6", "7", "8", "9", "0"]]
            titleLabel.text = "Sila pilih lilit pinggang anda dalam centimeter(cm)."
        }
    }
    
    @IBAction func doneButtonTapped(_ sender: Any) {
        self.dismiss(animated: true)
    }
}

extension NumberPickerVC: UIPickerViewDataSource, UIPickerViewDelegate {
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return pickerData.count
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return pickerData[component].count
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return pickerData[component][row]
    }
}












