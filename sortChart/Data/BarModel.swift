//
//  BarModel.swift
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

class BarModel {
    
    private var number: String
    private var chartBarValue: Int
    private var indexPath: IndexPath
    private var position: BarPosition = .unordered
    
    init(value: Int, indexPath: IndexPath) {
        self.number = "\(value)"
        self.chartBarValue = value
        self.indexPath = indexPath
    }
    
    func setIndexPath(indexPath: IndexPath) {
        self.indexPath = indexPath
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
