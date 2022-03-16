//
//  SelectionSort.swift
//  sortChart
//
//  Created by Alessandro Marcon on 16/03/22.
//

import Foundation

class SelectionSort {
    
    var delegate: SortDelegate?
    private var chartsBarModelArray: [ChartBarModel]?
    
    init(chartsBarModelArray: [ChartBarModel]) {
        self.chartsBarModelArray = chartsBarModelArray
    }
    
    func sort() {
        firstLoop(fromIndex: 0)
    }
    
    func firstLoop(fromIndex: Int) {
        
        if( fromIndex < chartsBarModelArray!.count-1 ) {
            let arrayLenght = chartsBarModelArray!.count
            
            if( fromIndex < arrayLenght-1 ) {
                secondLoop(arrayLenght: arrayLenght, externalLoopIndex: fromIndex)
            } else {
                delegate?.sortingCompleted()
            }
        } else {
            delegate?.sortingCompleted()
        }
    }
    
    
    func secondLoop(arrayLenght: Int, externalLoopIndex: Int) {
        var minimumElementIndex = externalLoopIndex
        for currentLoopIndex in externalLoopIndex+1..<arrayLenght {
            if( chartsBarModelArray![currentLoopIndex].getBarValue() < chartsBarModelArray![minimumElementIndex].getBarValue() ) {
                minimumElementIndex = currentLoopIndex
            }
        }
        
        let minimumValueObject = chartsBarModelArray![minimumElementIndex]
        let externalLoopObject = chartsBarModelArray![externalLoopIndex]
        
        chartsBarModelArray![minimumElementIndex] = externalLoopObject
        chartsBarModelArray![externalLoopIndex] = minimumValueObject
        
        self.chartsBarModelArray![minimumElementIndex].updatePosition(by: minimumElementIndex)
        self.chartsBarModelArray![externalLoopIndex].updatePosition(by: externalLoopIndex)
        
        delegate?.updateAndSwapBar(bars: chartsBarModelArray!, swapIndexes: [minimumElementIndex, externalLoopIndex], completion: {
            self.firstLoop(fromIndex: externalLoopIndex+1)
        })
    }
    
}
