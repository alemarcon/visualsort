//
//  SortViewModel.swift
//  sortChart
//
//  Created by Alessandro Marcon on 02/11/21.
//

import Foundation
import Combine
import UIKit

class SortViewModel {
    
    //MARK: - View model state
    enum State {
        case none
        case generatingRandomValues
        case randomValuesGenerated
        case sortingRandomValues
        case randomValuesSorted
        case swapBars(swapIndexes: [Int])
    }
    
    //MARK: - Private properties
    private var unorderedRandomValueBarModel = [ChartBarModel]()
    private(set) var state: CurrentValueSubject<State, Never> = .init(.none)
    
    //MARK: - Private constants
    private let NUMBER_OF_ELEMENTS = 20
    
    //MARK: - Sort algorithm objects
    private var bubbleSort: BubbleSort?
    
    //MARK: - Functions
    
    /// Generate random Int values
    func generateRandomValues() {
        state.send(.generatingRandomValues)
        var index = 0
        
        unorderedRandomValueBarModel.removeAll()
        
        while unorderedRandomValueBarModel.count < Int(NUMBER_OF_ELEMENTS) {
            let randomNumber = Int.random(in: 1...Int(NUMBER_OF_ELEMENTS))
            if( unorderedRandomValueBarModel.first(where: ({ $0.getBarValue() == randomNumber })) == nil ) {
                unorderedRandomValueBarModel.append( ChartBarModel(value: randomNumber, indexPath: IndexPath(row: index, section: 0) ) )
                index = index+1
            }
        }
        
        state.send(.randomValuesGenerated)
    }
    
    func getBarModelAt(index: Int) -> ChartBarModel {
        if( index >= 0 && unorderedRandomValueBarModel.count > index ) {
            return unorderedRandomValueBarModel[index]
        } else {
            return ChartBarModel(value: 0, indexPath: IndexPath(row: 0, section: 0))
        }
    }
    
    func getNumberOfBarModelElements() -> Int {
        return unorderedRandomValueBarModel.count
    }
    
    func sortValuesWith(algorithm: SortAlgorithm, chartView: UIView) {
        state.send(.sortingRandomValues)
        
        switch algorithm {
        case .bubbleSort:
            let bubbleSort = BubbleSort(chartsBarModelArray: unorderedRandomValueBarModel)
            bubbleSort.delegate = self
            bubbleSort.sort()
        default:
            print("Sort algorithm unknown")
        }
    }
}


extension SortViewModel: SortDelegate {
    
    func sortingCompleted() {
        print("Sorting completed")
        state.send(.randomValuesSorted)
    }
    
    func updateAndSwapBar(bars: [ChartBarModel], swapIndexes: [Int], completion: @escaping () -> Void) {
        self.unorderedRandomValueBarModel = bars
        state.send(.swapBars(swapIndexes: swapIndexes))
        
        DispatchQueue.main.asyncAfter(deadline: DispatchTime.now()+0.05) {
            completion()
        }
    }
    
}
