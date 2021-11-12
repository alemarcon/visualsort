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
    
    init(chartsArray: [ChartBarView], chart: UIView, duration: Double = 0.003) {
        self.chartsArray = chartsArray
        self.chart = chart
        self.duration = duration
    }
    
    /// Start bubble sort array
    func sort() {
        runFirstLoopOnArray(index: 0)
    }
    
    /// Execute first bubble sort loop on array
    /// - Parameter index: The index to start from
    private func runFirstLoopOnArray(index: Int) {
        if( index < chartsArray?.count ?? 0 ) {
            runSecondLoopOnArray(currentLoopIndex: 0, firstLoopIndex: index)
        } else {
            delegate?.sortingCompleted(sortedValues: chartsArray!)
        }
    }

    /// Execute secondo bubble sort loop on array
    /// - Parameters:
    ///   - currentLoopIndex: The index to start second loop from
    ///   - firstLoopIndex: The firts loop index
    private func runSecondLoopOnArray(currentLoopIndex: Int, firstLoopIndex: Int) {
        if( currentLoopIndex < chartsArray!.count-1 ) {
            if( chartsArray![currentLoopIndex].getChartBarValue() > chartsArray![currentLoopIndex+1].getChartBarValue() ) {
                
                if let biggerBar = chartsArray?[currentLoopIndex], let smallerBar = chartsArray?[currentLoopIndex+1] {
                    biggerBar.setColorFor(position: .selected)
                    smallerBar.setColorFor(position: .selected)
                    swapBarsNew(biggerBar: biggerBar, smallerBar: smallerBar, firstLoopIndex: firstLoopIndex, smallerBarNewIndex: currentLoopIndex, biggerBarNewIndex: currentLoopIndex+1)
                }

            } else {
                self.runSecondLoopOnArray(currentLoopIndex: currentLoopIndex+1, firstLoopIndex: firstLoopIndex)
            }
        } else {
            runFirstLoopOnArray(index: firstLoopIndex+1)
        }
    }
    
    /// Swap two bars
    /// - Parameters:
    ///   - biggerBar: The bigger value bar
    ///   - smallerBar: The smaller value bar
    ///   - firstLoopIndex: First loop index
    ///   - smallerBarNewIndex: The index where small bar will be moved
    ///   - biggerBarNewIndex: The index where bigger bar will be moved
    private func swapBarsNew(biggerBar: ChartBarView, smallerBar: ChartBarView, firstLoopIndex: Int, smallerBarNewIndex: Int, biggerBarNewIndex: Int) {
        
        UIView.animate(withDuration: duration) {
            
            let biggerBarXPosition = biggerBar.getXPosition()
            let smallerBarXPosition = smallerBar.getXPosition()
            
            self.chart.viewWithTag(biggerBar.getChartBarValue())!.frame.origin.x = smallerBarXPosition
            self.chart.viewWithTag(smallerBar.getChartBarValue())!.frame.origin.x = biggerBarXPosition
            smallerBar.setXPosition(biggerBarXPosition)
            biggerBar.setXPosition(smallerBarXPosition)
            self.chartsArray![smallerBarNewIndex] = smallerBar
            self.chartsArray![biggerBarNewIndex] = biggerBar
            
        } completion: { completed in
            if( completed ) {
                
                if( biggerBarNewIndex+1 == self.chartsArray![biggerBarNewIndex].getChartBarValue() ) {
                    biggerBar.setColorFor(position: .ordered)
                } else {
                    biggerBar.setColorFor(position: .unordered)
                }
                
                if( smallerBarNewIndex+1 == self.chartsArray![smallerBarNewIndex].getChartBarValue() ) {
                    smallerBar.setColorFor(position: .ordered)
                } else {
                    smallerBar.setColorFor(position: .unordered)
                }

                self.runSecondLoopOnArray(currentLoopIndex: smallerBarNewIndex+1, firstLoopIndex: firstLoopIndex)
            }
        }
    }
    
}
