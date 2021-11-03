//
//  SortViewModel.swift
//  sortChart
//
//  Created by Alessandro Marcon on 02/11/21.
//

import Foundation
import Combine
import UIKit

enum Algorithm {
    case bubbleSort
}

class SortViewModel {
    
    //MARK: - View model state
    enum State {
        case none
        case generatingRandomValues
        case randomValuesGenerated
        case sortingRandomValues
        case randomValuesSorted
    }
    
    //MARK: - Private properties
    private var unorderedRandomValueBars = [ChartBarView]()
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
        
        state.send(.randomValuesGenerated)
    }
    
    func randomValuesCount() -> Int {
        return unorderedRandomValueBars.count
    }
    
    func getBarAt(index: Int) -> ChartBarView {
        if( index >= 0 && unorderedRandomValueBars.count > index ) {
            return unorderedRandomValueBars[index]
        } else {
            return ChartBarView(value: 0)
        }
    }
    
    func getNumberOfElements() -> Int {
        return NUMBER_OF_ELEMENTS
    }
    
    func sortValuesWith(algorithm: Algorithm, chartView: UIView) {
        state.send(.sortingRandomValues)
        
        switch algorithm {
        case .bubbleSort:
            let bubbleSort = BubbleSort(chartsArray: unorderedRandomValueBars, chart: chartView, duration: 0.1)
            bubbleSort.delegate = self
            bubbleSort.sort()
        }
    }
}


extension SortViewModel: SortDelegate {
    
    func sortCompleted(sortedValues: [ChartBarView]) {
        print("Sorting completed")
        self.unorderedRandomValueBars = sortedValues
        state.send(.randomValuesSorted)
    }
    
}
