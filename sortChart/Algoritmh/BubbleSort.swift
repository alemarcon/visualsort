//
//  BubbleSort.swift
//  sortChart
//
//  Created by Alessandro Marcon on 29/10/21.
//

import Foundation
import UIKit

class BubbleSort {
    
    private var array: [Int]
    private var chart: UIView
    private var duration: Double
    
    init(array: [Int], chart: UIView, duration: Double = 0.003) {
        self.array = array
        self.chart = chart
        self.duration = duration
    }
    
    func sort() {
        loopFirstArray(index: 0)
    }
    
    private func loopFirstArray(index: Int) {
        if( index < array.count ) {
            loopSecondArray(innerIndex: 0, outerIndex: index)
        }
    }
    
    private func loopSecondArray(innerIndex: Int, outerIndex: Int) {
        if( innerIndex < array.count-1 ) {
            if( array[innerIndex] > array[innerIndex+1] ) {
                
                let smallerBarX = self.chart.viewWithTag(array[innerIndex])!.frame.origin.x
                self.chart.viewWithTag(array[innerIndex])!.backgroundColor = .green
                let biggerBarX = self.chart.viewWithTag(array[innerIndex+1])!.frame.origin.x
                self.chart.viewWithTag(array[innerIndex+1])!.backgroundColor = .green
                swapBars(currentIndex: innerIndex, lowerIndex: innerIndex+1, biggerBarX: biggerBarX, smallerBarX: smallerBarX, outerIndex: outerIndex)
            } else {
                self.loopSecondArray(innerIndex: innerIndex+1, outerIndex: outerIndex)
            }
        } else {
            loopFirstArray(index: outerIndex+1)
        }
    }
    
    private func swapBars(currentIndex: Int, lowerIndex: Int, biggerBarX: CGFloat, smallerBarX: CGFloat, outerIndex: Int) {
        
        UIView.animate(withDuration: duration) {
            let tmp = self.array[currentIndex]
            self.chart.viewWithTag(tmp)!.frame.origin.x = biggerBarX
            self.chart.viewWithTag(self.array[lowerIndex])!.frame.origin.x = smallerBarX
            self.array[currentIndex] = self.array[lowerIndex]
            self.array[lowerIndex] = tmp
            
        } completion: { completed in
            if( completed ) {
                if( lowerIndex+1 == self.array[lowerIndex] ) {
                    self.chart.viewWithTag(self.array[lowerIndex])!.backgroundColor = .blue
                } else {
                    self.chart.viewWithTag(self.array[lowerIndex])!.backgroundColor = .red
                }
                
                if( currentIndex+1 == self.array[currentIndex] ) {
                    self.chart.viewWithTag(self.array[currentIndex])!.backgroundColor = .blue
                } else {
                    self.chart.viewWithTag(self.array[currentIndex])!.backgroundColor = .red
                }
                
                
                self.loopSecondArray(innerIndex: currentIndex+1, outerIndex: outerIndex)
            }
        }
    }
    
}
