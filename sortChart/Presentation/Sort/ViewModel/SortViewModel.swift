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
    private var unorderedRandomValueBars = [ChartBarView]()
    private var unorderedRandomValueBarModel = [BarModel]()
    private(set) var state: CurrentValueSubject<State, Never> = .init(.none)
    
    //MARK: - Private constants
    private let NUMBER_OF_ELEMENTS = 20
    
    //MARK: - Sort algorithm objects
    private var bubbleSort: BubbleSort?
    
    //MARK: - Functions
    
    /// Generate random Int values
    func generateRandomValues() {
        state.send(.generatingRandomValues)
        unorderedRandomValueBars.removeAll()
        
        while unorderedRandomValueBars.count < Int(NUMBER_OF_ELEMENTS) {
            let randomNumber = Int.random(in: 1...Int(NUMBER_OF_ELEMENTS))
            if( unorderedRandomValueBars.first(where: ({ $0.getChartBarValue() == randomNumber })) == nil ) {
                unorderedRandomValueBars.append( ChartBarView(value: randomNumber) )
            }
        }
        // Create BarModel elements to draw bars on collection view
        unorderedRandomValueBarModel.removeAll()
        
        var index = 0
        
        while unorderedRandomValueBarModel.count < Int(NUMBER_OF_ELEMENTS) {
            let randomNumber = Int.random(in: 1...Int(NUMBER_OF_ELEMENTS))
            if( unorderedRandomValueBarModel.first(where: ({ $0.getBarValue() == randomNumber })) == nil ) {
                unorderedRandomValueBarModel.append( BarModel(value: randomNumber, indexPath: IndexPath(row: index, section: 0) ) )
                index = index+1
            }
        }
        
        state.send(.randomValuesGenerated)
    }
    
    func randomValuesCount() -> Int {
        return unorderedRandomValueBars.count
    }
    
    func getBarViewAt(index: Int) -> ChartBarView {
        if( index >= 0 && unorderedRandomValueBars.count > index ) {
            return unorderedRandomValueBars[index]
        } else {
            return ChartBarView(value: 0)
        }
    }
    
    func getNumberOfElements() -> Int {
        return NUMBER_OF_ELEMENTS
    }
    
    func getBarModelAt(index: Int) -> BarModel {
        if( index >= 0 && unorderedRandomValueBarModel.count > index ) {
            return unorderedRandomValueBarModel[index]
        } else {
            return BarModel(value: 0, indexPath: IndexPath(row: 0, section: 0))
        }
    }
    
    func getNumberOfBarModelElements() -> Int {
        return unorderedRandomValueBarModel.count
    }
    
    func sortValuesWith(algorithm: SortAlgorithm, chartView: UIView) {
        state.send(.sortingRandomValues)
        
        switch algorithm {
        case .bubbleSort:
//            let bubbleSort = BubbleSort(chartsArray: unorderedRandomValueBars, chart: chartView, duration: 0.1)
            let bubbleSort = BubbleSort(chartsArray: unorderedRandomValueBars, chartsBarModelArray: unorderedRandomValueBarModel, chart: chartView, duration: 0.1)
            bubbleSort.delegate = self
            bubbleSort.sort()
        default:
            print("Sort algorithm unknown")
        }
    }
}


extension SortViewModel: SortDelegate {
    
    func sortingCompleted(sortedValues: [ChartBarView]) {
        print("Sorting completed")
        self.unorderedRandomValueBars = sortedValues
        state.send(.randomValuesSorted)
    }
    
    func updateAndSwapBar(bars: [BarModel], swapIndexes: [Int]) {
        self.unorderedRandomValueBarModel = bars
        state.send(.swapBars(swapIndexes: swapIndexes))
    }
    
    func updateAndSwapBar(bars: [BarModel], swapIndexes: [Int], completion: @escaping () -> Void) {
        self.unorderedRandomValueBarModel = bars
        state.send(.swapBars(swapIndexes: swapIndexes))
        
        
        DispatchQueue.main.asyncAfter(deadline: DispatchTime.now()+0.05) {
            completion()
        }
    }
    
}
