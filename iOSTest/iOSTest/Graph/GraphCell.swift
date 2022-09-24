//  GraphCell.swift
//  iOSTest
//  Created by Guillermo Romo Jiménez on 23/09/22.

import UIKit
import Charts

class GraphCell: UITableViewCell {
    
    let label =  UILabel(frame: CGRect(x: 16, y: 00, width: 300, height: 70))
    var chart = PieChartView(frame: CGRect(x: 16, y: 80, width: 400, height: 360))

    override func awakeFromNib() {
        super.awakeFromNib()
    }

    func configureCell(text: String, texts: [String], percentages: [Double]){
        self.addSubview(label)
        self.addSubview(chart)
        
        label.numberOfLines = 0
        label.text = text
        self.backgroundColor = UIColor(red: 0.90578,
                                       green: 0.92921,
                                       blue: 0.98046,
                                       alpha: 0.60)
        
        /// Configuring chart porperties
        chart.holeRadiusPercent = 0.90
        chart.holeColor = UIColor.clear
        
        chart.usePercentValuesEnabled = false
        chart.legend.enabled = true
        chart.drawEntryLabelsEnabled = false
        chart.legend.direction = .rightToLeft
        
        /// Configuring chart data
        setChart(dataPoints: texts, values: percentages)
    }
    
    func setChart(dataPoints: [String], values: [Double]) {
        var dataEntries: [ChartDataEntry] = []
        for i in 0..<dataPoints.count {
            let dataEntry1 = PieChartDataEntry()
            dataEntry1.y = values[i]
            dataEntry1.x = Double(i)
            dataEntry1.label = "\(dataPoints[i]) \(values[i])%"
            dataEntries.append(dataEntry1)
        }
        
        chart.animate(xAxisDuration: TimeInterval(1))
        
        let pieChartDataSet = PieChartDataSet(entries: dataEntries, label: " ")
        let pieChartData = PieChartData(dataSet: pieChartDataSet)
        
        let colors: [UIColor] = [UIColor.systemGreen,UIColor.systemRed,UIColor.systemYellow,
                                 UIColor.systemCyan,UIColor.systemBlue,UIColor.systemOrange]
        
        pieChartDataSet.colors = colors
        
        chart.data = pieChartData
    }
    
}
