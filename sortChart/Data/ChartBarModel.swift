//
//  ChartBarModel.swift
//  sortChart
//
//  Created by Alessandro Marcon on 15/03/22.
//

import Foundation
import UIKit

enum BarPosition {
    case unordered
    case ordered
    case selected
}

class ChartBarModel {
    
    private var number: String
    private var chartBarValue: Int
    private var position: BarPosition = .unordered
    
    init(value: Int, indexPath: IndexPath) {
        self.number = "\(value)"
        self.chartBarValue = value
    }
    
    func updatePosition(by index: Int) {
        if( getBarValue()-1 == index ) {
            setPosition(position: .ordered)
        } else {
            setPosition(position: .unordered)
        }
    }
    
    func setPosition(position: BarPosition) {
        self.position = position
    }
    
    func getPosition() -> BarPosition {
        return position
    }
    
    func getBarValue() -> Int {
        return chartBarValue
    }
    
}
