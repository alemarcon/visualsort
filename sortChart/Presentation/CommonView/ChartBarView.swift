//
//  ChartBarView.swift
//  sortChart
//
//  Created by Alessandro Marcon on 03/11/21.
//

import Foundation
import UIKit

enum Position {
    case unordered
    case ordered
    case selected
}

class ChartBarView: UIView {
    
    //MARK: - Variables
    private var xPosition: CGFloat
    private var yPosition: CGFloat
    private var numberLabel: UILabel?
    private var chartBarValue: Int
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    init(value: Int) {
        self.chartBarValue = value
        self.xPosition = 0
        self.yPosition = 0
        super.init(frame: CGRect(x: 0, y: 0, width: 0, height: 0))
        
        self.tag = chartBarValue
        self.roundCorner(radius: 2.0)
        setColorFor(position: .unordered)
        prepareLabel()
    }
    
    func setupBarFrame(x: CGFloat, y: CGFloat, h: CGFloat, w: CGFloat) {
        self.frame = CGRect(x: x, y: y, width: w, height: h)
        xPosition = x
        yPosition = y
    }
    
    private func prepareLabel() {
        numberLabel = UILabel()
        numberLabel?.text = "\(chartBarValue)"
        numberLabel?.translatesAutoresizingMaskIntoConstraints = false
        numberLabel?.font = UIFont.systemFont(ofSize: 5, weight: .semibold)
        numberLabel?.textAlignment = .center
        numberLabel?.textColor = .white
        numberLabel?.numberOfLines = 1
        numberLabel?.sizeToFit()
        
        if let lbl = numberLabel {
            self.addSubview(lbl)
            self.addConstraints([
                lbl.topAnchor.constraint(equalTo: self.topAnchor, constant: 5),
                lbl.centerXAnchor.constraint(equalTo: self.centerXAnchor)
            ])
        }
    }
    
    func getXPosition() -> CGFloat {
        return xPosition
    }
    
    func setXPosition(_ x: CGFloat) {
        xPosition = x
        self.frame.origin.x = x
    }
    
    func getYPosition() -> CGFloat {
        return yPosition
    }
    
    func setYPosition(_ y: CGFloat) {
        yPosition = y
        self.frame.origin.y = y
    }
    
    func getChartBarValue() -> Int {
        return chartBarValue
    }
    
    func setChartBarValue(_ value: Int) {
        self.chartBarValue = value
    }
    
    func setColorFor(position: Position) {
        switch position {
        case .unordered:
            self.backgroundColor = UIColor.Custom.unordered
        case .ordered:
            self.backgroundColor = UIColor.Custom.ordered
        case .selected:
            self.backgroundColor = UIColor.Custom.selected
        }
    }
}
