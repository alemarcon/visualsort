//
//  BubbleSort.swift
//  sortChart
//
//  Created by Alessandro Marcon on 29/10/21.
//

import Foundation

class BubbleSort {
    
    var delegate: SortDelegate?
    private var chartsBarModelArray: [ChartBarModel]?
    
    init(chartsBarModelArray: [ChartBarModel]) {
        self.chartsBarModelArray = chartsBarModelArray
    }
    
    /// Start bubble sort array
    func sort() {
        runFirstLoopOnArray(index: 0)
    }
    
    /// Execute first bubble sort loop on array
    /// - Parameter index: The index to start from
    private func runFirstLoopOnArray(index: Int) {
        if( index < chartsBarModelArray?.count ?? 0 ) {
            runSecondLoopOnArray(currentLoopIndex: 0, firstLoopIndex: index)
        } else {
            delegate?.sortingCompleted()
        }
    }

    /// Execute secondo bubble sort loop on array
    /// - Parameters:
    ///   - currentLoopIndex: The index to start second loop from
    ///   - firstLoopIndex: The firts loop index
    private func runSecondLoopOnArray(currentLoopIndex: Int, firstLoopIndex: Int) {
        if( currentLoopIndex < chartsBarModelArray!.count-1 ) {
            if( chartsBarModelArray![currentLoopIndex].getBarValue() > chartsBarModelArray![currentLoopIndex+1].getBarValue() ) {
                
                if let _ = chartsBarModelArray {
                    
                    let currentBar = chartsBarModelArray![currentLoopIndex]
                    let nextBar = chartsBarModelArray![currentLoopIndex+1]
                    
                    chartsBarModelArray![currentLoopIndex] = nextBar
                    chartsBarModelArray![currentLoopIndex+1] = currentBar
                    
                    delegate?.updateAndSwapBar(bars: chartsBarModelArray!, swapIndexes: [currentLoopIndex, currentLoopIndex+1], completion: {
                        
                        self.chartsBarModelArray![currentLoopIndex].updatePosition(by: currentLoopIndex)
                        self.chartsBarModelArray![currentLoopIndex+1].updatePosition(by: currentLoopIndex+1)
                        self.runSecondLoopOnArray(currentLoopIndex: currentLoopIndex+1, firstLoopIndex: currentLoopIndex)
                    })
                }

            } else {
                self.runSecondLoopOnArray(currentLoopIndex: currentLoopIndex+1, firstLoopIndex: firstLoopIndex)
            }
        } else {
            runFirstLoopOnArray(index: firstLoopIndex+1)
        }
    }
    
    
}
