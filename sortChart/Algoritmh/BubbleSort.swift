//
//  BubbleSort.swift
//  sortChart
//
//  Created by Alessandro Marcon on 29/10/21.
//

import Foundation
import UIKit

class BubbleSort {
    
    var delegate: SortDelegate?
    private var chartsArray: [ChartBarView]?
    private var chart: UIView
    private var duration: Double
    
    //MARK: - Constants
//    private let UNORDERED_BAR_COLOR: UIColor = .red
//    private let ORDERED_BAR_COLOR: UIColor = .blue
//    private let SELECTED_BAR_COLOR: UIColor = .green
    
    init(chartsArray: [ChartBarView], chart: UIView, duration: Double = 0.003) {
        self.chartsArray = chartsArray
        self.chart = chart
        self.duration = duration
    }
    
    func sort() {
        loopFirstArray(index: 0)
    }
    
    private func loopFirstArray(index: Int) {
        if( index < chartsArray?.count ?? 0 ) {
            loopSecondArrayNew(innerIndex: 0, outerIndex: index)
        } else {
            delegate?.sortCompleted(sortedValues: chartsArray!)
        }
    }
    
    
    private func loopSecondArrayNew(innerIndex: Int, outerIndex: Int) {
        if( innerIndex < chartsArray!.count-1 ) {
            if( chartsArray![innerIndex].getChartBarValue() > chartsArray![innerIndex+1].getChartBarValue() ) {
                
                if let biggerBar = chartsArray?[innerIndex], let smallerBar = chartsArray?[innerIndex+1] {
                    biggerBar.setColorFor(position: .selected)
                    smallerBar.setColorFor(position: .selected)
                    swapBarsNew(biggerBar: biggerBar, smallerBar: smallerBar, outerIndex: outerIndex, currentIndex: innerIndex, lowerIndex: innerIndex+1)
                }

            } else {
                self.loopSecondArrayNew(innerIndex: innerIndex+1, outerIndex: outerIndex)
            }
        } else {
            loopFirstArray(index: outerIndex+1)
        }
    }
    
    private func swapBarsNew(biggerBar: ChartBarView, smallerBar: ChartBarView, outerIndex: Int, currentIndex: Int, lowerIndex: Int) {
        
        UIView.animate(withDuration: duration) {
            
            let biggerBarXPosition = biggerBar.getXPosition()
            let smallerBarXPosition = smallerBar.getXPosition()
            
            self.chart.viewWithTag(biggerBar.getChartBarValue())!.frame.origin.x = smallerBarXPosition
            self.chart.viewWithTag(smallerBar.getChartBarValue())!.frame.origin.x = biggerBarXPosition
            smallerBar.setXPosition(biggerBarXPosition)
            biggerBar.setXPosition(smallerBarXPosition)
            self.chartsArray![currentIndex] = smallerBar
            self.chartsArray![lowerIndex] = biggerBar
            
        } completion: { completed in
            if( completed ) {
                
                if( lowerIndex+1 == self.chartsArray![lowerIndex].getChartBarValue() ) {
                    biggerBar.setColorFor(position: .ordered)
                } else {
                    biggerBar.setColorFor(position: .unordered)
                }
                
                if( currentIndex+1 == self.chartsArray![currentIndex].getChartBarValue() ) {
                    smallerBar.setColorFor(position: .ordered)
                } else {
                    smallerBar.setColorFor(position: .unordered)
                }

                self.loopSecondArrayNew(innerIndex: currentIndex+1, outerIndex: outerIndex)
            }
        }
    }
    
}
