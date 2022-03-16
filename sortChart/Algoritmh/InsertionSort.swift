//
//  InsertionSort.swift
//  sortChart
//
//  Created by Alessandro Marcon on 16/03/22.
//

import Foundation

class InsertionSort {
    
    var delegate: SortDelegate?
    private var chartsBarModelArray: [ChartBarModel]?
    private var isLaunchedForUpdateUI = false
    
    init(chartsBarModelArray: [ChartBarModel]) {
        self.chartsBarModelArray = chartsBarModelArray
    }
    
    func sort() {
        runExternalLoop(externalIndex: 1)
    }
    
    func runExternalLoop(externalIndex: Int) {
            let arrayLenght = chartsBarModelArray!.count
            if( externalIndex < arrayLenght ) {
                
                let externalLoopElement = chartsBarModelArray![externalIndex]
                let internalLoopIndex = externalIndex-1
                internalLoop(internalLoopIndex: internalLoopIndex, externalLoopElement: externalLoopElement, externalLoopIndex: externalIndex)
            } else {
                // Bad decision but need for collection view UI refresh problem. To analyze and correct
                if( !isLaunchedForUpdateUI ) {
                    isLaunchedForUpdateUI = true
                    sort()
                } else {
                    delegate?.sortingCompleted()
                }
            }
    }
    
    func internalLoop(internalLoopIndex: Int, externalLoopElement: ChartBarModel, externalLoopIndex: Int) {
        
        if( internalLoopIndex >= 0 && chartsBarModelArray![internalLoopIndex].getBarValue() > externalLoopElement.getBarValue() ) {
            chartsBarModelArray![internalLoopIndex+1] = chartsBarModelArray![internalLoopIndex]
            
            self.chartsBarModelArray![internalLoopIndex+1].updatePosition(by: internalLoopIndex+1)
            self.chartsBarModelArray![internalLoopIndex].updatePosition(by: internalLoopIndex)
            
            delegate?.updateAndSwapBar(bars: chartsBarModelArray!, swapIndexes: [internalLoopIndex+1, internalLoopIndex], completion: {
                self.internalLoop(internalLoopIndex: internalLoopIndex-1, externalLoopElement: externalLoopElement, externalLoopIndex: externalLoopIndex)
            })
            
        } else {
            chartsBarModelArray![internalLoopIndex+1] = externalLoopElement
            self.chartsBarModelArray![internalLoopIndex+1].updatePosition(by: internalLoopIndex+1)
            self.chartsBarModelArray![externalLoopIndex].updatePosition(by: externalLoopIndex)
            
            delegate?.updateAndSwapBar(bars: chartsBarModelArray!, swapIndexes: [internalLoopIndex+1, internalLoopIndex], completion: {
                self.runExternalLoop(externalIndex: externalLoopIndex+1)
            })
        }
    }
}
